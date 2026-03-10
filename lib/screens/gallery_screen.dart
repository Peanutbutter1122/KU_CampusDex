import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<dynamic> landmarkData = [];

  static const Color brownColor = Color(0xFF3B2213);
  static const Color creamBg = Color(0xFFFDF8ED);

  @override
  void initState() {
    super.initState();
    _loadLandmarkData();
  }

  Future<void> _loadLandmarkData() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/data/ku_landmarks.json',
      );
      final data = json.decode(response);
      setState(() => landmarkData = data);
    } catch (e) {
      debugPrint('Error loading json: $e');
    }
  }

  String _relativeTime(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes} นาทีที่แล้ว';
    } else if (diff.inHours < 24) {
      return '${diff.inHours} ชั่วโมงที่แล้ว';
    } else {
      return '${diff.inDays} วันที่แล้ว';
    }
  }

  String _thaiDate(DateTime dt) {
    // Convert to Thai Buddhist Era year
    final buddhistYear = dt.year + 543;
    const thaiMonths = [
      '',
      'มกราคม',
      'กุมภาพันธ์',
      'มีนาคม',
      'เมษายน',
      'พฤษภาคม',
      'มิถุนายน',
      'กรกฎาคม',
      'สิงหาคม',
      'กันยายน',
      'ตุลาคม',
      'พฤศจิกายน',
      'ธันวาคม',
    ];
    final time = DateFormat('HH:mm').format(dt);
    return '${dt.day} ${thaiMonths[dt.month]} $buddhistYear เวลา $time น.';
  }

  void _showPhotoDetail(BuildContext context, Map<String, dynamic> checkin) {
    final id = checkin['id'] as String? ?? '';
    final name = checkin['name'] as String? ?? '';
    final photoUrl = checkin['photo_url'] as String? ?? '';
    final timestamp = checkin['checkin_time'];
    DateTime? checkinTime;
    if (timestamp != null) {
      checkinTime = (timestamp as dynamic).toDate() as DateTime;
    }

    final info = landmarkData.firstWhere(
      (e) => e['id'] == id,
      orElse: () => null,
    );

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(ctx).size.height * 0.85,
                maxWidth: MediaQuery.of(ctx).size.width * 0.95,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: brownColor, width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Photo
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                    child: photoUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: photoUrl,
                            fit: BoxFit.cover,
                            height: 240,
                            width: double.infinity,
                            placeholder: (ctx, url) => Container(
                              height: 240,
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (ctx, url, e) => Container(
                              height: 240,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 64,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : Container(
                            height: 240,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.camera_alt,
                              size: 64,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                  // Info
                  Flexible(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Place name
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: brownColor,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Checkin time
                          if (checkinTime != null) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFDF8ED),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFDCA930),
                                  width: 1.5,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color: brownColor,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _thaiDate(checkinTime),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: brownColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _relativeTime(checkinTime),
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF358C46),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],

                          // Landmark description (if available)
                          if (info != null && info['description'] != null) ...[
                            const Divider(),
                            const SizedBox(height: 8),
                            const Row(
                              children: [
                                Text('🏛️', style: TextStyle(fontSize: 16)),
                                SizedBox(width: 8),
                                Text(
                                  'ประวัติสถานที่',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: brownColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              info['description'],
                              style: const TextStyle(
                                fontSize: 13,
                                height: 1.6,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Close button
            Positioned(
              top: -12,
              right: -12,
              child: GestureDetector(
                onTap: () => Navigator.pop(ctx),
                child: Container(
                  decoration: BoxDecoration(
                    color: brownColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: const Icon(Icons.close, color: Colors.white, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        title: const Text(
          'Gallery (แกลเลอรีความทรงจำ)',
          style: TextStyle(fontWeight: FontWeight.bold, color: brownColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseAuth.instance.currentUser != null
              ? FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots()
              : null,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            int level = 0;
            List<Map<String, dynamic>> checkedInPlaces = [];

            if (snapshot.hasData && snapshot.data!.exists) {
              final data = snapshot.data!.data() as Map<String, dynamic>;
              level = data['level'] ?? 0;
              // อ่านจาก Map (key = placeId) เพื่อป้องกัน entry ซ้ำ
              final rawMap = data['checked_in_places_map'] as Map<dynamic, dynamic>? ?? {};
              checkedInPlaces = rawMap.values
                  .whereType<Map<String, dynamic>>()
                  .toList()
                  .reversed
                  .toList(); // latest first by insertion order
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Level: $level · ${checkedInPlaces.length} สถานที่',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: brownColor,
                    ),
                  ),
                ),
                Expanded(
                  child: checkedInPlaces.isEmpty
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('📷', style: TextStyle(fontSize: 48)),
                              SizedBox(height: 12),
                              Text(
                                'ยังไม่มีสถานที่ที่ Check-in\nออกไปสำรวจและถ่ายรูปกันเลย!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                                childAspectRatio: 0.85,
                              ),
                          itemCount: checkedInPlaces.length,
                          itemBuilder: (context, index) {
                            final checkin = checkedInPlaces[index];
                            final photoUrl =
                                checkin['photo_url'] as String? ?? '';
                            final name = checkin['name'] as String? ?? '';
                            final timestamp = checkin['checkin_time'];
                            DateTime? checkinTime;
                            if (timestamp != null) {
                              checkinTime =
                                  (timestamp as dynamic).toDate() as DateTime;
                            }

                            return GestureDetector(
                              onTap: () => _showPhotoDetail(context, checkin),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    // Photo
                                    photoUrl.isNotEmpty
                                        ? CachedNetworkImage(
                                            imageUrl: photoUrl,
                                            fit: BoxFit.cover,
                                            placeholder: (ctx, url) => Container(
                                              color: Colors.grey[300],
                                              child: const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget: (ctx, url, e) =>
                                                Container(
                                                  color: Colors.grey[300],
                                                  child: const Icon(
                                                    Icons.image_not_supported,
                                                  ),
                                                ),
                                          )
                                        : Container(
                                            color: Colors.grey[300],
                                            child: const Icon(
                                              Icons.camera_alt,
                                              size: 40,
                                              color: Colors.grey,
                                            ),
                                          ),

                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 8,
                                          bottom: 12, // เพิ่มจาก 8 → 12 เพื่อไม่ให้ตัวเลขจม
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.black.withOpacity(0.85),
                                              Colors.transparent,
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              name,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                            if (checkinTime != null)
                                              Text(
                                                _relativeTime(checkinTime),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.greenAccent,
                                                  fontSize: 11,
                                                  height: 1.4,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
