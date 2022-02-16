import 'package:bus_app/models/service_model.dart';
import 'package:bus_app/resources/notification_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ServiceRow extends StatefulWidget {
  final String busStopCode;
  final ServiceModel service;
  const ServiceRow({Key? key, required this.service, required this.busStopCode})
      : super(key: key);

  @override
  State<ServiceRow> createState() => _ServiceRowState();
}

class _ServiceRowState extends State<ServiceRow> {
  @override
  Widget build(BuildContext context) {
    return busNo(widget.service);
  }

  Widget busNo(ServiceModel service) {
    return Slidable(
      actionPane: const SlidableScrollActionPane(),
      actionExtentRatio: 1 / 3,
      actions: [
        slidableAction(3, Colors.black, Icons.access_alarm_outlined),
        slidableAction(5, Colors.red, Icons.access_alarm_outlined),
        slidableAction(10, Colors.yellow, Icons.access_alarm_outlined),
      ],
      child: buildListTile(service),
    );
  }

  Widget slidableAction(int timing, Color color, IconData icon) {
    return IconSlideAction(
      caption: timing.toString(),
      color: color,
      icon: icon,
      onTap: () => setAlarm(timing),
    );
  }

  void setAlarm(int userTiming) {
    final busNo = widget.service.getServiceNo;

    final parsedBus1 = (widget.service.timeinMinBus1 == "Arr." ||
            widget.service.timeinMinBus1 == "Left")
        ? 100
        : int.parse(widget.service.timeinMinBus1);
    final parsedBus2 = (widget.service.timeinMinBus2 == "Arr." ||
            widget.service.timeinMinBus1 == "Left")
        ? 100
        : int.parse(widget.service.timeinMinBus2);
    final parsedBus3 = (widget.service.timeinMinBus1 == "Arr." ||
            widget.service.timeinMinBus3 == "Left")
        ? 100
        : int.parse(widget.service.timeinMinBus3);

    int countdown = 0;

    if (userTiming <= parsedBus1) {
      countdown = parsedBus1 - userTiming;
    } else if (userTiming <= parsedBus2) {
      countdown = parsedBus2 - userTiming;
    } else if (userTiming <= parsedBus3) {
      countdown = parsedBus3 - userTiming;
    }

    if (countdown == 100) {
      const snackBar = SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            "No buses operating at the moment",
            style: TextStyle(fontSize: 24),
          ));
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else if (countdown == 0) {
      NotificationApi.showNotification(body: "The bus is reaching");
      const snackBar = SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            "Notification is set",
            style: TextStyle(fontSize: 24),
          ));
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            "Notification is set",
            style: TextStyle(fontSize: 24),
          ));
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);
      NotificationApi.showScheduledNotification(
          body: "$busNo is arriving in $countdown",
          scheduledTime: DateTime.now().add(Duration(minutes: countdown)));
    }
  }
}

Widget buildListTile(ServiceModel service) {
  return Card(
    child: ListTile(
      leading: Text(service.getServiceNo),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          timingOne(service),
          timingTwo(service),
          timingThree(service)
        ],
      ),
    ),
  );
}

Widget timingOne(ServiceModel service) {
  return SizedBox(
    width: 80,
    child: Row(
      children: [
        Image.asset(service.getBus1Image,
            width: 40, height: 50, fit: BoxFit.contain),
        Text(" " + service.timeinMinBus1),
      ],
    ),
  );
}

Widget timingTwo(ServiceModel service) {
  return SizedBox(
    width: 80,
    child: Row(
      children: [
        Image.asset(service.getBus2Image,
            width: 40, height: 50, fit: BoxFit.contain),
        Text(" " + service.timeinMinBus2),
      ],
    ),
  );
}

Widget timingThree(ServiceModel service) {
  return SizedBox(
    width: 80,
    child: Row(
      children: [
        Image.asset(service.getBus3Image,
            width: 40, height: 50, fit: BoxFit.contain),
        Text(" " + service.timeinMinBus3),
      ],
    ),
  );
}
