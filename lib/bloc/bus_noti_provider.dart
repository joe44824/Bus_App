import 'package:flutter/material.dart';
import 'bus_noti_bloc.dart';

class BusNotiProvider extends InheritedWidget {
  BusNotiProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  final bloc = BusNotiBloc();

  @override
  bool updateShouldNotify(oldWidget) => true;

  static BusNotiBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<BusNotiProvider>())!
        .bloc;
  }
}
