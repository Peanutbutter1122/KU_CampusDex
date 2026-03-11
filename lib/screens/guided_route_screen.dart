import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'navigation_screen.dart';
import '../data/ku_campus_routes.dart';

class GuidedRouteScreen extends StatelessWidget {
  final Function(AppWayPoint) onNavigateTap;

  const GuidedRouteScreen({super.key, required this.onNavigateTap});

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color creamBg = Color(0xFFFDF8ED);

    final List<Map<String, dynamic>> routes = KuCampusData.routes;
    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        title: const Text(
          'Guided Route (เส้นทางแนะนำ)',
          style: TextStyle(fontWeight: FontWeight.bold, color: brownColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseAuth.instance.currentUser != null
            ? FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots()
                  .handleError((e) {
                    // จับ PERMISSION_DENIED หลัง signOut ไม่ให้ crash
                    debugPrint('GuidedRouteScreen stream error: $e');
                  })
            : null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<String> unlockedPlaces = [];
          if (snapshot.hasData && snapshot.data!.exists) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            final checkedInRaw =
                data['checked_in_places'] as List<dynamic>? ?? [];
            unlockedPlaces = checkedInRaw
                .whereType<Map<String, dynamic>>()
                .map((e) => e['id'] as String? ?? '')
                .where((id) => id.isNotEmpty)
                .toList();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: routes.length,
            itemBuilder: (context, index) {
              final route = routes[index];
              final totalWaypoints =
                  (route['waypoints'] as List<AppWayPoint>).length;
              final remainingWaypoints =
                  (route['waypoints'] as List<AppWayPoint>)
                      .where((wp) => !unlockedPlaces.contains(wp.id))
                      .toList();
              final unlockedCount = totalWaypoints - remainingWaypoints.length;
              final progress = totalWaypoints > 0
                  ? unlockedCount / totalWaypoints
                  : 0.0;

              return GestureDetector(
                onTap: remainingWaypoints.isEmpty
                    ? null
                    : () async {
                        final AppWayPoint? selectedWaypoint =
                            await Navigator.push<AppWayPoint>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavigationScreen(
                                  waypoints: remainingWaypoints,
                                  routeName: route['title'],
                                ),
                              ),
                            );
                        if (selectedWaypoint != null) {
                          onNavigateTap(selectedWaypoint);
                        }
                      },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: brownColor, width: 2),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: route['color'].withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(color: route['color'], width: 2),
                          ),
                          child: Icon(
                            route['icon'],
                            color: route['color'],
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                route['title'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: brownColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                route['desc'],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: brownColor.withOpacity(0.7),
                                ),
                              ),
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: progress,
                                  minHeight: 8,
                                  backgroundColor: Colors.grey.shade300,
                                  color: remainingWaypoints.isEmpty
                                      ? Colors.amber
                                      : const Color(0xFF358C46),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                remainingWaypoints.isEmpty
                                    ? 'สำเร็จแล้ว!'
                                    : '${(progress * 100).toInt()}%',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: remainingWaypoints.isEmpty
                                      ? Colors.amber.shade700
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.chevron_right,
                          color: brownColor,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
