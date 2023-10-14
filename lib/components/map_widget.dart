import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMapWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(29.654388, -82.337451), // Initial map center
        zoom: 12.0, // Initial zoom level
      ),
    );
  }
}
