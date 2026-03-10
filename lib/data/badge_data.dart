import 'package:flutter/material.dart';

/// AppBadge — นิยาม badge แต่ละใบ
class AppBadge {
  final String id;
  final String title;
  final String description; // คำอธิบายสั้นๆ สำหรับแสดงในกริด
  final String detail; // อธิบาย badge/เงื่อนไข สำหรับ popup
  final IconData icon;
  final Color color;
  final List<BadgeRequirement> requirements;
  final bool isSpecial; // badge พิเศษ (เช่น KU Explorer)

  const AppBadge({
    required this.id,
    required this.title,
    required this.description,
    required this.detail,
    required this.icon,
    required this.color,
    required this.requirements,
    this.isSpecial = false,
  });

  /// คืนค่า true ถ้า checkedInIds ครอบคลุม requirement ทั้งหมด (หรือจำนวนขั้นต่ำ)
  bool isUnlocked(Set<String> checkedInIds) {
    if (isSpecial) {
      // KU Explorer: ต้องปลดล็อก badge อื่นอย่างน้อย 5 ใบ (ตรวจจาก caller)
      return false; // handled separately
    }
    int done = requirements.where((r) => checkedInIds.contains(r.placeId)).length;
    return done >= requirements.length;
  }

  /// คำนวณ badge ที่ปลดล็อกแล้วจาก checkedInIds รวม KU Explorer
  static List<String> evaluateUnlockedIds(
    Set<String> checkedInIds,
    List<AppBadge> allBadges,
  ) {
    final List<String> unlocked = [];
    int normalUnlocked = 0;
    for (final b in allBadges) {
      if (b.isSpecial) continue;
      if (b.isUnlocked(checkedInIds)) {
        unlocked.add(b.id);
        normalUnlocked++;
      }
    }
    // KU Explorer: ต้องปลดล็อก badge ปกติอย่างน้อย 5 ใบ
    if (normalUnlocked >= 5) {
      unlocked.add('ku_explorer');
    }
    return unlocked;
  }
}

/// สถานที่ที่ต้องไป check-in เพื่อปลดล็อก badge
class BadgeRequirement {
  final String placeId;
  final String placeName;

  const BadgeRequirement({required this.placeId, required this.placeName});
}

