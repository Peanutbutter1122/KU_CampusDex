import 'package:flutter/material.dart';
import '../widgets/top_status_bar.dart';
import 'location_detail_screen.dart';
import 'ranking_screen.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onExploreTap;

  const HomeScreen({super.key, required this.onExploreTap});

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color customGreen = Color(0xFF358C46);

    return Scaffold(
      body: Stack(
        children: [
          // พื้นหลังลายทางทางตั้ง ให้เหมือนสไตล์ในภาพที่แนบมา
          Row(
            children: List.generate(
              10,
              (index) => Expanded(
                child: Container(
                  color: index % 2 == 0
                      ? const Color(0xFFFDF8ED) // สีครีมอ่อน
                      : const Color(0xFFE8F1E9), // สีเขียวอ่อนสุดๆ
                ),
              ),
            ),
          ),

          Column(
            children: [
              // 🌟 แถบสีเขียวทึบด้านบน ครอบคลุมถึง SafeArea แบบในภาพ
              Container(
                width: double.infinity,
                color: customGreen,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 16,
                  bottom: 24,
                ),
                child: const TopStatusBar(),
              ),

              const SizedBox(height: 20),

              // ตรงกลาง: รูปภาพสถานที่ตัวอย่างเพื่อสร้างแรงบันดาลใจในการเริ่มเดินทาง
              Expanded(
                child: SafeArea(
                  // เพิ่ม SafeArea เพื่อป้องกันพื้นที่ด้านล่าง
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'เริ่มสำรวจสถานที่ใหม่! 🌟',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: brownColor,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // การ์ดรูปภาพสถานที่สวยงาม
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LocationDetailScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 380,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(color: brownColor, width: 4),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10,
                                  offset: Offset(0, 5),
                                ),
                              ],
                              image: const DecorationImage(
                                // รูปตัวอย่างสถานที่สวยงาม (เปลี่ยน URL เป็นรูปที่ต้องการได้)
                                image: NetworkImage(
                                  'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?auto=format&fit=crop&w=800&q=80',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(28),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.85),
                                    Colors.black.withOpacity(0.3),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'อาคารระพีสาคริก', // ตัวอย่างสถานที่
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black54,
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'มหาวิทยาลัยเกษตรศาสตร์',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24),

                                  // ปุ่มกดเพื่อออกเดินทาง (Free Explore)
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: onExploreTap,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 14,
                                        ),
                                        decoration: BoxDecoration(
                                          color: customGreen,
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 4,
                                              offset: Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'ออกเดินทางเลย',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            Icon(
                                              Icons.directions_walk,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ปุ่ม Ranking
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RankingScreen(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.leaderboard,
                              color: brownColor,
                            ),
                            label: const Text(
                              'ดูอันดับนักสำรวจ (Ranking)',
                              style: TextStyle(
                                color: brownColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                  color: brownColor,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
