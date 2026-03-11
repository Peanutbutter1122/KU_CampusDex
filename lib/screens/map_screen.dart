import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/top_status_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import 'navigation_screen.dart';
import 'camera_screen.dart';
import '../data/badge_data.dart';

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

  // ป้องกัน _startNavigation ถูกเรียกพร้อมกันจากทั้ง initState และ didUpdateWidget
  bool _navigationStarted = false;

  double _speed = 0.0;
  int _distanceMeters = 0;
  bool _isNearDestination = false;
  geo.Position? _currentPosition;

  List<dynamic> _landmarkData = [];

  final String accessToken = const String.fromEnvironment("ACCESS_TOKEN");

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    _loadLandmarkData();
  }

  Future<void> _loadLandmarkData() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/ku_landmarks.json',
      );
      _landmarkData = json.decode(response);
    } catch (e) {
      debugPrint('Error loading landmark data: $e');
    }
  }

  @override
  void didUpdateWidget(MapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.destination != oldWidget.destination) {
      if (widget.destination != null) {
        // รีเซ็ต flag เพื่อให้ _startNavigation เรียกได้กับปลายทางใหม่
        _navigationStarted = false;
        _startNavigation(widget.destination!);
      } else {
        _navigationStarted = false;
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

    // ตั้ง flag ก่อนเรียก ถ้า didUpdateWidget มาก่อนค่อยๆ skip
    if (widget.destination != null && !_navigationStarted) {
      _startNavigation(widget.destination!);
    }
  }

  Future<void> _startNavigation(AppWayPoint dest) async {
    if (mapboxMap == null) return;
    // ป้องกันการเรียกซ้ำพร้อมกัน
    if (_navigationStarted) return;
    _navigationStarted = true;

    // หยุดนำทางเก่าก่อน (ล้างเส้นทางและ marker เดิม)
    _positionStream?.cancel();
    _positionStream = null;
    if (_currentRouteAnnotation != null && polylineAnnotationManager != null) {
      await polylineAnnotationManager?.delete(_currentRouteAnnotation!);
      _currentRouteAnnotation = null;
    }
    if (_destinationMarker != null && circleAnnotationManager != null) {
      await circleAnnotationManager?.delete(_destinationMarker!);
      _destinationMarker = null;
    }

    try {
      _currentPosition = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
      );
      await _fetchAndDrawRoute(_currentPosition!, dest);
      await _addDestinationMarker(dest);

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
            _speed = position.speed * 3.6;
            _distanceMeters = geo.Geolocator.distanceBetween(
              position.latitude,
              position.longitude,
              dest.latitude,
              dest.longitude,
            ).toInt();
            _isNearDestination = _distanceMeters < 30;

            mapboxMap?.flyTo(
              CameraOptions(
                center: Point(
                  coordinates: Position(position.longitude, position.latitude),
                ),
                zoom: 18,
                bearing: position.heading,
                pitch: 60,
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

  // Check-in requires photo — opens camera, then uploads to Firebase Storage + Firestore
  void _checkIn() async {
    if (widget.destination == null) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    // เก็บ dest ไว้ใน local var ก่อน async เพื่อป้องกัน null ภายหลัง
    final AppWayPoint dest = widget.destination!;

    // Open camera
    final String? photoPath = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => CameraScreen(locationId: dest.id),
      ),
    );

    if (photoPath == null) return; // User cancelled

    // Show uploading indicator
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: Color(0xFF358C46)),
                SizedBox(height: 16),
                Text('กำลังบันทึก Check-in...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      final now = DateTime.now();
      final timestamp = now.millisecondsSinceEpoch;

      // Upload photo to Firebase Storage (ชื่อไฟล์ใช้ timestamp เพื่อ overwrite ไม่ได้
      // แต่แต่ละ check-in อาจเป็นรูปใหม่ — อัปโหลดรูปใหม่เสมอ)
      final storageRef = FirebaseStorage.instance.ref().child(
        'checkins/${user.uid}/${dest.id}_$timestamp.jpg',
      );

      final uploadTask = storageRef.putFile(File(photoPath));
      final taskSnapshot = await uploadTask;
      final photoUrl = await taskSnapshot.ref.getDownloadURL();

      // ── ใช้ map keyed by place ID เพื่อป้องกัน duplicate ──────────────────
      // checked_in_places_map: { "FOOD_BAR01": { name, checkin_time, photo_url }, ... }
      // การ check-in ซ้ำจะ update รูปและเวลาใหม่ แต่ไม่เพิ่ม entry ซ้ำ
      final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

      final docSnap = await userRef.get();
      final existing = docSnap.data() ?? {};
      final Map<String, dynamic> placesMap = Map<String, dynamic>.from(
        existing['checked_in_places_map'] as Map<dynamic, dynamic>? ?? {},
      );

      final bool isNewPlace = !placesMap.containsKey(dest.id);

      placesMap[dest.id] = {
        'id': dest.id,
        'name': dest.name,
        'checkin_time': Timestamp.fromDate(now),
        'photo_url': photoUrl,
      };

      // เพิ่ม level เฉพาะสถานที่ใหม่ที่ยังไม่เคย check-in
      await userRef.set({
        if (isNewPlace) 'level': FieldValue.increment(1),
        'checked_in_places_map': placesMap,
      }, SetOptions(merge: true));

      // ── ประเมิน badge ที่ปลดล็อกใหม่ ─────────────────────────────────────
      final Set<String> allCheckedIds = placesMap.keys.toSet();

      final Set<String> alreadyUnlocked = Set<String>.from(
        existing['unlocked_badges'] as List<dynamic>? ?? [],
      );

      final List<String> nowUnlocked =
          AppBadge.evaluateUnlockedIds(allCheckedIds, BadgeData.all);

      final List<String> newlyUnlocked = nowUnlocked
          .where((id) => !alreadyUnlocked.contains(id))
          .toList();

      if (newlyUnlocked.isNotEmpty) {
        await userRef.update({
          'unlocked_badges': FieldValue.arrayUnion(newlyUnlocked),
        });
      }
      // ─────────────────────────────────────────────────────────────────────

      if (mounted) Navigator.pop(context); // close loading dialog

      // แสดง badge ที่ปลดล็อกใหม่ (ถ้ามี)
      if (newlyUnlocked.isNotEmpty && mounted) {
        for (final badgeId in newlyUnlocked) {
          final badge = BadgeData.all.firstWhere(
            (b) => b.id == badgeId,
            orElse: () => BadgeData.all.first,
          );
          if (!mounted) break;
          await _showBadgeUnlockedDialog(badge);
        }
      }

      // If landmark: show history popup
      if (dest.isLandmark && mounted) {
        final info = _landmarkData.firstWhere(
          (e) => e['id'] == dest.id,
          orElse: () => null,
        );
        if (info != null) {
          await _showLandmarkHistoryDialog(info);
        }
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isNewPlace
                  ? 'Check-in ที่ "${dest.name}" สำเร็จ! 🎉'
                  : 'อัปเดตรูป Check-in ที่ "${dest.name}" แล้ว! 📸',
            ),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) Navigator.pop(context); // close loading dialog
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('เกิดข้อผิดพลาด: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    widget.onClearDestination?.call();
    _stopNavigation();
  }

  Future<void> _showLandmarkHistoryDialog(Map<String, dynamic> info) async {
    await showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFDF8ED),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFF3B2213), width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFC107),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
                ),
                child: Row(
                  children: [
                    const Text('🏛️', style: TextStyle(fontSize: 24)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        info['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF3B2213),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    info['description'],
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF358C46),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'รับทราบ ✓',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showBadgeUnlockedDialog(AppBadge badge) async {
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFDF8ED),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: badge.color, width: 3),
          ),
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🎉', style: const TextStyle(fontSize: 48)),
              const SizedBox(height: 10),
              const Text(
                'ปลดล็อก Badge ใหม่!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3B2213),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: badge.color.withOpacity(0.15),
                  border: Border.all(color: badge.color, width: 3),
                ),
                child: Icon(badge.icon, size: 44, color: badge.color),
              ),
              const SizedBox(height: 14),
              Text(
                badge.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: badge.color,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                badge.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF3B2213),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: badge.color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text(
                    'ยอดเยี่ยม! 🎊',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;

    mapboxMap.compass.updateSettings(
      CompassSettings(marginTop: 100, marginRight: 20),
    );
    mapboxMap.scaleBar.updateSettings(ScaleBarSettings(enabled: false));

    _updateMapStyle();

    final tapBuildings = TapInteraction(StandardBuildings(), (feature, _) {
      mapboxMap.setFeatureStateForFeaturesetFeature(
        feature,
        StandardBuildingsState(highlight: true),
      );
      log('Tapped building group: ${feature.group}');
    });
    mapboxMap.addInteraction(tapBuildings);

    mapboxMap.addInteraction(
      LongTapInteraction.onMap((_) {
        mapboxMap.resetFeatureStatesForFeatureset(StandardBuildings());
      }),
    );

    mapboxMap.location.updateSettings(
      LocationComponentSettings(
        enabled: true,
        pulsingEnabled: true,
        puckBearing: PuckBearing.HEADING,
        locationPuck: LocationPuck(locationPuck2D: DefaultLocationPuck2D()),
      ),
    );

    // Initial fetch of position when map created if not navigating
    if (widget.destination == null) {
      try {
        _currentPosition = await geo.Geolocator.getCurrentPosition(
          desiredAccuracy: geo.LocationAccuracy.high,
        );
      } catch (e) {
        debugPrint("Error fetching initial position: $e");
      }
    } else {
      _startNavigation(widget.destination!);
    }
  }

  void _updateMapStyle() {
    mapboxMap?.style.setStyleImportConfigProperties('basemap', {
      'lightPreset': 'day',
      'theme': 'default',
      'colorBuildingHighlight': 'hsl(0, 94%, 50%)',
      'show3dBuildings': true,
    });
  }

  _onStyleLoaded(StyleLoadedEventData data) async {
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

  Future<void> _moveToCurrentLocation() async {
    if (mapboxMap == null) return;

    try {
      final position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
      );
      
      _currentPosition = position;

      mapboxMap!.setCamera(
        CameraOptions(
          center: Point(
            coordinates: Position(
              position.longitude,
              position.latitude,
            ),
          ),
          zoom: 17,
        ),
      );
    } catch (e) {
      debugPrint("Error moving to current location: $e");
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
          
          // My Location Button
          Positioned(
            right: 16,
            bottom: 24, // Fixed position
            child: FloatingActionButton(
              heroTag: 'myLocationBtn',
              onPressed: _moveToCurrentLocation,
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF358C46),
              elevation: 4,
              child: const Icon(Icons.my_location),
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
