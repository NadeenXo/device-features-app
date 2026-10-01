import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({super.key});

  // Coordinates for Cairo Governorate, Egypt.
  static const LatLng cairoLocation = LatLng(30.0444, 31.2357);

  @override
  Widget build(BuildContext context) {
    final Set<Marker> cairoMarker = {
      Marker(
        markerId: const MarkerId('cairo_marker'),
        position: cairoLocation,
        infoWindow: const InfoWindow(
          title: 'Cairo Governorate',
          snippet: 'Egypt',
        ),
      ),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Google Map'), centerTitle: true),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: cairoLocation,
          zoom: 11,
        ),
        markers: cairoMarker,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
      ),
    );
  }
}
