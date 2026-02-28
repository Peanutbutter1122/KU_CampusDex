import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import '../widgets/top_status_bar.dart';
import '../widgets/bottom_nav_bar.dart';

class MapScreen extends StatefulWidget {
  final CameraOptions cameraOptions;

  const MapScreen({super.key, required this.cameraOptions});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? mapboxMap;

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    // Mapbox Standard natively supports 3D buildings and lighting
    mapboxMap.style.setStyleURI("mapbox://styles/mapbox/standard");

    // Customize compass and scalebar
    mapboxMap.compass.updateSettings(
      CompassSettings(marginTop: 100, marginRight: 20),
    );
    mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(
            cameraOptions: widget.cameraOptions,
            onMapCreated: _onMapCreated,
          ),

          const SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: TopStatusBar(),
              ),
            ),
          ),

          const SafeArea(
            child: Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavBar(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
