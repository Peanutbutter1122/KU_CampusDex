import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/top_status_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import 'navigation_screen.dart'; // for AppWayPoint
import 'camera_screen.dart';

class MapScreen extends StatefulWidget {
  final CameraOptions cameraOptions;
  final AppWayPoint? destination;
  final VoidCallback? onClearDestination;

  const MapScreen({
    super.key,
    required this.cameraOptions,
    this.destination,
    this.onClearDestination,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? mapboxMap;
  PolylineAnnotationManager? polylineAnnotationManager;
  CircleAnnotationManager? circleAnnotationManager;
  StreamSubscription<geo.Position>? _positionStream;
  PolylineAnnotation? _currentRouteAnnotation;
  CircleAnnotation? _destinationMarker;

  double _speed = 0.0;
  int _distanceMeters = 0;
  bool _isNearDestination = false;
  geo.Position? _currentPosition;

  final String accessToken = const String.fromEnvironment("ACCESS_TOKEN");

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  @override
  void didUpdateWidget(MapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.destination != oldWidget.destination) {
      if (widget.destination != null) {
        _startNavigation(widget.destination!);
      } else {
        _stopNavigation();
      }
    }
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  Future<void> _checkPermissions() async {
    bool serviceEnabled;
    geo.LocationPermission permission;

    serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) return;
    }
    if (permission == geo.LocationPermission.deniedForever) return;

    if (widget.destination != null) {
      _startNavigation(widget.destination!);
    }
  }

  Future<void> _startNavigation(AppWayPoint dest) async {
    if (mapboxMap == null) return;

    try {
      _currentPosition = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
      );
      await _fetchAndDrawRoute(_currentPosition!, dest);
      await _addDestinationMarker(dest);

      // Initially fly camera to show destination in 3D
      mapboxMap?.flyTo(
        CameraOptions(
          center: Point(coordinates: Position(dest.longitude, dest.latitude)),
          zoom: 18,
          pitch: 60,
        ),
        MapAnimationOptions(duration: 1500),
      );
    } catch (e) {
      debugPrint("Error fetching initial route: $e");
    }

