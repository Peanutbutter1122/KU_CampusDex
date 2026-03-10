import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<dynamic> landmarkData = [];

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
      final data = await json.decode(response);
      setState(() {
        landmarkData = data;
      });
    } catch (e) {
      debugPrint('Error loading json: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color creamBg = Color(0xFFFDF8ED);

    // Dummy gallery items
    final List<Map<String, String>> photos = [
      {
        'id': 'landmark_sam_burapajarn',
        'url':
            'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?auto=format&fit=crop&w=500&q=60',
        'title': 'อนุสาวรีย์ สามบูรพาจารย์',
      },
      {
        'id': 'landmark_pra_pirun',
        'url':
            'https://images.unsplash.com/photo-1498654896293-37aacf113fd9?auto=format&fit=crop&w=500&q=60',
        'title': 'พระพิรุณทรงนาค',
      },
      {
        'id': 'landmark_auditorium',
        'url':
            'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?auto=format&fit=crop&w=500&q=60',
        'title': 'หอประชุมใหญ่',
      },
      {
        'id': 'landmark_50th_anniversary',
        'url':
            'https://images.unsplash.com/photo-1568228189815-1a2f641a029c?auto=format&fit=crop&w=500&q=60',
        'title': 'อาคารสารนิเทศ 50 ปี',
      },
      {
        'id': 'landmark_suwanchart_pool',
        'url':
            'https://images.unsplash.com/photo-1555181126-cf46a03827c0?auto=format&fit=crop&w=500&q=60',
        'title': 'สระสุวรรณชาด',
      },
      {
        'id': 'landmark_60th_monument',
        'url':
            'https://images.unsplash.com/photo-1620216669930-babbf7b0282b?auto=format&fit=crop&w=500&q=60',
        'title': 'หออนุสรณ์ 60 ปี มก.',
      },
    ];

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
            List<String> unlockedPlaces = [];

            if (snapshot.hasData && snapshot.data!.exists) {
              final data = snapshot.data!.data() as Map<String, dynamic>;
              level = data['level'] ?? 0;
              final placesDynamic =
                  data['unlocked_places'] as List<dynamic>? ?? [];
              unlockedPlaces = placesDynamic.map((e) => e.toString()).toList();
            }

            // Filter photos based on unlocked places
            final unlockedPhotos = photos
                .where((p) => unlockedPlaces.contains(p['id']))
                .toList();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Level: $level',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: brownColor,
                    ),
                  ),
                ),
                Expanded(
                  child: unlockedPhotos.isEmpty
                      ? const Center(
                          child: Text(
                            'ยังไม่มีสถานที่ที่ปลดล็อก\nออกไปสำรวจกันเลย!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                childAspectRatio:
                                    0.8, // Fixed ratio to prevent infinite layout constraints
                              ),
                          itemCount: unlockedPhotos.length,
                          itemBuilder: (context, index) {
                            final photo = unlockedPhotos[index];

                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                // Find landmark info based on id
                                final info = landmarkData.firstWhere(
                                  (element) => element['id'] == photo['id'],
                                  orElse: () => null,
                                );

                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    insetPadding: const EdgeInsets.all(16),
                                    child: Stack(
                                      clipBehavior: Clip.none,
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(
                                            maxHeight:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.8, // Increased slightly for text
                                            maxWidth:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.9,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.vertical(
                                                      top: Radius.circular(16),
                                                    ),
                                                child: CachedNetworkImage(
                                                  imageUrl: photo['url']!,
                                                  fit: BoxFit.cover,
                                                  height: 250,
                                                  width: double.infinity,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(
                                                            Icons.error,
                                                          ),
                                                ),
                                              ),
                                              Flexible(
                                                child: SingleChildScrollView(
                                                  padding: const EdgeInsets.all(
                                                    16.0,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        photo['title']!,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: brownColor,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      if (info != null &&
                                                          info['description'] !=
                                                              null)
                                                        Text(
                                                          info['description'],
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 14,
                                                                height: 1.5,
                                                                color: Colors
                                                                    .black87,
                                                              ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: -10,
                                          right: -10,
                                          child: GestureDetector(
                                            onTap: () => Navigator.pop(context),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: brownColor,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 2,
                                                ),
                                              ),
                                              padding: const EdgeInsets.all(8),
                                              child: const Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl: photo['url']!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                      placeholder: (context, url) => Container(
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withOpacity(0.8),
                                            Colors.transparent,
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                      child: Text(
                                        photo['title']!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
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
