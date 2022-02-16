import 'package:bus_app/bloc/busstops_bloc.dart';
import 'package:flutter/material.dart';

class BusStopsProvider extends InheritedWidget {
  BusStopsProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  final BusStopsBloc bloc = BusStopsBloc();

  @override
  bool updateShouldNotify(oldWidget) => true;

  static BusStopsBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<BusStopsProvider>())!
        .bloc;
  }
}