    _positionStream?.cancel();
    _positionStream =
        geo.Geolocator.getPositionStream(
          locationSettings: const geo.LocationSettings(
            accuracy: geo.LocationAccuracy.high,
            distanceFilter: 5,
          ),
        ).listen((geo.Position position) {
          if (!mounted) return;
          setState(() {
            _currentPosition = position;
            _speed = position.speed * 3.6; // m/s to km/h
            _distanceMeters = geo.Geolocator.distanceBetween(
              position.latitude,
              position.longitude,
              dest.latitude,
              dest.longitude,
            ).toInt();
            _isNearDestination =
                _distanceMeters < 30; // 30 meters check-in radius

            mapboxMap?.flyTo(
              CameraOptions(
                center: Point(
                  coordinates: Position(position.longitude, position.latitude),
                ),
                zoom: 18,
                bearing: position.heading,
                pitch: 60, // 3D tilt
              ),
              MapAnimationOptions(duration: 1000),
            );
          });
        });
  }

  void _stopNavigation() {
    _positionStream?.cancel();
    if (_currentRouteAnnotation != null && polylineAnnotationManager != null) {
      polylineAnnotationManager?.delete(_currentRouteAnnotation!);
      _currentRouteAnnotation = null;
    }
    if (_destinationMarker != null && circleAnnotationManager != null) {
      circleAnnotationManager?.delete(_destinationMarker!);
      _destinationMarker = null;
    }
    if (mounted) {
      setState(() {
        _speed = 0.0;
        _distanceMeters = 0;
        _isNearDestination = false;
      });
    }
  }

  Future<void> _fetchAndDrawRoute(geo.Position start, AppWayPoint end) async {
    if (mapboxMap == null) return;

    final url = Uri.parse(
      'https://api.mapbox.com/directions/v5/mapbox/walking/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?geometries=geojson&access_token=$accessToken',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final route = data['routes'][0];
          final geometry = route['geometry'];
          final coordinates = geometry['coordinates'] as List;

          List<Position> routeCoordinates = coordinates.map((coord) {
            return Position(coord[0].toDouble(), coord[1].toDouble());
          }).toList();

          polylineAnnotationManager ??= await mapboxMap!.annotations
              .createPolylineAnnotationManager();

          if (_currentRouteAnnotation != null) {
            await polylineAnnotationManager?.delete(_currentRouteAnnotation!);
          }

          _currentRouteAnnotation = await polylineAnnotationManager?.create(
            PolylineAnnotationOptions(
              geometry: LineString(coordinates: routeCoordinates),
              lineColor: Colors.blue.value,
              lineWidth: 6.0,
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error drawing route: $e');
    }
  }

  Future<void> _addDestinationMarker(AppWayPoint dest) async {
    if (mapboxMap == null) return;
    circleAnnotationManager ??= await mapboxMap!.annotations
        .createCircleAnnotationManager();
    if (_destinationMarker != null) {
      await circleAnnotationManager?.delete(_destinationMarker!);
    }
    _destinationMarker = await circleAnnotationManager?.create(
      CircleAnnotationOptions(
        geometry: Point(coordinates: Position(dest.longitude, dest.latitude)),
        circleRadius: 16.0,
        circleColor: Colors.red.value,
        circleOpacity: 0.85,
        circleStrokeWidth: 4.0,
        circleStrokeColor: Colors.white.value,
      ),
    );
  }

  void _checkIn() async {
    if (widget.destination == null) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {
          'level': FieldValue.increment(1),
          'unlocked_places': FieldValue.arrayUnion([widget.destination!.id]),
        },
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'คุณได้ Check-in ที่ "${widget.destination!.name}" แล้ว 🎉',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
    widget.onClearDestination?.call();
    _stopNavigation();
    // Navigate to camera screen after check-in
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              CameraScreen(locationId: widget.destination?.id ?? ''),
        ),
      );
    }
  }

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
    // NOTE: style is set via styleUri parameter in MapWidget - no loadStyleURI needed

    mapboxMap.compass.updateSettings(
      CompassSettings(marginTop: 100, marginRight: 20),
    );
    mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));

    _updateMapStyle();

    // Tap a building to highlight it blue
    final tapBuildings = TapInteraction(StandardBuildings(), (feature, _) {
      mapboxMap.setFeatureStateForFeaturesetFeature(
        feature,
        StandardBuildingsState(highlight: true),
      );
      log('Tapped building group: ${feature.group}');
    });
    mapboxMap.addInteraction(tapBuildings);

    // Long tap to clear all highlights
    mapboxMap.addInteraction(
      LongTapInteraction.onMap((_) {
        mapboxMap.resetFeatureStatesForFeatureset(StandardBuildings());
      }),
    );

    // Enable the location puck (blue dot showing user's position)
    mapboxMap.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
        puckBearing: PuckBearing.HEADING,
        locationPuck: LocationPuck(locationPuck2D: DefaultLocationPuck2D()),
      ),
    );

    if (widget.destination != null) {
      _startNavigation(widget.destination!);
    }
  }

  void _updateMapStyle() {
    mapboxMap?.style.setStyleImportConfigProperties('basemap', {
      'lightPreset': 'day',
      'theme': 'default',
      'colorBuildingHighlight':
          'hsl(0, 94%, 50%)', // Red highlight for destination
      'show3dBuildings': true,
    });
  }

  _onStyleLoaded(StyleLoadedEventData data) async {
    // Enable 3D buildings in the Standard style
    try {
      await mapboxMap?.style.setStyleImportConfigProperty(
        'basemap',
        'show3dBuildings',
        true,
      );
    } catch (e) {
      debugPrint('3D buildings config error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNavigating = widget.destination != null;

    return Scaffold(
      body: Stack(
        children: [
          MapWidget(
            key: const ValueKey('mapWidget'),
            cameraOptions: widget.cameraOptions,
            styleUri: MapboxStyles.STANDARD,
            textureView: true,
            onMapCreated: _onMapCreated,
            onStyleLoadedListener: _onStyleLoaded,
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
          if (isNavigating)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomNavBar(
                    speed: _speed,
                    destinationName: widget.destination!.name,
                    distanceMeters: _distanceMeters,
                    isNearDestination: _isNearDestination,
                    onButtonPressed: () {
                      if (_isNearDestination) {
                        _checkIn();
                      } else {
                        // Normally centers camera to current location
                        if (_currentPosition != null && mapboxMap != null) {
                          mapboxMap!.flyTo(
                            CameraOptions(
                              center: Point(
                                coordinates: Position(
                                  _currentPosition!.longitude,
                                  _currentPosition!.latitude,
                                ),
                              ),
                              zoom: 17,
                            ),
                            MapAnimationOptions(duration: 500),
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
