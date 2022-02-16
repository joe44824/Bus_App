import 'dart:async';

import 'package:bus_app/models/service_model.dart';
import 'package:bus_app/resources/bus_arrival_api.dart';

class BusNotiBloc {
  final _busNoti = StreamController<List<ServiceModel>>.broadcast();

  Future<void> fetchTimingsFromNoti(String busStopCode) async {
    final busTimings = await callApiBusTimings(busStopCode);
    final services = busTimings.services
        .map((service) => ServiceModel(service: service))
        .toList();

    _busNoti.sink.add(services);
  }

  Stream<List<ServiceModel>> get services => _busNoti.stream;

  void dispose() {
    print('Bus Noti Bloc is closed');
    _busNoti.close();
  }
}
