import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'navigation_screen.dart';


/// ข้อมูลสถานที่สำหรับหน้า detail
class PlaceInfo {
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final String category; // เช่น 📍 Study Spot, 🍽️ ร้านอาหาร, ☕ คาเฟ่
  final List<Map<String, dynamic>> details; // [ {'icon': ..., 'title': ..., 'subtitle': ...} ]
  final AppWayPoint waypoint;

  const PlaceInfo({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.details,
    required this.waypoint,
  });
}

class LocationDetailScreen extends StatelessWidget {
  final PlaceInfo? placeInfo;
  const LocationDetailScreen({super.key, this.placeInfo});

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color customGreen = Color(0xFF358C46);
    const Color creamBg = Color(0xFFFDF8ED);

    // Fallback ไปหน้าระพีสาคริก ถ้าไม่มี placeInfo
    final info = placeInfo ?? const PlaceInfo(
      title: 'อาคารระพีสาคริก',
      subtitle: 'Study Hub ยอดนิยมของนิสิต มก.',
      category: '📍 Study Spot',
      imageUrl:
          'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?auto=format&fit=crop&w=800&q=80',
      description:
          'อาคารระพีสาคริก เป็นหอสมุดและศูนย์บริการข้อมูลข่าวสารสำหรับการศึกษาและค้นคว้าวิจัย มีพื้นที่สำหรับอ่านหนังสือ ทำงานกลุ่ม และคอมพิวเตอร์ไว้บริการนิสิต ซึ่งมักเป็นที่นัดหมายยอดฮิตของนิสิตทุกชั้นปี',
      details: [
        {
          'icon': Icons.schedule,
          'title': 'เวลาทำการ',
          'subtitle': 'จันทร์ - ศุกร์: 08:30 - 20:00 น.\nเสาร์ - อาทิตย์: 09:00 - 18:00 น.',
        },
        {
          'icon': Icons.wifi,
          'title': 'สิ่งอำนวยความสะดวก',
          'subtitle': 'KU WiFi, ห้องอเนกประสงค์, ปลั๊กไฟ, คาเฟ่',
        },
      ],
      waypoint: AppWayPoint(
        id: 'CEN_ADM04',
        name: 'อาคารระพีสาคริก',
        latitude: 13.847653,
        longitude: 100.569553,
      ),
    );

    return Scaffold(
      backgroundColor: creamBg,
      body: CustomScrollView(
        slivers: [
          // Hero image app bar
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: customGreen,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                info.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                ),
              ),
              background: CachedNetworkImage(
                imageUrl: info.imageUrl,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
                errorWidget: (_, __, ___) => Container(color: customGreen),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.orange),
                    ),
                    child: Text(
                      info.category,
                      style: const TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                  Text(
                    info.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'เกี่ยวกับสถานที่',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: brownColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    info.description,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),

                  if (info.details.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'ข้อมูลที่น่าสนใจ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: brownColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...info.details.map(
                      (d) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: Icon(d['icon'] as IconData, color: brownColor),
                          title: Text(d['title'] as String),
                          subtitle: Text(d['subtitle'] as String),
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),

      // ไม่มีปุ่ม check-in ในหน้านี้ — check-in ทำได้ในหน้า Map
    );
  }
}
