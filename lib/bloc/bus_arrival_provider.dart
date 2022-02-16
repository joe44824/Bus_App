import 'package:bus_app/bloc/bus_arrival_bloc.dart';
import 'package:flutter/material.dart';

class BusArrivalProvider extends InheritedWidget {
  BusArrivalProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  final bloc = BusArrivalBloc();

  @override
  bool updateShouldNotify(oldWidget) => true;

  static BusArrivalBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<BusArrivalProvider>())!
        .bloc;
  }
}
