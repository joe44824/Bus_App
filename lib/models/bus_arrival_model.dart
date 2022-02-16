// To parse this JSON data, do
//
//     final buses = busesFromJson(jsonString);

import 'dart:convert';

BusTimingsModel busesFromJson(String str) =>
    BusTimingsModel.fromJson(json.decode(str));

String busesToJson(BusTimingsModel data) => json.encode(data.toJson());

class BusTimingsModel {
  BusTimingsModel({
    required this.busStopCode,
    required this.services,
  });

  final String busStopCode;
  final List<Service> services;

  factory BusTimingsModel.fromJson(Map<String, dynamic> json) =>
      BusTimingsModel(
        busStopCode: json["BusStopCode"],
        services: List<Service>.from(
            json["Services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "BusStopCode": busStopCode,
        "Services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Service {
  Service({
    required this.serviceNo,
    required this.serviceOperator,
    required this.nextBus,
    required this.nextBus2,
    required this.nextBus3,
  });
  final String serviceNo;
  final String serviceOperator;
  final NextBus nextBus;
  final NextBus nextBus2;
  final NextBus nextBus3;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceNo: json["ServiceNo"],
        serviceOperator: json["Operator"],
        nextBus: NextBus.fromJson(json["NextBus"]),
        nextBus2: NextBus.fromJson(json["NextBus2"]),
        nextBus3: NextBus.fromJson(json["NextBus3"]),
      );

  Map<String, dynamic> toJson() => {
        "ServiceNo": serviceNo,
        "Operator": serviceOperator,
        "NextBus": nextBus.toJson(),
        "NextBus2": nextBus2.toJson(),
        "NextBus3": nextBus3.toJson(),
      };
}

class NextBus {
  NextBus({
    required this.originCode,
    required this.destinationCode,
    required this.estimatedArrival,
    required this.latitude,
    required this.longitude,
    required this.visitNumber,
    required this.load,
    required this.feature,
    required this.type,
  });

  final String originCode;
  final String destinationCode;
  final String estimatedArrival;
  final String latitude;
  final String longitude;
  final String visitNumber;
  final String load;
  final String feature;
  final String type;

  factory NextBus.fromJson(Map<String, dynamic> json) => NextBus(
        originCode: json["OriginCode"],
        destinationCode: json["DestinationCode"],
        estimatedArrival: json["EstimatedArrival"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        visitNumber: json["VisitNumber"],
        load: json["Load"],
        feature: json["Feature"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "OriginCode": originCode,
        "DestinationCode": destinationCode,
        "EstimatedArrival": estimatedArrival,
        "Latitude": latitude,
        "Longitude": longitude,
        "VisitNumber": visitNumber,
        "Load": load,
        "Feature": feature,
        "Type": type,
      };
}
