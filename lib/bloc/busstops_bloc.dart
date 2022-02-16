import 'dart:async';
import 'package:bus_app/models/stop_model.dart';
import 'package:bus_app/resources/stops_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';

class BusStopsBloc {
  final _busStops = BehaviorSubject<List<BusStopModel>>();
  final _currentPosition = BehaviorSubject<LatLng>();

  void fetchStops() async {
    // while (true) {
    //   await Future.delayed(const Duration(milliseconds: 2000));
    final geoposition = await getCurrentPosition();
    final busStops = await callApiBusStops();
    final nearestBusStops = await getClosetBusStops(busStops, geoposition);
    _busStops.sink.add(nearestBusStops);
    _currentPosition.add(geoposition);
    // }
  }

  Stream<List<BusStopModel>> get busStops => _busStops.stream;

  Stream<LatLng> get currentPosition => _currentPosition.stream;

  void dispose() {
    _busStops.close();
    _currentPosition.close();
  }
}
