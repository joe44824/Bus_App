import 'package:bus_app/models/stop_model.dart';
import 'package:bus_app/screens/detail_screen.dart';
import 'package:flutter/material.dart';

class BusRow extends StatelessWidget {
  final BusStopModel busStop;

  const BusRow({Key? key, required this.busStop}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(DetailScreen.routeName, arguments: busStop);
        },
        child: ListTile(
          leading: const Icon(Icons.favorite_border_outlined),
          title: Text(busStop.description),
          subtitle: Text(busStop.busStopCode),
          trailing: const Icon(Icons.keyboard_arrow_left_outlined),
        ),
      ),
    );
  }
}
