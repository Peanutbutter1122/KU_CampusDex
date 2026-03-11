import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/account_settings_screen.dart';

class TopStatusBar extends StatefulWidget {
  const TopStatusBar({super.key});

  @override
  State<TopStatusBar> createState() => _TopStatusBarState();
}

class _TopStatusBarState extends State<TopStatusBar> {
  int _level = 0;
  int _checkedIn = 0;
  StreamSubscription<DocumentSnapshot>? _sub;

  // Total places count used as denominator for the progress bar
  static const int _totalPlaces = 50;

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _sub = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .listen(
            (snap) {
              if (!mounted) return;
              if (snap.exists) {
                final data = snap.data() as Map<String, dynamic>;
                final placesMap =
                    data['checked_in_places_map'] as Map<dynamic, dynamic>? ??
                    {};
                setState(() {
                  _level = data['level'] ?? 0;
                  _checkedIn = placesMap.length;
                });
              }
            },
            onError: (e) {
              // Firestore อาจส่ง PERMISSION_DENIED หลัง signOut — จับแล้วเงียบๆ
              debugPrint('TopStatusBar stream error (likely after logout): $e');
            },
            cancelOnError:
                true, // cancel subscription เมื่อ error เพื่อป้องกัน re-trigger
          );
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double expProgress = (_checkedIn / _totalPlaces).clamp(0.0, 1.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title: KU CAMPUS DEX
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🎓', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Stack(
              children: [
                Text(
                  'KU CAMPUS DEX',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4.0
                      ..color = Colors.black,
                  ),
                ),
                const Text(
                  'KU CAMPUS DEX',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(0, 3),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Player Info Card
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AccountSettingsScreen()),
            );
          },
          child: Container(
            height: 85,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFFDF8ED),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF3B2213), width: 3.5),
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/character.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),

                // Name / Level and EXP
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            'LV.$_level',
                            style: GoogleFonts.mali(
                              color: const Color(0xFF3B2213),
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.0,
                              height: 1.0,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Location',
                            style: GoogleFonts.mali(
                              color: const Color(0xFF3B2213),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // EXP Bar (check-in progress)
                      Container(
                        height: 18,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFDF8ED),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFF3B2213),
                            width: 2.5,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: expProgress,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFDCA930),
                                border: Border(
                                  right: BorderSide(
                                    color: Color(0xFF3B2213),
                                    width: 2.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.settings, color: Color(0xFF3B2213), size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
