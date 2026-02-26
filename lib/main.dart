import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'screens/map_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Pass your access token to MapboxOptions so you can load a map
  String ACCESS_TOKEN = const String.fromEnvironment("ACCESS_TOKEN");

  print("Check Token: $ACCESS_TOKEN");

  if (ACCESS_TOKEN.isEmpty) {
    print("Error หา Token ไม่เจอ");
  }
  MapboxOptions.setAccessToken(ACCESS_TOKEN);

  // Define options for your camera
  CameraOptions camera = CameraOptions(
    center: Point(coordinates: Position(100.5678, 13.8475)),
    zoom: 16.5,
    bearing: 45,
    pitch: 60,
  );

  // Run your application, passing your CameraOptions to the MapScreen
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapScreen(cameraOptions: camera),
    ),
  );
}
