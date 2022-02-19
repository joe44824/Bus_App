import '../models/bus_arrival_model.dart';

class ServiceModel {
  final Service service;

  ServiceModel({required this.service});

  int _convertTimeStamp(String estimatedArrival) {
    var currentTime = DateTime.now();
    var busArrivalTime = DateTime.parse(estimatedArrival);
    return busArrivalTime.difference(currentTime).inMinutes;
  }

  String _convertToMin(String estimatedArrival) {
    int difference = _convertTimeStamp(estimatedArrival);

    if (difference <= -1) {
      return "Left";
    } else if (difference < 1 && difference >= 0) {
      return "Arr";
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

  String get bus1Image {
    return _generateBusType(service.nextBus.type, service.nextBus.load);
  }

  String get bus2Image {
    return _generateBusType(service.nextBus2.type, service.nextBus2.load);
  }

  String get bus3Image {
    return _generateBusType(service.nextBus3.type, service.nextBus3.load);
  }

  String get busNo {
    return service.serviceNo;
  }

  int timeInSec(int timerMin) {
    var currentTime = DateTime.now();
    late int sec;
    late int min;
    late int timeDiffInSec;

    int bus1TimeInMin =
        (int.tryParse(timeinMinBus1) == null) ? 0 : int.parse(timeinMinBus1);

    int bus2TimeInMin =
        (int.tryParse(timeinMinBus2) == null) ? 0 : int.parse(timeinMinBus2);

    int bus3TimeInMin =
        (int.tryParse(timeinMinBus3) == null) ? 0 : int.parse(timeinMinBus3);

    if (bus1TimeInMin > timerMin) {
      DateTime bus1ArrivalTime =
          DateTime.parse(service.nextBus.estimatedArrival);
      sec = bus1ArrivalTime.difference(currentTime).inSeconds;
      min = bus1ArrivalTime.difference(currentTime).inMinutes;
      print('The case 1: First Bus');
    } else if (bus2TimeInMin > timerMin) {
      DateTime bus2ArrivalTime =
          DateTime.parse(service.nextBus2.estimatedArrival);
      sec = bus2ArrivalTime.difference(currentTime).inSeconds;
      min = bus2ArrivalTime.difference(currentTime).inMinutes;
      print('The case 2: Second Bus');
    } else if (bus3TimeInMin > timerMin) {
      DateTime bus3ArrivalTime =
          DateTime.parse(service.nextBus3.estimatedArrival);
      sec = bus3ArrivalTime.difference(currentTime).inSeconds;
      min = bus3ArrivalTime.difference(currentTime).inMinutes;
      print('The case 3: Third Bus');
    } else {
      sec = 0;
      min = 0;
    }

    timeDiffInSec = min - timerMin;

    int remainingSec = sec - (min * 60);

    var actualSec =
        (remainingSec != 0) ? ((timeDiffInSec - 1) * 60 + remainingSec) : 0;

    print("Remaining time: ${timeDiffInSec - 1}min ${remainingSec}s ");


    return actualSec.toInt();
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
