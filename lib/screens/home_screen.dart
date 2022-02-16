import 'package:bus_app/bloc/busstops_bloc.dart';
import 'package:bus_app/bloc/busstops_provider.dart';
import 'package:bus_app/models/stop_model.dart';
import 'package:bus_app/widgets/bus_row.dart';
import 'package:bus_app/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const routeName = 'homeScreeen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  int currentNavIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      // Close fetchStops
    } else {
      // Start fetchStops
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BusStopsProvider.of(context);
    bloc.fetchStops();
    return Scaffold(
      body: Column(
        children: [builderMap(bloc), Expanded(child: builderList(bloc))],
      ),
    );
  }

/////////////// METHODS & WIDGETS ///////////////////////////////

  Widget builderMap(BusStopsBloc bloc) {
    return StreamBuilder2<List<BusStopModel>, LatLng>(
        streams: Tuple2(bloc.busStops, bloc.currentPosition),
        builder: (context, snapshot) {
          if (!snapshot.item1.hasData) {
            return const Text("");
          }

          return Map(
              busStops: snapshot.item1.data!,
              currentPosition: snapshot.item2.data!);
        });
  }

  Widget builderList(BusStopsBloc bloc) {
    return StreamBuilder<List<BusStopModel>>(
        stream: bloc.busStops,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }

          return ListView.builder(
              padding: const EdgeInsets.only(top: 4),
              shrinkWrap: true,
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return BusRow(busStop: snapshot.data![index]);
              });
        });
  }
}
