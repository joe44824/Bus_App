import 'package:bus_app/constants/bus_available_enum.dart';
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
  late ServiceModel service;
  late String busStopCode;
  late int id;

  @override
  void initState() {
    super.initState();
    busStopCode = widget.busStopCode;
    service = widget.service;
    id = int.tryParse(widget.service.busNo) == null ? 0 : int.parse(widget.service.busNo) + int.parse(widget.busStopCode);
  }

  @override
  Widget build(BuildContext context) {
    return busNo(service);
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
      onTap: () => setAlarm(
        timing,
        service,
      ),
    );
  }

  Widget buildListTile(ServiceModel service) {
    return Card(
      child: ListTile(
        leading: Text(service.busNo),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            showTiming(service.timeinMinBus1, service.bus1Image),
            showTiming(service.timeinMinBus2, service.bus2Image),
            showTiming(service.timeinMinBus3, service.bus3Image),
          ],
        ),
      ),
    );
  }

  Widget showTiming(String arrTimeInMin, String busImage) {
    return SizedBox(
      width: 80,
      child: Row(
        children: [
          Image.asset(busImage, width: 40, height: 50, fit: BoxFit.contain),
          Text(" " + arrTimeInMin),
        ],
      ),
    );
  }

  void setAlarm(int userTiming, ServiceModel service) {
    late int remainingSec;
    BusAvailibility busAvailable = BusAvailibility.busNotAvailable;

    if (userTiming.toString() == service.timeinMinBus1 ||
        userTiming.toString() == service.timeinMinBus2) {
      busAvailable = BusAvailibility.busArriving;
      setSnackBar(context, service, busAvailable, id);
      print("The bus is arriving in $userTiming");
    } else {
      remainingSec = service.timeInSec(userTiming);
      if (remainingSec == 0) {
        busAvailable = BusAvailibility.busNotAvailable;
        setSnackBar(context, service, busAvailable, id);
        print('No Buses at selected time');
      } else {
        busAvailable = BusAvailibility.busAvailable;
        setNotificationAlarm(service, userTiming, remainingSec);
      }
      setSnackBar(context, service, busAvailable, id);
    }
  }

  void setNotificationAlarm(
      ServiceModel service, int userTiming, int remainingSec) {
    NotificationApi.showScheduledNotification(
        id: id,
        body: "${service.busNo} is arriving in $userTiming",
        scheduledTime: DateTime.now().add(Duration(seconds: remainingSec)));
  }

  Future<void> setSnackBar(BuildContext context, ServiceModel service,
      BusAvailibility busAvailable, int id) async {
    late String text;
    late Icon icon; 

    final busAvailableSnackBarAction = SnackBarAction(
        disabledTextColor: Colors.blue,
        textColor: Colors.white,
        label: 'Undo',
        onPressed: () {
          print("Pressed Cancel Notification");
          NotificationApi.cancelNotification(id);
        });
    final noBusAvailableSnackBarAction =
        SnackBarAction(label: '', onPressed: () {});

    if (busAvailable == BusAvailibility.busArriving) {
      text = "Bus ${service.busNo} is arriving";
      icon = const Icon(Icons.alarm_on_outlined);
    } else if (busAvailable == BusAvailibility.busNotAvailable) {
      text = "No buses available for Bus ${service.busNo}";
      icon = const Icon(Icons.error_outline);
    } else {
      text = "Alarm is set for Bus ${service.busNo}";
      icon = const Icon(Icons.alarm_add_outlined);
    }

    final snackBar = SnackBar(
      elevation: 5.0,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 4),
      content: Row(
        children: [
          icon,
          const SizedBox(width: 15),
          Expanded(
            child: Text(text),
          )
        ],
      ),
      action: busAvailable == BusAvailibility.busAvailable
          ? busAvailableSnackBarAction
          : noBusAvailableSnackBarAction,
      backgroundColor: Colors.black.withOpacity(0.2),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
