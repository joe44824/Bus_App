import '../models/bus_arrival_model.dart';

class ServiceModel {
  final Service service;

  ServiceModel({required this.service});

  int _convertTimeStamp(String estimatedArrival) {
    var currentTime = DateTime.now();
    var busArrivalTime = DateTime.parse(estimatedArrival);
    return busArrivalTime.difference(currentTime).inMinutes;
  }

  // bool setNotification(int duration, String busStopCode, bool isStarted) {
  //   String estimatedArrival = service.nextBus.estimatedArrival;
  //   int min = _convertTimeStamp(estimatedArrival);

  //   print("Bus ${service.serviceNo} at BusStop $busStopCode : $min ");

  //   if (min == duration || (isStarted == false)) {
  //     isStarted = false;
  //     NotificationApi.showNotification(
  //         payload: busStopCode,
  //         body: "Bus ${service.serviceNo} is reaching in 5 mins");
  //   }
  // }

  String _convertToMin(String estimatedArrival) {
    // var currentTime = DateTime.now();
    // var busArrivalTime = DateTime.parse(estimatedArrival);
    // var difference = busArrivalTime.difference(currentTime).inMinutes;

    int difference = _convertTimeStamp(estimatedArrival);

    if (difference <= -1) {
      return "Left";
    } else if (difference < 1 && difference >= 0) {
      return "Arr.";
    } else {
      return difference.toString();
    }
  }

  String _generateBusType(String type, String load) {
    if (type == 'SD' && load == 'SEA') {
      return 'assets/images/green_single_bus.jpeg';
    } else if (type == 'SD' && load == 'SDA') {
      return 'assets/images/yellow_single_bus.jpeg';
    } else if (type == 'SD' && load == 'LSD') {
      return 'assets/images/red_single_bus.jpeg';
    } else if (type == 'DD' && load == 'SEA') {
      return 'assets/images/green_double_bus.jpeg';
    } else if (type == 'DD' && load == 'SDA') {
      return 'assets/images/yellow_double_bus.jpeg';
    } else if (type == 'DD' && load == 'LSD') {
      return 'assets/images/red_double_bus.jpeg';
    } else if (type == 'BD' && load == 'SEA') {
      return 'assets/images/green_long_bus.jpeg';
    } else if (type == 'BD' && load == 'SDA') {
      return 'assets/images/yellow_long_bus.jpeg';
    } else if (type == 'BD' && load == 'LSD') {
      return 'assets/images/red_long_bus.jpeg';
    } else {
      return 'assets/images/invalid_bus.jpeg';
    }
  }

  String get getBus1Image {
    return _generateBusType(service.nextBus.type, service.nextBus.load);
  }

  String get getBus2Image {
    return _generateBusType(service.nextBus2.type, service.nextBus2.load);
  }

  String get getBus3Image {
    return _generateBusType(service.nextBus3.type, service.nextBus3.load);
  }

  String get getServiceNo {
    return service.serviceNo;
  }

  String get timeinMinBus1 {
    return _convertToMin(service.nextBus.estimatedArrival);
  }

  String get timeinMinBus2 {
    if (service.nextBus2.estimatedArrival.isEmpty) {
      return "";
    }
    return _convertToMin(service.nextBus2.estimatedArrival);
  }

  String get timeinMinBus3 {
    if (service.nextBus3.estimatedArrival.isEmpty) {
      return "";
    }
    return _convertToMin(service.nextBus3.estimatedArrival);
  }
}
