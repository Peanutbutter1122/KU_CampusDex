import 'dart:ui';
import 'package:final_project/components/locationtile.dart';
import 'package:final_project/components/showimage_home.dart';
import 'package:flutter/material.dart';
import 'package:final_project/gallery.dart';
import 'package:final_project/badge.dart';
import 'package:final_project/widgets/top_status_bar.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  final ShowimageHome data = ShowimageHome();

  Widget _buildHomeContent() {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: const Color(0xFF358C46),
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 16,
                bottom: 20,
              ),
              child: const TopStatusBar(),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text('สถานที่แนะนำ', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                itemCount: data.showImageHome.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Locationtile(homeLocation: data.showImageHome[index]);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }


  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String appBarTitle = _selectedIndex == 2
        ? 'BADGE'
        : _selectedIndex == 0
        ? 'GALLERY'
        : 'KU CAMPUS DEX';
    final IconData? appBarIcon = _selectedIndex == 1 ? Icons.school : null;

    final List<Widget> _pages = [
      const GalleryPage(),   // index 0
      _buildHomeContent(),   // index 1 
      const BadgePage(),     // index 2
    ];
    return  Scaffold(

      extendBody: true,

      appBar: _selectedIndex == 1 ? null : AppBar(
        toolbarHeight: (100),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (appBarIcon != null) Icon(appBarIcon, size: 40, color: Colors.black),
          if (appBarIcon != null) const SizedBox(width: 10),

          Stack(
            children: [
          Text(
          appBarTitle, // กรอบดำ
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            fontFamily: 'serif',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4
              ..color = Colors.black,
          ),),
        Text(
      appBarTitle,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w900,
        fontFamily: 'serif',
        color: Colors.white,
      ),
                ),
              ],
            ),
          ],
        ),
      ),
      
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white.withOpacity(0.9),
        onTap: _navigateBottomBar,
        items: [
          
          BottomNavigationBarItem(icon: Icon(Icons.photo) ,label: 'Gallery'),
          BottomNavigationBarItem(icon: Icon(Icons.home) ,label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.badge_sharp) ,label: 'Badge'),
          //BottomNavigationBarItem(icon: Icon(Icons.camera_alt) ,label: 'Check In'),
          //BottomNavigationBarItem(icon: Icon(Icons.map_outlined) ,label: 'Map'),

      ],
      ),
    );
  }
}
