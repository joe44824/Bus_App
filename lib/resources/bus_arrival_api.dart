import 'dart:convert';

import '../models/bus_arrival_model.dart';
import 'package:http/http.dart' as http;

Future<BusTimingsModel> callApiBusTimings(String busStopCode) async {
  final response = await http.get(
    Uri.parse(
        'http://datamall2.mytransport.sg/ltaodataservice/BusArrivalv2?BusStopCode=' +
            busStopCode),
    headers: {
      "AccountKey": 'w6+sjSwYR5+tPSfdOJJS+A==',
    },
  );

  var body = response.body;
  BusTimingsModel data = BusTimingsModel.fromJson(jsonDecode(body));

  return data;
}
