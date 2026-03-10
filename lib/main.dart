import 'package:final_project/login_page.dart';
import 'package:final_project/signup_page.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Pass your access token to MapboxOptions so you can load a map
  String ACCESS_TOKEN = const String.fromEnvironment("ACCESS_TOKEN");

  print("Check Token: $ACCESS_TOKEN");

  if (ACCESS_TOKEN.isEmpty) {
    print("Error หา Token ไม่เจอ");
  }
  MapboxOptions.setAccessToken(ACCESS_TOKEN);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define options for your camera
    CameraOptions camera = CameraOptions(
      center: Point(coordinates: Position(100.5678, 13.8475)),
      zoom: 16.5,
      bearing: 45,
      pitch: 60,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(), // Root now decides where to go
      routes: {
        '/login_page': (context) => LoginPage(),
        '/signup_page': (context) => SignupPage(),
        '/home': (context) => MainScreen(cameraOptions: camera),
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // User is not logged in
        if (!snapshot.hasData) {
          return LoginPage();
        }

        // User is logged in
        // Define options for your camera (Since AuthGate isn't passing it cleanly to a route directly, we just return MainScreen here or pushNamed)
        CameraOptions camera = CameraOptions(
          center: Point(coordinates: Position(100.5678, 13.8475)),
          zoom: 16.5,
          bearing: 45,
          pitch: 60,
        );
        return MainScreen(cameraOptions: camera);
      },
    );
  }
}
