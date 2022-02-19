import 'package:bus_app/bloc/bus_arrival_provider.dart';
import 'package:bus_app/resources/notification_api.dart';
import 'package:bus_app/screens/detail_screen.dart';
import 'package:bus_app/screens/home_screen.dart';
import 'package:bus_app/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'bloc/busstops_provider.dart';

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    NotificationApi.init();
  }

  @override
  Widget build(BuildContext context) {
    return BusArrivalProvider(
      child: BusStopsProvider(
        child: MaterialApp(
          title: 'SG BUS',
          theme: ThemeData(
              primaryColor: const Color(0xff00ADB5),
              primarySwatch: Colors.teal,
              scaffoldBackgroundColor: const Color(0xff00ADB5)),
          home: const MainScreen(),
          routes: {
            MainScreen.routeName: (context) => const MainScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            DetailScreen.routeName: (context) => const DetailScreen(),
          },
        ),
      ),
    );
  }
}
