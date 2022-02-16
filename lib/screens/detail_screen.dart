import 'dart:async';

import 'package:bus_app/bloc/bus_arrival_bloc.dart';
import 'package:bus_app/bloc/bus_arrival_provider.dart';
import 'package:bus_app/models/service_model.dart';
import 'package:bus_app/models/stop_model.dart';
import 'package:bus_app/widgets/service_row.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = 'detailScreeen';

  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with WidgetsBindingObserver {
  late BusArrivalBloc bloc;
  late String busStopCode;

  Timer? timer;
  Duration duration = const Duration();

  @override
  void initState() {
    startTimer();
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

    // if (isBackground) {
    //   stopTimer();
    //   print('page is in back ground');
    // }

    if (isBackground) {
      print('app is in background');
      stopTimer();
    } else {
      startTimer();
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      bloc.fetchTimings(busStopCode);
    });
  }

  void stopTimer() {
    setState(() {
      timer?.cancel();
    });
  }

  void backButton() {
    stopTimer();
    Navigator.of(context).pushNamed(MainScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final busStop = ModalRoute.of(context)?.settings.arguments as BusStopModel;
    bloc = BusArrivalProvider.of(context);
    busStopCode = busStop.busStopCode;
    // bloc.fetchTimings(busStopCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(busStop.description),
        leading: IconButton(
            onPressed: backButton, icon: const Icon(Icons.arrow_back_ios_new)),
      ),
      body: builderList(bloc),
    );
  }

  Widget builderList(BusArrivalBloc bloc) {
    return StreamBuilder<List<ServiceModel>>(
        stream: bloc.services,
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
                return ServiceRow(
                  service: snapshot.data![index],
                  busStopCode: busStopCode,
                );
              });
        });
  }
}