/// รายการ badge ทั้งหมดของ KU CampusDex
class BadgeData {
  static const List<AppBadge> all = [
    // ──────────────────────────────
    // 1. Food Explorer — ของกินยอดฮิต
    // ──────────────────────────────
    AppBadge(
      id: 'food_explorer',
      title: 'Food Explorer',
      description: 'สำรวจทุกโรงอาหารใน มก.',
      detail: 'Check-in โรงอาหารหลักทั้ง 4 แห่ง เพื่อรู้จักทุกรสชาติของ มก.',
      icon: Icons.restaurant,
      color: Color(0xFFE74C3C),
      requirements: [
        BadgeRequirement(placeId: 'FOOD_BAR01', placeName: 'โรงอาหารกลาง 1 (บาร์ใหม่)'),
        BadgeRequirement(placeId: 'FOOD_BAR02', placeName: 'โรงอาหารกลาง 2 (บาร์ใหม่กว่า)'),
        BadgeRequirement(placeId: 'FOOD_BAR03', placeName: 'โรงอาหารคณะวนศาสตร์ (บาร์ไม้)'),
        BadgeRequirement(placeId: 'FOOD_BAR04', placeName: 'โรงอาหารคณะสัตวแพทยศาสตร์ (บาร์หมา)'),
      ],
    ),

    // ──────────────────────────────
    // 2. Café Hopper — สายกาแฟ
    // ──────────────────────────────
    AppBadge(
      id: 'cafe_hopper',
      title: 'Café Hopper',
      description: 'ชิมกาแฟครบทุกร้านใน มก.',
      detail: 'Check-in ร้านกาแฟและเบเกอรี่ยอดฮิต 3 แห่ง',
      icon: Icons.local_cafe,
      color: Color(0xFF6F4E37),
      requirements: [
        BadgeRequirement(placeId: 'STARBUCKS', placeName: 'STARBUCKS'),
        BadgeRequirement(placeId: 'NESCAFÉ', placeName: 'NESCAFÉ'),
        BadgeRequirement(placeId: 'Hotto Bun', placeName: 'Hotto Bun'),
      ],
    ),

    // ──────────────────────────────
    // 3. Library Owl — หนอนหนังสือ
    // ──────────────────────────────
    AppBadge(
      id: 'library_owl',
      title: 'Library Owl',
      description: 'ผู้คลั่งไคล้ห้องสมุด',
      detail: 'Check-in ห้องสมุดและ learning hub ทั้ง 2 แห่ง',
      icon: Icons.local_library,
      color: Color(0xFF2471A3),
      requirements: [
        BadgeRequirement(placeId: 'LIB01', placeName: 'อาคารเทพรัตน์วิทยโชติ (ห้องสมุดกลาง)'),
        BadgeRequirement(placeId: 'LIB02', placeName: 'อาคารช่วงเกษตรศิลปการ'),
      ],
    ),

    // ──────────────────────────────
    // 4. Study Hub — นักเรียนตัวยง
    // ──────────────────────────────
    AppBadge(
      id: 'study_hub',
      title: 'Study Hub',
      description: 'เรียนครบทุกศูนย์เรียนรวม',
      detail: 'Check-in ศูนย์เรียนรวมทั้ง 4 แห่ง',
      icon: Icons.menu_book,
      color: Color(0xFF1ABC9C),
      requirements: [
        BadgeRequirement(placeId: 'CEN_LRN01', placeName: 'ศูนย์เรียนรวม 1'),
        BadgeRequirement(placeId: 'CEN_LRN02', placeName: 'ศูนย์เรียนรวม 2'),
        BadgeRequirement(placeId: 'CEN_LRN03', placeName: 'ศูนย์เรียนรวม 3'),
        BadgeRequirement(placeId: 'CEN_LRN04', placeName: 'ศูนย์เรียนรวม 4'),
      ],
    ),

    // ──────────────────────────────
    // 5. KU Heritage — รักษาประวัติศาสตร์
    // ──────────────────────────────
    AppBadge(
      id: 'ku_heritage',
      title: 'KU Heritage',
      description: 'สักการะสถานที่สำคัญของ มก.',
      detail: 'Check-in สถานที่ทางประวัติศาสตร์และสัญลักษณ์ 3 แห่ง',
      icon: Icons.account_balance,
      color: Color(0xFFD4AC0D),
      requirements: [
        BadgeRequirement(placeId: 'CEN_ADM02', placeName: 'หอประชุมใหญ่ มก.'),
        BadgeRequirement(placeId: 'LND_01', placeName: 'อนุสาวรีย์สามบูรพาจารย์ (สามเสือเกษตร)'),
        BadgeRequirement(placeId: 'LND_02', placeName: 'พระพิรุณทรงนาค'),
      ],
    ),

    // ──────────────────────────────
    // 6. Sports Champ — สายกีฬา
    // ──────────────────────────────
    AppBadge(
      id: 'sports_champ',
      title: 'Sports Champ',
      description: 'สายกีฬาตัวจริง',
      detail: 'Check-in สิ่งอำนวยความสะดวกด้านกีฬา 3 แห่ง',
      icon: Icons.sports_tennis,
      color: Color(0xFFE67E22),
      requirements: [
        BadgeRequirement(placeId: 'SPO01', placeName: 'สนามอินทรีย์จันทรสถิตย์'),
        BadgeRequirement(placeId: 'SPO06', placeName: 'อาคารสระว่ายน้ำจุฬาภรณ์วลัยลักษณ์'),
        BadgeRequirement(placeId: 'SPO10', placeName: 'สนามเทนนิส'),
      ],
    ),

    // ──────────────────────────────
    // 7. Campus Shopper — สายช้อป
    // ──────────────────────────────
    AppBadge(
      id: 'campus_shopper',
      title: 'Campus Shopper',
      description: 'ช้อปครบทุกจุดใน มก.',
      detail: 'Check-in จุดช้อปปิ้งและร้านสหกรณ์ 3 แห่ง',
      icon: Icons.shopping_bag,
      color: Color(0xFF8E44AD),
      requirements: [
        BadgeRequirement(placeId: 'FOOD_AVE01', placeName: 'KU Avenue (หลังที่ 1)'),
        BadgeRequirement(placeId: 'FOOD_AVE02', placeName: 'KU Avenue (หลังที่ 2)'),
        BadgeRequirement(placeId: 'FOOD_COOP', placeName: 'ร้านค้าสหกรณ์ มก.'),
      ],
    ),

    // ──────────────────────────────
    // 8. Science Nerd — สายวิทย์
    // ──────────────────────────────
    AppBadge(
      id: 'science_nerd',
      title: 'Science Nerd',
      description: 'นักวิทยาศาสตร์แห่ง มก.',
      detail: 'Check-in อาคารวิทยาศาสตร์อย่างน้อย 3 แห่ง',
      icon: Icons.science,
      color: Color(0xFF17A589),
      requirements: [
        BadgeRequirement(placeId: 'SCI07', placeName: 'อาคารยงยุทธ เจียมไชยศรี'),
        BadgeRequirement(placeId: 'SCI09', placeName: 'อาคารวิฑูรย์ หงส์สุมาลย์'),
        BadgeRequirement(placeId: 'SCI11', placeName: 'อาคารปฏิบัติการวิทยาศาสตร์กายภาพ'),
      ],
    ),

    // ──────────────────────────────
    // 9. Nature Lover — รักธรรมชาติ
    // ──────────────────────────────
    AppBadge(
      id: 'nature_lover',
      title: 'Nature Lover',
      description: 'หลงรักธรรมชาติและป่าไม้',
      detail: 'Check-in สถานที่เกษตรและวนศาสตร์ 3 แห่ง',
      icon: Icons.forest,
      color: Color(0xFF27AE60),
      requirements: [
        BadgeRequirement(placeId: 'FOR08', placeName: 'อาคารปฏิบัติการวนศาสตร์ 72 ปี'),
        BadgeRequirement(placeId: 'AGR49', placeName: 'อาคารคณะเกษตร'),
        BadgeRequirement(placeId: 'ENV01', placeName: 'อาคารเรียนและปฏิบัติการ คณะสิ่งแวดล้อม'),
      ],
    ),

    // ──────────────────────────────
    // 10. KU Explorer — สำรวจครบ (special)
    // ──────────────────────────────
    AppBadge(
      id: 'ku_explorer',
      title: 'KU Explorer',
      description: 'นักสำรวจขั้นสูงสุดแห่ง มก.',
      detail: 'ปลดล็อก badge อื่นๆ ให้ได้อย่างน้อย 5 ใบเพื่อรับเหรียญสูงสุดนี้!',
      icon: Icons.explore,
      color: Color(0xFFF39C12),
      isSpecial: true,
      requirements: [], // ไม่มี requirement แทน — ตรวจแยก
    ),
  ];
}
