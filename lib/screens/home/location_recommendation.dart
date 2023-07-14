import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationRecommendationScreen extends StatefulWidget {
  static const routeName = '/location-recommendation-screen';

  const LocationRecommendationScreen({super.key});

  @override
  State<LocationRecommendationScreen> createState() =>
      _LocationRecommendationScreenState();
}

class _LocationRecommendationScreenState
    extends State<LocationRecommendationScreen> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    print(args);
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(args['latitude'], args['longitude']),
            zoom: 15,
          ),
          markers: {
            Marker(
                markerId: const MarkerId('Tes'),
                position: LatLng(args['latitude'], args['longitude']),
                icon: BitmapDescriptor.defaultMarker)
          },
        ),
      ),
    );
  }
}
