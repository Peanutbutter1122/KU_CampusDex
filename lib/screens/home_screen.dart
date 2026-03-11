import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../widgets/top_status_bar.dart';
import 'location_detail_screen.dart';
import 'ranking_screen.dart';
import 'navigation_screen.dart';

// Featured places data for the home carousel
final List<Map<String, dynamic>> _featuredPlaces = [
  {
    'title': 'อาคารเทพรัตน์วิทยโชติ',
    'subtitle': 'สำนักหอสมุด · จุดนัดหมายตากแอร์',
    'url':
        'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fhor_samud.jpg?alt=media&token=2659760d-0e20-4e63-8f8d-132967b4b5fb',
    'waypoint': const AppWayPoint(
      id: 'LIB01',
      name: 'อาคารเทพรัตน์วิทยโชติ (อาคารการเรียนรู้)',
      latitude: 13.848184,
      longitude: 100.571842,
    ),
    'info': const PlaceInfo(
      title: 'อาคารเทพรัตน์วิทยโชติ',
      subtitle: 'สำนักหอสมุด · จุดนัดหมายตากแอร์',
      category: '📚 ห้องสมุด',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fhor_samud.jpg?alt=media&token=2659760d-0e20-4e63-8f8d-132967b4b5fb',
      description: 'อาคารเทพรัตน์วิทยโชติ หรือ "สำนักหอสมุด" เป็นห้องสมุดกลางของมหาวิทยาลัยเกษตรศาสตร์ มีพื้นที่อ่านหนังสือ โซนทำงานกลุ่ม และอินเทอร์เน็ตฟรีสำหรับนิสิต เป็นจุดนัดพบยอดฮิตสำหรับนิสิตที่อยากตากแอร์ระหว่างพักกิจกรรม',
      details: [
        {'icon': Icons.schedule, 'title': 'เวลาทำการ', 'subtitle': 'จันทร์ - ศุกร์: 08:30 - 20:00 น.\nเสาร์ - อาทิตย์: 09:00 - 18:00 น.'},
        {'icon': Icons.wifi, 'title': 'สิ่งอำนวยความสะดวก', 'subtitle': 'KU WiFi, zone อ่านหนังสือเงียบ, คอมพิวเตอร์, ปลั๊กไฟ'},
      ],
      waypoint: AppWayPoint(id: 'LIB01', name: 'อาคารเทพรัตน์วิทยโชติ', latitude: 13.848184, longitude: 100.571842),
    ),
  },
  {
    'title': 'บาร์ใหม่ (โรงอาหารกลาง 1)',
    'subtitle': 'ศูนย์รวมของกินที่ใหญ่ที่สุด',
    'url':
        'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fbar_mai.jpg?alt=media&token=7113001c-3bfd-4ee4-b599-9de23c2d5c14',
    'waypoint': const AppWayPoint(
      id: 'FOOD_BAR01',
      name: 'โรงอาหารกลาง 1 (บาร์ใหม่)',
      latitude: 13.848737,
      longitude: 100.567161,
    ),
    'info': const PlaceInfo(
      title: 'บาร์ใหม่ (โรงอาหารกลาง 1)',
      subtitle: 'ศูนย์รวมของกินที่ใหญ่ที่สุดใน มก.',
      category: '🍽️ โรงอาหาร',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fbar_mai.jpg?alt=media&token=7113001c-3bfd-4ee4-b599-9de23c2d5c14',
      description: 'โรงอาหารกลาง 1 หรือที่เรียกกันว่า "บาร์ใหม่" เป็นโรงอาหารที่ใหญ่ที่สุดในมหาวิทยาลัยเกษตรศาสตร์ มีร้านอาหารและเมนูให้เลือกมากมาย ทั้งอาหารไทย ข้าวราดแกง ก๋วยเตี๋ยว และอาหารจานด่วน เป็นจุดนัดหมายยอดฮิตของนิสิตในช่วงพักกลางวัน',
      details: [
        {'icon': Icons.schedule, 'title': 'เวลาทำการ', 'subtitle': 'จันทร์ - ศุกร์: 07:00 - 18:00 น.'},
        {'icon': Icons.restaurant, 'title': 'ประเภทอาหาร', 'subtitle': 'อาหารไทย, ข้าวราดแกง, ก๋วยเตี๋ยว, อาหารจานด่วน'},
      ],
      waypoint: AppWayPoint(id: 'FOOD_BAR01', name: 'โรงอาหารกลาง 1 (บาร์ใหม่)', latitude: 13.848737, longitude: 100.567161),
    ),
  },
  {
    'title': 'บาร์ใหม่กว่า (โรงอาหารกลาง 2)',
    'subtitle': 'อีกหนึ่งจุดที่คนเยอะไม่แพ้กัน',
    'url':
        'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fbar_mai_kwa.jpg?alt=media&token=2ff8a0be-9509-4db0-8906-308046cf8856',
    'waypoint': const AppWayPoint(
      id: 'FOOD_BAR02',
      name: 'โรงอาหารกลาง 2 (บาร์ใหม่กว่า)',
      latitude: 13.852037,
      longitude: 100.571777,
    ),
    'info': const PlaceInfo(
      title: 'บาร์ใหม่กว่า (โรงอาหารกลาง 2)',
      subtitle: 'อีกหนึ่งจุดที่คนเยอะไม่แพ้กัน',
      category: '🍽️ โรงอาหาร',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fbar_mai_kwa.jpg?alt=media&token=2ff8a0be-9509-4db0-8906-308046cf8856',
      description: 'โรงอาหารกลาง 2 หรือ "บาร์ใหม่กว่า" เป็นโรงอาหารใหม่ที่มีบรรยากาศทันสมัยกว่า ตั้งอยู่บริเวณแถวหอพัก มีเมนูหลากหลายทั้งข้าวแกง ก๋วยเตี๋ยว และเมนูฟิวชั่น เป็นที่นิยมในหมู่นิสิตชั้นปีที่พักในหอ',
      details: [
        {'icon': Icons.schedule, 'title': 'เวลาทำการ', 'subtitle': 'จันทร์ - ศุกร์: 07:00 - 19:00 น.'},
        {'icon': Icons.restaurant, 'title': 'ประเภทอาหาร', 'subtitle': 'อาหารไทย, อาหารตามสั่ง, เครื่องดื่ม'},
      ],
      waypoint: AppWayPoint(id: 'FOOD_BAR02', name: 'โรงอาหารกลาง 2 (บาร์ใหม่กว่า)', latitude: 13.852037, longitude: 100.571777),
    ),
  },
  {
    'title': 'หอประชุมใหญ่ มก.',
    'subtitle': 'จุดถ่ายรูปรับปริญญายอดฮิต',
    'url':
        'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fbig_hor_prachum.jpg?alt=media&token=0f65cb52-b24c-4b39-90e5-918c397579b3',
    'waypoint': const AppWayPoint(
      id: 'CEN_ADM02',
      name: 'หอประชุมใหญ่ มก.',
      latitude: 13.841352,
      longitude: 100.574711,
      isLandmark: true,
    ),
    'info': const PlaceInfo(
      title: 'หอประชุมใหญ่ มก.',
      subtitle: 'จุดถ่ายรูปรับปริญญายอดฮิต',
      category: '🏛️ สถานที่สำคัญ',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fbig_hor_prachum.jpg?alt=media&token=0f65cb52-b24c-4b39-90e5-918c397579b3',
      description: 'หอประชุมใหญ่มหาวิทยาลัยเกษตรศาสตร์ เป็นสถานที่จัดพิธีพระราชทานปริญญาบัตร และงานสำคัญต่างๆ ของมหาวิทยาลัย ด้านหน้ามีต้นนนทรีซึ่งเป็นสัญลักษณ์ของมหาวิทยาลัย และพระพิรุณทรงนาค ซึ่งเป็นจุดถ่ายภาพที่นิสิตนิยมมากที่สุด',
      details: [
        {'icon': Icons.history, 'title': 'ความสำคัญ', 'subtitle': 'สถานที่พระราชทานปริญญาบัตรและงานสำคัญของ มก.'},
        {'icon': Icons.park, 'title': 'สถานที่ใกล้เคียง', 'subtitle': 'ต้นนนทรีทรงปลูก, พระพิรุณทรงนาค, อนุสาวรีย์สามบูรพาจารย์'},
      ],
      waypoint: AppWayPoint(id: 'CEN_ADM02', name: 'หอประชุมใหญ่ มก.', latitude: 13.841352, longitude: 100.574711, isLandmark: true),
    ),
  },
  {
    'title': 'KU Avenue',
    'subtitle': 'ร้านค้าและร้านอาหารหลากหลาย',
    'url':
        'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fku_avanue.jpg?alt=media&token=02675070-6e66-4a03-b98a-310c282afa83',
    'waypoint': const AppWayPoint(
      id: 'FOOD_AVE01',
      name: 'อาคาร KU Avenue (หลังที่ 1)',
      latitude: 13.845789,
      longitude: 100.565406,
    ),
    'info': const PlaceInfo(
      title: 'KU Avenue',
      subtitle: 'ร้านค้าและร้านอาหารหลากหลายสไตล์',
      category: '🛍️ ช้อปปิ้ง & อาหาร',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fku_avanue.jpg?alt=media&token=02675070-6e66-4a03-b98a-310c282afa83',
      description: 'KU Avenue เป็นอาคารร้านค้ารูปแบบใหม่ มีร้านอาหาร คาเฟ่ และร้านค้าหลากหลายรูปแบบ จัดเป็น lifestyle hub สำหรับนิสิตและบุคลากร มีบรรยากาศสบายๆ เหมาะสำหรับนั่งพักผ่อนและสังสรรค์',
      details: [
        {'icon': Icons.store, 'title': 'ร้านค้า', 'subtitle': 'ร้านอาหาร, คาเฟ่, เบเกอรี่, ของฝาก'},
        {'icon': Icons.schedule, 'title': 'เวลาทำการ', 'subtitle': 'ทุกวัน 08:00 - 21:00 น. (แล้วแต่ร้าน)'},
      ],
      waypoint: AppWayPoint(id: 'FOOD_AVE01', name: 'อาคาร KU Avenue (หลังที่ 1)', latitude: 13.845789, longitude: 100.565406),
    ),
  },
  {
    'title': 'Hotto Bun',
    'subtitle': 'ขนมปังอบร้อนๆ ยอดฮิตของเด็กเกษตร',
    'url':
        'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fhotto_bun.jpg?alt=media&token=0bc6c58a-71ea-42b4-9bc5-47fb79e76ced',
    'waypoint': const AppWayPoint(
      id: 'FOOD_AVE02',
      name: 'อาคาร KU Avenue (หลังที่ 2)',
      latitude: 13.85216,
      longitude: 100.57066,
    ),
    'info': const PlaceInfo(
      title: 'Hotto Bun',
      subtitle: 'ขนมปังอบร้อนๆ ยอดฮิตของเด็กเกษตร',
      category: '🥐 เบเกอรี่',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fhotto_bun.jpg?alt=media&token=0bc6c58a-71ea-42b4-9bc5-47fb79e76ced',
      description: 'Hotto Bun ร้านขนมปังและเบเกอรี่ยอดนิยมในมหาวิทยาลัยเกษตรศาสตร์ ขึ้นชื่อด้านขนมปังอบร้อนๆ และเมนูเครื่องดื่มหลากหลาย กลายเป็นจุดแวะพักฮิตสำหรับนิสิตก่อนเข้าเรียน',
      details: [
        {'icon': Icons.schedule, 'title': 'เวลาทำการ', 'subtitle': 'จันทร์ - ศุกร์: 07:00 - 17:00 น.'},
        {'icon': Icons.local_cafe, 'title': 'เมนูแนะนำ', 'subtitle': 'ขนมปังไส้ต่างๆ, ชา, กาแฟ, โกโก้'},
      ],
      waypoint: AppWayPoint(id: 'FOOD_AVE02', name: 'อาคาร KU Avenue (หลังที่ 2)', latitude: 13.85216, longitude: 100.57066),
    ),
  },
  {
    'title': 'STARBUCKS (สารนิเทศ 50 ปี)',
    'subtitle': 'คาเฟ่ที่นิสิตชื่นชอบ',
    'url':
        'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fstarbuck.jpg?alt=media&token=8dfd8b80-3365-4153-86a1-1af54e076173',
    'waypoint': const AppWayPoint(
      id: 'STARBUCKS',
      name: 'STARBUCKS',
      latitude: 13.844402,
      longitude: 100.568894,
    ),
    'info': const PlaceInfo(
      title: 'STARBUCKS (สารนิเทศ 50 ปี)',
      subtitle: 'คาเฟ่ระดับพรีเมียมใจกลาง มก.',
      category: '☕ คาเฟ่',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fstarbuck.jpg?alt=media&token=8dfd8b80-3365-4153-86a1-1af54e076173',
      description: 'Starbucks สาขามหาวิทยาลัยเกษตรศาสตร์ ตั้งอยู่บริเวณอาคารสารนิเทศ 50 ปี เป็นที่นิยมสำหรับนิสิตและอาจารย์ที่ต้องการพักผ่อนและทำงาน ด้วยบรรยากาศสบายและมี WiFi รองรับ',
      details: [
        {'icon': Icons.schedule, 'title': 'เวลาทำการ', 'subtitle': 'ทุกวัน 07:00 - 21:00 น.'},
        {'icon': Icons.local_cafe, 'title': 'เมนูแนะนำ', 'subtitle': 'Coffee, Frappuccino, Tea Latte, เค้กและเบเกอรี่'},
      ],
      waypoint: AppWayPoint(id: 'STARBUCKS', name: 'STARBUCKS', latitude: 13.844402, longitude: 100.568894),
    ),
  },
  {
    'title': 'STARBUCKS (KU Science)',
    'subtitle': 'สตาร์บัคส์ฝั่งคณะวิทยาศาสตร์',
    'url':
        'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fstarbuck_science.jpg?alt=media&token=712ed8fa-2136-4f2c-8859-1c4648a698f6',
    'waypoint': const AppWayPoint(
      id: 'STARBUCKS_SCI',
      name: 'STARBUCKS (Kasetsart Science)',
      latitude: 13.845722,
      longitude: 100.572376,
    ),
    'info': const PlaceInfo(
      title: 'STARBUCKS (KU Science)',
      subtitle: 'สตาร์บัคส์ฝั่งคณะวิทยาศาสตร์',
      category: '☕ คาเฟ่',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fstarbuck_science.jpg?alt=media&token=712ed8fa-2136-4f2c-8859-1c4648a698f6',
      description: 'Starbucks Kasetsart Science ตั้งอยู่บริเวณคณะวิทยาศาสตร์ มหาวิทยาลัยเกษตรศาสตร์ เป็นอีกหนึ่งสาขาที่ได้รับความนิยมจากนิสิตคณะวิทยาศาสตร์และคณะใกล้เคียง บรรยากาศเงียบสงบเหมาะแก่การอ่านหนังสือ',
      details: [
        {'icon': Icons.schedule, 'title': 'เวลาทำการ', 'subtitle': 'ทุกวัน 07:00 - 20:00 น.'},
        {'icon': Icons.place, 'title': 'ที่ตั้ง', 'subtitle': 'บริเวณคณะวิทยาศาสตร์ มหาวิทยาลัยเกษตรศาสตร์'},
      ],
      waypoint: AppWayPoint(id: 'STARBUCKS_SCI', name: 'STARBUCKS (Kasetsart Science)', latitude: 13.845722, longitude: 100.572376),
    ),
  },
  {
    'title': 'NESCAFÉ',
    'subtitle': 'กาแฟสดใกล้มือ ราคาเป็นมิตร',
    'url':
        'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fnescafe.jpg?alt=media&token=ac959a28-81b3-4107-afc8-ae26aa5f08b3',
    'waypoint': const AppWayPoint(
      id: 'NESCAFÉ',
      name: 'NESCAFÉ',
      latitude: 13.848662,
      longitude: 100.566687,
    ),
    'info': const PlaceInfo(
      title: 'NESCAFÉ',
      subtitle: 'กาแฟสดใกล้มือ ราคาเป็นมิตร',
      category: '☕ คาเฟ่',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Fnescafe.jpg?alt=media&token=ac959a28-81b3-4107-afc8-ae26aa5f08b3',
      description: 'ร้าน NESCAFÉ ใน มก. เป็นทางเลือกกาแฟที่ราคาย่อมเยาสำหรับนิสิต มีทั้งกาแฟร้อน กาแฟเย็น และเครื่องดื่มอื่นๆ ตั้งอยู่ใกล้โรงอาหารกลาง สะดวกสำหรับแวะซื้อก่อนเข้าเรียน',
      details: [
        {'icon': Icons.schedule, 'title': 'เวลาทำการ', 'subtitle': 'จันทร์ - ศุกร์: 07:00 - 17:00 น.'},
        {'icon': Icons.local_cafe, 'title': 'เมนูแนะนำ', 'subtitle': 'กาแฟร้อน/เย็น, ชา, โกโก้, น้ำผลไม้'},
      ],
      waypoint: AppWayPoint(id: 'NESCAFÉ', name: 'NESCAFÉ', latitude: 13.848662, longitude: 100.566687),
    ),
  },
  {
    'title': 'อาคารระพีสาคริก',
    'subtitle': 'Study Hub ยอดนิยมของนิสิต มก.',
    'url':
        'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Frapee.jpg?alt=media&token=cf996362-4487-4f5f-b6cf-bf6a4053beb3',
    'waypoint': const AppWayPoint(
      id: 'CEN_ADM04',
      name: 'อาคารระพีสาคริก',
      latitude: 13.847653,
      longitude: 100.569553,
    ),
    'info': const PlaceInfo(
      title: 'อาคารระพีสาคริก',
      subtitle: 'Study Hub ยอดนิยมของนิสิต มก.',
      category: '📍 Study Spot',
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/ku-campus-dex.firebasestorage.app/o/homelanding%2Frapee.jpg?alt=media&token=cf996362-4487-4f5f-b6cf-bf6a4053beb3',
      description: 'อาคารระพีสาคริก เป็นหอสมุดและศูนย์บริการข้อมูลข่าวสารสำหรับการศึกษาและค้นคว้าวิจัย มีพื้นที่สำหรับอ่านหนังสือ ทำงานกลุ่ม และคอมพิวเตอร์ไว้บริการนิสิต ซึ่งมักเป็นที่นัดหมายยอดฮิตของนิสิตทุกชั้นปี',
      details: [
        {'icon': Icons.schedule, 'title': 'เวลาทำการ', 'subtitle': 'จันทร์ - ศุกร์: 08:30 - 20:00 น.\nเสาร์ - อาทิตย์: 09:00 - 18:00 น.'},
        {'icon': Icons.wifi, 'title': 'สิ่งอำนวยความสะดวก', 'subtitle': 'KU WiFi, ห้องอเนกประสงค์, ปลั๊กไฟ, คาเฟ่'},
      ],
      waypoint: AppWayPoint(id: 'CEN_ADM04', name: 'อาคารระพีสาคริก', latitude: 13.847653, longitude: 100.569553),
    ),
  },
];

