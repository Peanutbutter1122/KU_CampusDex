import 'package:flutter/material.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'home_screen.dart';
import 'map_screen.dart';
import 'guided_route_screen.dart';
import 'badge_screen.dart';
import 'gallery_screen.dart';
import 'navigation_screen.dart';

class MainScreen extends StatefulWidget {
  final CameraOptions cameraOptions;

  const MainScreen({super.key, required this.cameraOptions});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<bool> _isLoaded = [true, false, false, false, false];
  AppWayPoint? _currentDestination;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index >= 0 && index < _isLoaded.length) {
        _isLoaded[index] = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color darkGreen = Color(0xFF2A7A4F);
    const Color brownColor = Color(0xFF3B2213);
    const Color unselectedColor = Color(0xFF8F7B71);
    const Color creamBg = Color(0xFFFDF8ED);

    // หน้าต่างๆ ที่กดได้จาก BottomNavigationBar
    final List<Widget> pages = [
      HomeScreen(
        onExploreTap: () => _onTabTapped(2),
      ), // 0: หน้าหลัก (มีภาพใหญ่ตรงกลาง)
      GuidedRouteScreen(
        onNavigateTap: (AppWayPoint wp) {
          setState(() {
            _currentDestination = wp;
            _currentIndex = 2; // Switch to Map tab
            _isLoaded[2] = true;
          });
        },
      ), // 1: แนะนำเส้นทาง
      MapScreen(
        cameraOptions: widget.cameraOptions,
        destination: _currentDestination,
        onClearDestination: () {
          setState(() {
            _currentDestination = null;
          });
        },
      ), // 2: ตรงกลาง (แผนที่ / เริ่มเดินทางแบบอิสระ)
      const BadgeScreen(), // 3: เหรียญรางวัล
      const GalleryScreen(), // 4: แกลเลอรี่
    ];

    return Scaffold(
      // 1. ตัวเลือกใช้ IndexedStack ร่วมกับ Lazy Loading เพื่อคงสถานะ Map ไว้และไม่ให้แอปค้าง
      body: IndexedStack(
        index: _currentIndex,
        children: List.generate(pages.length, (index) {
          if (_isLoaded[index]) {
            return pages[index];
          } else {
            return const SizedBox();
          }
        }),
      ),

      // 2. ปุ่มตรงกลางตามที่อาจารย์ต้องการ: "ให้ตรงกลางเป็น รูปภาพตัวอย่างของสถานที่"
      floatingActionButton: SizedBox(
        width: 76,
        height: 76,
        child: FloatingActionButton(
          onPressed: () => _onTabTapped(2),
          backgroundColor: brownColor, // กรอบวงนอกสีน้ำตาล
          elevation: 6,
          shape: const CircleBorder(
            side: BorderSide(
              color: Colors.white,
              width: 4,
            ), // กรอบวงในสีขาวหนาๆ แบบกระดุม
          ),
          child: ClipOval(
            child: Image.network(
              // รูปภาพตัวอย่างสถานที่เพื่อความสวยงามและน่าเดินทาง
              // (อ้างอิงจาก comment ของอาจารย์)
              'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?auto=format&fit=crop&w=200&q=80',
              width: 76,
              height: 76,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked, // ฝังตรงกลาง BottomNavBar
      // 3. ใช้ BottomAppBar แทนที่ปุ่มเนื้อหาใหญ่ๆ ตรงกลางหน้าจอเดิมๆ เพื่อให้มินิมอลและเป็นธรรมชาติของแอป
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10.0, // เพิ่มช่องว่างรอบวงกลมตรงกลาง
        color: creamBg, // สอดคล้องกับโทนสีครีมของ App
        elevation: 16,
        // เพิ่มเส้นกรอบสีน้ำตาลด้านบน
        child: Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Color(0xFF3B2213), width: 3)),
          ),
          height: 65,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ฝั่งซ้าย
              _buildNavItem(
                icon: Icons.home,
                label: 'หน้าหลัก',
                index: 0,
                isSelected: _currentIndex == 0,
                activeColor: darkGreen,
                inactiveColor: unselectedColor,
              ),
              _buildNavItem(
                icon: Icons.explore,
                label: 'นำเที่ยว',
                index: 1,
                isSelected: _currentIndex == 1,
                activeColor: darkGreen,
                inactiveColor: unselectedColor,
              ),

              const SizedBox(
                width: 48,
              ), // เว้นพท. ไว้หลบ FloatingActionButton ตรงกลาง
              // ฝั่งขวา
              _buildNavItem(
                icon: Icons.emoji_events,
                label: 'เหรียญตรา',
                index: 3,
                isSelected: _currentIndex == 3,
                activeColor: darkGreen,
                inactiveColor: unselectedColor,
              ),
              _buildNavItem(
                icon: Icons.photo_library,
                label: 'แกลเลอรี่',
                index: 4,
                isSelected: _currentIndex == 4,
                activeColor: darkGreen,
                inactiveColor: unselectedColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget ช่วยสำหรับการสร้างปุ่มไอคอนและตัวอักษรแต่ละอันในแถบ Navigation
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
    required Color activeColor,
    required Color inactiveColor,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onTabTapped(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 28,
              color: isSelected ? activeColor : inactiveColor,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Georgia', // font เก่าจาก design ในภาพของ user
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
