import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/badge_data.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color creamBg = Color(0xFFFDF8ED);

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
        leading: const BackButton(color: brownColor),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .orderBy('level', descending: true)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('เกิดข้อผิดพลาด: ${snapshot.error}'));
          }
          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(
              child: Text(
                'ยังไม่มีนักสำรวจในระบบ\nออกไปสำรวจกันเลย!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final currentUid = FirebaseAuth.instance.currentUser?.uid;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final uid = docs[index].id;
              final name =
                  data['displayName'] as String? ??
                  data['email'] as String? ??
                  'ผู้สำรวจ';
              final level = data['level'] as int? ?? 0;
              final isMe = uid == currentUid;
              final isTop3 = index < 3;
              final Color medalColor = index == 0
                  ? const Color(0xFFFFD700)
                  : index == 1
                  ? const Color(0xFFC0C0C0)
                  : const Color(0xFFCD7F32);

              // Badge icons — ดึงจาก Firestore
              final List<String> unlockedBadgeIds = List<String>.from(
                data['unlocked_badges'] as List<dynamic>? ?? [],
              );
              // หา AppBadge สำหรับแต่ละ ID ที่ปลดล็อก (สูงสุด 5 อัน)
              final List<AppBadge> shownBadges = BadgeData.all
                  .where((b) => unlockedBadgeIds.contains(b.id))
                  .take(5)
                  .toList();

              return Card(
                elevation: isTop3 ? 8 : 2,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: isMe
                      ? const BorderSide(color: Color(0xFF358C46), width: 3)
                      : isTop3
                      ? const BorderSide(color: brownColor, width: 2)
                      : BorderSide.none,
                ),
                color: isTop3
                    ? medalColor.withOpacity(0.15)
                    : isMe
                    ? const Color(0xFFE8F5E9)
                    : Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      // Rank + Avatar
                      Text(
                        isTop3 ? ['🥇', '🥈', '🥉'][index] : '#${index + 1}',
                        style: TextStyle(
                          fontSize: isTop3 ? 24 : 18,
                          fontWeight: FontWeight.bold,
                          color: isTop3 ? medalColor : Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isMe ? const Color(0xFF358C46) : brownColor,
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/character.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Name + level + badges
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: brownColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isMe)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF358C46),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Text(
                                      'คุณ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Level $level  •  ${unlockedBadgeIds.length} badge',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),

                            // Badge icons row
                            if (shownBadges.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Row(
                                children: shownBadges.map((b) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 4),
                                    child: Tooltip(
                                      message: b.title,
                                      child: Container(
                                        width: 26,
                                        height: 26,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: b.color.withOpacity(0.15),
                                          border: Border.all(
                                            color: b.color,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Icon(
                                          b.icon,
                                          size: 13,
                                          color: b.color,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Star for top 3
                      if (isTop3)
                        Icon(Icons.star, color: medalColor, size: 28),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
