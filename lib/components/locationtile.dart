import 'dart:ui';

import 'package:final_project/components/home_location.dart';
import 'package:flutter/material.dart';

class Locationtile extends StatelessWidget {
  final HomeLocation homeLocation;

  const Locationtile({super.key, required this.homeLocation});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30,sigmaY: 30), // กรอบเบลอ
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
          
      padding: const EdgeInsets.all(25),
      width: 300,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
              // pic
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    homeLocation.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // location name
              Text(
                homeLocation.name,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              
            ],
          ),
        ),
      ),
    ),
  );
}}