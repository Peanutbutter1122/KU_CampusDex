import 'package:final_project/login_page.dart';
import 'package:final_project/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:final_project/home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await  initializeFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
    initialRoute: '/login_page', 

      
      routes: {
        '/login_page': (context) => LoginPage(),
        '/signup_page': (context) => SignupPage(),
        '/home': (context) => const HomePage(), 
      }
    );
  }
}

Future<void> initializeFirebase() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}