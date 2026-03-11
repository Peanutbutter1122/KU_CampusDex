import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/badge_data.dart';

class BadgeScreen extends StatelessWidget {
  const BadgeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color creamBg = Color(0xFFFDF8ED);

    final user = FirebaseAuth.instance.currentUser;

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
      body: user == null
          ? const Center(child: Text('กรุณาเข้าสู่ระบบก่อน'))
          : StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user.uid)
                  .snapshots()
                  .handleError((e) {
                    debugPrint('BadgeScreen stream error: $e');
                  }),
              builder: (context, snapshot) {
                // รวบรวม place ID ที่ check-in แล้ว
                Set<String> checkedInIds = {};
                Set<String> unlockedBadgeIds = {};

                if (snapshot.hasData && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  // ใช้ keys ของ map แทน array (ไม่มี duplicate)
                  final rawMap =
                      data['checked_in_places_map'] as Map<dynamic, dynamic>? ??
                      {};
                  checkedInIds = rawMap.keys
                      .map((k) => k.toString())
                      .where((id) => id.isNotEmpty)
                      .toSet();
                  unlockedBadgeIds = Set<String>.from(
                    data['unlocked_badges'] as List<dynamic>? ?? [],
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: BadgeData.all.length,
                  itemBuilder: (context, index) {
                    final badge = BadgeData.all[index];
                    final bool isUnlocked = unlockedBadgeIds.contains(badge.id);

                    // คำนวณ progress
                    final int total = badge.requirements.length;
                    final int done = badge.requirements
                        .where((r) => checkedInIds.contains(r.placeId))
                        .length;

                    return GestureDetector(
                      onTap: () => _showBadgeDetail(
                        context,
                        badge,
                        isUnlocked,
                        checkedInIds,
                      ),
                      child: _BadgeCard(
                        badge: badge,
                        isUnlocked: isUnlocked,
                        done: done,
                        total: total,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  void _showBadgeDetail(
    BuildContext context,
    AppBadge badge,
    bool isUnlocked,
    Set<String> checkedInIds,
  ) {
    const Color brownColor = Color(0xFF3B2213);
    const Color creamBg = Color(0xFFFDF8ED);

    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.75,
          ),
          decoration: BoxDecoration(
            color: creamBg,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isUnlocked ? badge.color : Colors.grey.shade400,
              width: 2.5,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isUnlocked
                      ? badge.color.withOpacity(0.15)
                      : Colors.grey.shade100,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Badge icon
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isUnlocked
                            ? badge.color.withOpacity(0.15)
                            : Colors.grey.shade200,
                        border: Border.all(
                          color: isUnlocked
                              ? badge.color
                              : Colors.grey.shade400,
                          width: 3,
                        ),
                      ),
                      child: Icon(
                        badge.icon,
                        size: 44,
                        color: isUnlocked ? badge.color : Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      badge.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isUnlocked ? brownColor : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isUnlocked ? '🔓 ปลดล็อกแล้ว!' : '🔒 ยังไม่ปลดล็อก',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isUnlocked
                            ? Colors.green.shade700
                            : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              // Body — scrollable
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Detail text
                      Text(
                        badge.detail,
                        style: const TextStyle(
                          fontSize: 14,
                          color: brownColor,
                          height: 1.5,
                        ),
                      ),

                      if (badge.requirements.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        const Text(
                          'สถานที่ที่ต้องไป Check-in:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: brownColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ...badge.requirements.map((req) {
                          final bool done = checkedInIds.contains(req.placeId);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              children: [
                                Icon(
                                  done
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  size: 20,
                                  color: done
                                      ? Colors.green.shade600
                                      : Colors.grey.shade400,
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    req.placeName,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: done
                                          ? brownColor
                                          : Colors.grey.shade500,
                                      decoration: done
                                          ? TextDecoration.none
                                          : TextDecoration.none,
                                      fontWeight: done
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ] else ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: badge.color.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: badge.color.withOpacity(0.3),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.star, color: Color(0xFFF39C12)),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'ปลดล็อก Badge อื่นๆ อย่างน้อย 5 ใบเพื่อรับ Badge นี้!',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF3B2213),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Close button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isUnlocked ? badge.color : Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text(
                      'ปิด',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Badge Card Widget ─────────────────────────────────────────────────────────
class _BadgeCard extends StatelessWidget {
  final AppBadge badge;
  final bool isUnlocked;
  final int done;
  final int total;

  const _BadgeCard({
    required this.badge,
    required this.isUnlocked,
    required this.done,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isUnlocked
            ? badge.color.withOpacity(0.08)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUnlocked ? badge.color : Colors.grey.shade300,
          width: isUnlocked ? 2.5 : 1.5,
        ),
        boxShadow: [
          if (isUnlocked)
            BoxShadow(
              color: badge.color.withOpacity(0.25),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with circular border
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isUnlocked
                  ? badge.color.withOpacity(0.15)
                  : Colors.grey.shade200,
              border: Border.all(
                color: isUnlocked ? badge.color : Colors.grey.shade300,
                width: 2,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    badge.icon,
                    size: 38,
                    color: isUnlocked ? badge.color : Colors.grey.shade400,
                  ),
                ),
                if (isUnlocked)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.green.shade600,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                if (!isUnlocked)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.lock,
                        size: 11,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Badge name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              badge.title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isUnlocked ? brownColor : Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          // Progress
          if (!isUnlocked && total > 0) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: done / total,
                  backgroundColor: Colors.grey.shade300,
                  color: badge.color,
                  minHeight: 5,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$done/$total',
              style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
            ),
          ] else if (isUnlocked) ...[
            Text(
              'ปลดล็อกแล้ว ✓',
              style: TextStyle(
                fontSize: 11,
                color: Colors.green.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const SizedBox(height: 4),
          // Hint to tap
          Text(
            'กดเพื่อดูรายละเอียด',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }
}
