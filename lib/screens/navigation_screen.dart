import 'package:flutter/material.dart';

class AppWayPoint {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final bool isLandmark;

  const AppWayPoint({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.isLandmark = false,
  });
}

class NavigationScreen extends StatelessWidget {
  final List<AppWayPoint> waypoints;
  final String routeName;

  const NavigationScreen({
    super.key,
    required this.waypoints,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color creamBg = Color(0xFFFDF8ED);

    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        title: Text(
          routeName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: brownColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: brownColor),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: waypoints.length,
        itemBuilder: (context, index) {
          final wp = waypoints[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: brownColor, width: 1),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: brownColor,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Row(
                children: [
                  if (wp.isLandmark)
                    const Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Text('🏛️', style: TextStyle(fontSize: 16)),
                    ),
                  Expanded(
                    child: Text(
                      wp.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: brownColor,
                      ),
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.navigation, color: Colors.blue),
                onPressed: () => Navigator.pop(context, wp),
              ),
            ),
          );
        },
      ),
    );
  }
}
