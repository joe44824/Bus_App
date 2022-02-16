// To parse this JSON data, do
//
//     final busStopsModel = busStopsModelFromJson(jsonString);

import 'dart:convert';

BusStopsModel busStopsModelFromJson(String str) =>
    BusStopsModel.fromJson(jsonDecode(str));

String busStopsModelToJson(BusStopsModel data) => json.encode(data.toJson());

class BusStopsModel {
  BusStopsModel({
    required this.value,
  });

  List<BusStopModel> value;

  factory BusStopsModel.fromJson(Map<String, dynamic> json) => BusStopsModel(
        value: List<BusStopModel>.from(
            json["value"].map((x) => BusStopModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "value": List<dynamic>.from(value.map((x) => x.toJson())),
      };
}

class BusStopModel {
  BusStopModel({
    required this.busStopCode,
    required this.roadName,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  String busStopCode;
  String roadName;
  String description;
  double latitude;
  double longitude;

  factory BusStopModel.fromJson(Map<String, dynamic> json) => BusStopModel(
        busStopCode: json["BusStopCode"] ?? "",
        roadName: json["RoadName"] ?? "",
        description: json["Description"] ?? "",
        latitude: json["Latitude"].toDouble() ?? 0,
        longitude: json["Longitude"].toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "BusStopCode": busStopCode,
        "RoadName": roadName,
        "Description": description,
        "Latitude": latitude,
        "Longitude": longitude,
      };
}
