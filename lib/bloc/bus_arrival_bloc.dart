import 'dart:async';

import 'package:bus_app/models/service_model.dart';
import 'package:bus_app/resources/bus_arrival_api.dart';

class BusArrivalBloc {
  final _busArrivals = StreamController<List<ServiceModel>>.broadcast();

  Future<void> fetchTimings(String busStopCode) async {
    final busTimings = await callApiBusTimings(busStopCode);
    final services = busTimings.services
        .map((service) => ServiceModel(service: service))
        .toList();
    

    _busArrivals.sink.add(services);
  }

  Stream<List<ServiceModel>> get services => _busArrivals.stream;

  void dispose() {
    print('Bus Arrival Bloc is closed');
    _busArrivals.close();
  }
}
