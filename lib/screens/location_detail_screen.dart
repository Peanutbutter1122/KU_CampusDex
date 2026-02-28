import 'package:flutter/material.dart';
import 'camera_screen.dart';

class LocationDetailScreen extends StatelessWidget {
  const LocationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color customGreen = Color(0xFF358C46);
    const Color creamBg = Color(0xFFFDF8ED);

    return Scaffold(
      backgroundColor: creamBg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: customGreen,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'อาคารระพีสาคริก',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(color: Colors.black54, blurRadius: 4)],
                ),
              ),
              background: Image.network(
                'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?auto=format&fit=crop&w=800&q=80',
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.3),
                colorBlendMode: BlendMode.darken,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.orange),
                        ),
                        child: const Text(
                          '📍 Study Spot',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          Text(
                            ' 4.8 / 5.0',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'เกี่ยวกับสถานที่',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: brownColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'อาคารระพีสาคริก เป็นหอสมุดและศูนย์บริการข้อมูลข่าวสารสำหรับการศึกษาและค้นคว้าวิจัย มีพื้นที่สำหรับอ่านหนังสือ ทำงานกลุ่ม และคอมพิวเตอร์ไว้บริการนิสิต ซึ่งมักเป็นที่นัดหมายยอดฮิตของนิสิตทุกชั้นปี',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'ข้อมูลที่น่าสนใจ',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: brownColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.schedule, color: brownColor),
                    title: const Text('เวลาทำการ'),
                    subtitle: const Text(
                      'จันทร์ - ศุกร์: 08:30 - 20:00 น.\nเสาร์ - อาทิตย์: 09:00 - 18:00 น.',
                    ),
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    leading: const Icon(Icons.wifi, color: brownColor),
                    title: const Text('สิ่งอำนวยความสะดวก'),
                    subtitle: const Text(
                      'KU WiFi, ห้องอเนกประสงค์, ปลั๊กไฟ, คาเฟ่',
                    ),
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        color: creamBg,
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 60,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CameraScreen(locationId: '1'),
                ),
              );
            },
            icon: const Icon(Icons.camera_alt, color: Colors.white),
            label: const Text(
              'Check-in ถ่ายภาพสถานที่นี้',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: customGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 4,
            ),
          ),
        ),
      ),
    );
  }
}
