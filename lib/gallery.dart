import 'package:final_project/widgets/boxframe.dart';
import 'package:flutter/material.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int _selectedIndex = 0;

  final photos = [
      {
        'title': 'อนุสาวรีย์สามบูรพาจารย์',
        'image': 'assets/images/kulocationimage/monument.jpg',
        'unlocked': true,
      },
      {
        'title': 'อนุสาวรีย์สามบูรพาจารย์',
        'image': 'assets/images/kulocationimage/monument.jpg',
        'unlocked': false,
      },
    ];

  @override
  Widget build(BuildContext context) {
    

    return _buildGalleryContent();
  }

   Widget _buildGalleryContent() {
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
            "บันทึกความทรงจำ",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: photos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final photo = photos[index];
                final bool isUnlocked = photo['unlocked'] as bool;

                return Boxframe(
                  label: photo['title'] as String,
                  showCheck: isUnlocked, // ปลดล็อกค่อยโชว์เช็คถูก
                  inner: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ColorFiltered(
                      colorFilter: isUnlocked
                          ? const ColorFilter.mode(Colors.transparent, BlendMode.dst)
                          : const ColorFilter.matrix(<double>[
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0.2126, 0.7152, 0.0722, 0, 0,
                              0,      0,      0,      1, 0,
                            ]),
                      child: Image.asset(
                        photo['image'] as String,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                );
              },

            ),),
          ],
        ),
      ],
    );
  }
  
  
}