import 'package:flutter/material.dart';
import 'package:final_project/widgets/boxframe.dart';


class BadgePage extends StatefulWidget {
  const BadgePage({super.key});

  @override
  State<BadgePage> createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  int _selectedIndex = 2;


  @override
  Widget build(BuildContext context) {
    return  _buildBadgeContent();
  }

  Widget _buildBadgeContent() {

    final badges = [
    {'title': 'ก้าวแรก', 'done': true},
    {'title': 'บาร์ใหม่', 'done': true},
    {'title': 'นักล่า3บาร์', 'done': false},
    {'title': 'หนอนหนังสือ', 'done': false},
    {'title': 'สถานพยาบาล', 'done': false},
    {'title': 'เซียนรถตะลุย', 'done': false},
    {'title': 'KU 100%', 'done': false},
    {'title': 'สายกีฬา', 'done': false},
    {'title': 'นักสำรวจ', 'done': false},
  ];

    return Stack(
      children: [
        Positioned.fill(
          child: Row(
            children: List.generate(10, (index) => Expanded(
              child: Container(
                color: index % 2 == 0 ? const Color(0xFFE6F3F0) : Colors.white,
              ),
            )),
          ),
          
        ),
         Column(
          children: [
            const SizedBox(height: 24),
          const Text(
            "เหรียญตราที่สะสมได้",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: badges.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final badge = badges[index];
                final isUnlocked = badge['done'] as bool;

                return Boxframe(
                  label: badge['title'] as String,
                  showCheck: isUnlocked,
                  inner: Center(
                    child: isUnlocked
                    ? const Icon(Icons.emoji_events, size: 42, color: Color(0xFFB68A2C))
                    : const Icon(Icons.lock, size: 40, color: Colors.grey),
                    
                  )
                );
              },
            ),),
          ],
        ),
      ],
    );
  }

}