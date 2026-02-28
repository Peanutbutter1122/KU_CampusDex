import 'package:flutter/material.dart';

class GuidedRouteScreen extends StatelessWidget {
  const GuidedRouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color creamBg = Color(0xFFFDF8ED);

    final List<Map<String, dynamic>> routes = [
      {
        'title': 'KU Starter',
        'desc': 'จุดที่เด็กปี 1 “ต้องรู้” เพื่ออยู่รอดสัปดาห์แรก',
        'icon': Icons.flag,
        'color': const Color(0xFFD9534F),
        'progress': 0.8,
      },
      {
        'title': 'Student Services',
        'desc': 'รวมจุดที่เกี่ยวกับงานเอกสาร/บริการนิสิต',
        'icon': Icons.assignment,
        'color': const Color(0xFFF0AD4E),
        'progress': 0.5,
      },
      {
        'title': 'Study Spots',
        'desc': 'ห้องสมุด/มุมอ่านหนังสือ',
        'icon': Icons.menu_book,
        'color': const Color(0xFF5BC0DE),
        'progress': 0.2,
      },
      {
        'title': 'Food & Daily Life',
        'desc': 'โรงอาหาร/ร้านน้ำ',
        'icon': Icons.restaurant,
        'color': const Color(0xFF5CB85C),
        'progress': 0.0,
      },
      {
        'title': 'Health & Safety',
        'desc': 'หน่วยพยาบาล/จุดช่วยเหลือ/เบอร์ฉุกเฉิน',
        'icon': Icons.local_hospital,
        'color': const Color(0xFFD9534F),
        'progress': 0.0,
      },
      {
        'title': 'Sports & Chill',
        'desc': 'สนามกีฬา/ฟิตเนส/สวน/จุดพักผ่อน',
        'icon': Icons.sports_basketball,
        'color': const Color(0xFFF0AD4E),
        'progress': 0.0,
      },
    ];

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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          return Card(
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
                    child: Icon(route['icon'], color: route['color'], size: 30),
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
                            value: route['progress'],
                            minHeight: 8,
                            backgroundColor: Colors.grey.shade300,
                            color: const Color(0xFF358C46),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${(route['progress'] * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right, color: brownColor, size: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
