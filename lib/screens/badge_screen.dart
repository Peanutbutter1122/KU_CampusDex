import 'package:flutter/material.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color creamBg = Color(0xFFFDF8ED);

    final List<Map<String, dynamic>> badges = [
      {
        'title': 'KU Explorer',
        'subtitle': 'รู้จัก KU ครบ 100%',
        'icon': Icons.military_tech,
        'unlocked': false,
      },
      {
        'title': 'KU Starter',
        'subtitle': 'ผ่านสัปดาห์แรก',
        'icon': Icons.school,
        'unlocked': true,
      },
      {
        'title': 'Student Services',
        'subtitle': 'เอกสารเป๊ะ',
        'icon': Icons.assignment_turned_in,
        'unlocked': true,
      },
      {
        'title': 'Study Spots',
        'subtitle': 'หนอนหนังสือ',
        'icon': Icons.local_library,
        'unlocked': false,
      },
      {
        'title': 'Food Master',
        'subtitle': 'กูรูของกิน',
        'icon': Icons.fastfood,
        'unlocked': false,
      },
      {
        'title': 'Safety First',
        'subtitle': 'ปลอดภัยไว้ก่อน',
        'icon': Icons.health_and_safety,
        'unlocked': false,
      },
      {
        'title': 'Sports & Chill',
        'subtitle': 'สายชิวและกีฬา',
        'icon': Icons.sports_tennis,
        'unlocked': false,
      },
    ];

    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        title: const Text(
          'Badges (เหรียญตรา)',
          style: TextStyle(fontWeight: FontWeight.bold, color: brownColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: badges.length,
        itemBuilder: (context, index) {
          final badge = badges[index];
          final bool isUnlocked = badge['unlocked'];

          return Container(
            decoration: BoxDecoration(
              color: isUnlocked
                  ? const Color(0xFFFFF7D6)
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isUnlocked
                    ? const Color(0xFFFFC107)
                    : Colors.grey.shade400,
                width: 3,
              ),
              boxShadow: [
                if (isUnlocked)
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  badge['icon'],
                  size: 60,
                  color: isUnlocked
                      ? const Color(0xFFFF9800)
                      : Colors.grey.shade400,
                ),
                const SizedBox(height: 12),
                Text(
                  badge['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isUnlocked ? brownColor : Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  badge['subtitle'],
                  style: TextStyle(
                    fontSize: 12,
                    color: isUnlocked
                        ? brownColor.withOpacity(0.7)
                        : Colors.grey.shade500,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (!isUnlocked) ...[
                  const SizedBox(height: 8),
                  Icon(Icons.lock, size: 16, color: Colors.grey.shade500),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
