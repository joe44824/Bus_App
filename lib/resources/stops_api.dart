// ignore_for_file: avoid_print

import 'package:bus_app/models/stop_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:math';

const _url = "http://datamall2.mytransport.sg/ltaodataservice/BusStops?\$skip=";
const _header = {
  "AccountKey": 'w6+sjSwYR5+tPSfdOJJS+A==',
};

Future<List<BusStopModel>> callApiBusStops() async {
  final responsesOne = await Future.wait(List.generate(
      3,
      (index) => http.get(Uri.parse(_url + (index * 500).toString()),
          headers: _header)));

  final responsesTwo = await Future.wait(List.generate(
      3,
      (index) => http.get(Uri.parse(_url + ((index + 3) * 500).toString()),
          headers: _header)));

  final responsesThree = await Future.wait(List.generate(
      3,
      (index) => http.get(Uri.parse(_url + ((index + 6) * 500).toString()),
          headers: _header)));

  final responsesFour = await Future.wait(List.generate(
      2,
      (index) => http.get(Uri.parse(_url + ((index + 9) * 500).toString()),
          headers: _header)));

  var responses = responsesOne + responsesTwo + responsesThree + responsesFour;

  List<BusStopModel> busStops = [];

  for (var res in responses) {
    List<BusStopModel> data = busStopsModelFromJson(res.body).value;
    busStops += data;
  }

  return busStops;
}

Future<LatLng> getCurrentPosition() async {
  final geoposition = await Geolocator.getCurrentPosition();
  return LatLng(geoposition.latitude, geoposition.longitude);
}

Future<List<BusStopModel>> getClosetBusStops(
    List<BusStopModel> busStops, LatLng geoposition) async {
  List<BusStopModel> sortedBusStops = [];

  busStops.sort(
    (b1, b2) => (distance(b1.latitude, b1.longitude, geoposition.latitude,
            geoposition.longitude))
        .compareTo(
      distance(b2.latitude, b2.longitude, geoposition.latitude,
          geoposition.longitude),
    ),
  );

  for (int i = 0; i < 8; i++) {
    sortedBusStops.add(busStops[i]);
  }

  return sortedBusStops;
}

double distance(lat1, lon1, lat2, lon2) {
  var p = 0.017453292519943295;
  var c = cos;
  var a = 0.5 -
      c((lat2 - lat1) * p) / 2 +
      c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
