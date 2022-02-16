import 'dart:async';

import 'package:bus_app/models/stop_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatelessWidget {
  final LatLng currentPosition;
  final List<BusStopModel> busStops;

  Map({Key? key, required this.busStops, required this.currentPosition})
      : super(key: key);

  final Completer<GoogleMapController> _controller = Completer();

  List<Marker> setMarkers() {
    return List.generate(
      busStops.length,
      (i) => Marker(
          markerId: MarkerId(busStops[i].busStopCode),
          position: LatLng(busStops[i].latitude, busStops[i].longitude),
          infoWindow: InfoWindow(title: busStops[i].description),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Marker> markers = setMarkers();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      height: MediaQuery.of(context).size.height * 2 / 5,
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers.map((e) => e).toSet(),
        initialCameraPosition:
            CameraPosition(target: currentPosition, zoom: 15.5),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
      ),
    );
  }
}