class HomeScreen extends StatefulWidget {
  final Function(AppWayPoint) onExploreTap;

  const HomeScreen({super.key, required this.onExploreTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 2), (_) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % _featuredPlaces.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color customGreen = Color(0xFF358C46);

    return Scaffold(
      body: Stack(
        children: [
          // Background stripes
          Row(
            children: List.generate(
              10,
              (index) => Expanded(
                child: Container(
                  color: index % 2 == 0
                      ? const Color(0xFFFDF8ED)
                      : const Color(0xFFE8F1E9),
                ),
              ),
            ),
          ),

          Column(
            children: [
              // Green top bar
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

              Expanded(
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'เริ่มสำรวจสถานที่ใหม่! 🌟',
                          style: TextStyle(
                            fontFamily: 'Georgia',
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: brownColor,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Carousel
                        Expanded(
                          child: Stack(
                            children: [
                              PageView.builder(
                                controller: _pageController,
                                itemCount: _featuredPlaces.length,
                                onPageChanged: (i) =>
                                    setState(() => _currentPage = i),
                                itemBuilder: (context, index) {
                                  final place = _featuredPlaces[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => LocationDetailScreen(
                                            placeInfo: place['info'] as PlaceInfo?,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(32),
                                        border: Border.all(
                                          color: brownColor,
                                          width: 4,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 10,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(28),
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: place['url']!,
                                              fit: BoxFit.cover,
                                              placeholder: (ctx, url) =>
                                                  Container(
                                                    color: Colors.grey[300],
                                                  ),
                                              errorWidget: (ctx, url, e) =>
                                                  Container(
                                                    color: Colors.grey[300],
                                                  ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    Colors.black.withOpacity(
                                                      0.85,
                                                    ),
                                                    Colors.black.withOpacity(
                                                      0.3,
                                                    ),
                                                    Colors.transparent,
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                24.0,
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    place['title']!,
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 26,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      shadows: [
                                                        Shadow(
                                                          color: Colors.black54,
                                                          blurRadius: 4,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.location_on,
                                                        color: Colors.white70,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Expanded(
                                                        child: Text(
                                                          place['subtitle']!,
                                                          style:
                                                              const TextStyle(
                                                                color: Colors
                                                                    .white70,
                                                                fontSize: 14,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        final wp = place['waypoint'] as AppWayPoint?;
                                                        if (wp != null) {
                                                          widget.onExploreTap(wp);
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 12,
                                                            ),
                                                        decoration: BoxDecoration(
                                                          color: customGreen,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                30,
                                                              ),
                                                          border: Border.all(
                                                            color: Colors.white,
                                                            width: 2,
                                                          ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black38,
                                                              blurRadius: 4,
                                                              offset: Offset(
                                                                0,
                                                                2,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        child: const Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Text(
                                                              'ออกเดินทางเลย',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                            SizedBox(width: 6),
                                                            Icon(
                                                              Icons
                                                                  .directions_walk,
                                                              color:
                                                                  Colors.white,
                                                              size: 22,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),

                              // Dot indicators
                              Positioned(
                                bottom: 12,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    _featuredPlaces.length,
                                    (i) => AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 3,
                                      ),
                                      width: _currentPage == i ? 20 : 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        color: _currentPage == i
                                            ? Colors.white
                                            : Colors.white54,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Ranking button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RankingScreen(),
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
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
