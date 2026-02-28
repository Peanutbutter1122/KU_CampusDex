import 'package:flutter/material.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color creamBg = Color(0xFFFDF8ED);

    final List<Map<String, dynamic>> ranks = [
      {
        'name': 'พี่เนียนปี 4',
        'level': 99,
        'exp': 15000,
        'avatar': 'https://i.pravatar.cc/150?img=68',
      },
      {
        'name': 'Kasetsart GUY',
        'level': 12,
        'exp': 3200,
        'avatar': 'https://i.pravatar.cc/150?img=11',
      },
      {
        'name': 'Nong Freshy',
        'level': 8,
        'exp': 1500,
        'avatar': 'https://i.pravatar.cc/150?img=5',
      },
      {
        'name': 'KU Runner',
        'level': 7,
        'exp': 1200,
        'avatar': 'https://i.pravatar.cc/150?img=12',
      },
      {
        'name': 'Late to Class',
        'level': 5,
        'exp': 800,
        'avatar': 'https://i.pravatar.cc/150?img=33',
      },
      {
        'name': 'Cat Lover',
        'level': 3,
        'exp': 450,
        'avatar': 'https://i.pravatar.cc/150?img=47',
      },
      {
        'name': 'Sleepy Student',
        'level': 2,
        'exp': 200,
        'avatar': 'https://i.pravatar.cc/150?img=59',
      },
    ];

    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        title: const Text(
          'Top Explorers (จัดอันดับ)',
          style: TextStyle(fontWeight: FontWeight.bold, color: brownColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ranks.length,
        itemBuilder: (context, index) {
          final user = ranks[index];
          final bool isTop3 = index < 3;
          final Color cardColor = isTop3
              ? (index == 0
                    ? const Color(0xFFFFD700)
                    : index == 1
                    ? const Color(0xFFC0C0C0)
                    : const Color(0xFFCD7F32))
              : Colors.white;

          return Card(
            elevation: isTop3 ? 8 : 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: isTop3
                  ? const BorderSide(color: brownColor, width: 2)
                  : BorderSide.none,
            ),
            color: isTop3 ? cardColor.withOpacity(0.3) : Colors.white,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '#${index + 1}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isTop3 ? cardColor : Colors.grey,
                      shadows: isTop3
                          ? [const Shadow(blurRadius: 2, color: Colors.black45)]
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(user['avatar']),
                  ),
                ],
              ),
              title: Text(
                user['name'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: brownColor,
                ),
              ),
              subtitle: Text(
                'Level ${user['level']} • EXP: ${user['exp']}',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: isTop3
                  ? const Icon(Icons.star, color: Colors.amber, size: 30)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
