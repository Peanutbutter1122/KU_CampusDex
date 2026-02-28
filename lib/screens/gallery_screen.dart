import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color brownColor = Color(0xFF3B2213);
    const Color creamBg = Color(0xFFFDF8ED);

    // Dummy gallery items
    final List<Map<String, String>> photos = [
      {
        'url':
            'https://images.unsplash.com/photo-1541339907198-e08756dedf3f?auto=format&fit=crop&w=500&q=60',
        'title': 'อาคารระพีสาคริก',
      },
      {
        'url':
            'https://images.unsplash.com/photo-1498654896293-37aacf113fd9?auto=format&fit=crop&w=500&q=60',
        'title': 'ห้องสมุด',
      },
      {
        'url':
            'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?auto=format&fit=crop&w=500&q=60',
        'title': 'อาคาร 50 ปี',
      },
      {
        'url':
            'https://images.unsplash.com/photo-1568228189815-1a2f641a029c?auto=format&fit=crop&w=500&q=60',
        'title': 'สระว่ายน้ำ',
      },
      {
        'url':
            'https://images.unsplash.com/photo-1555181126-cf46a03827c0?auto=format&fit=crop&w=500&q=60',
        'title': 'โรงอาหาร',
      },
      {
        'url':
            'https://images.unsplash.com/photo-1620216669930-babbf7b0282b?auto=format&fit=crop&w=500&q=60',
        'title': 'Kasetsart Stadium',
      },
    ];

    return Scaffold(
      backgroundColor: creamBg,
      appBar: AppBar(
        title: const Text(
          'Gallery (แกลเลอรีความทรงจำ)',
          style: TextStyle(fontWeight: FontWeight.bold, color: brownColor),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: MasonryGridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          itemCount: photos.length,
          itemBuilder: (context, index) {
            final photo = photos[index];
            // กำหนดสัดส่วนรูปภาพสลับกันเพื่อให้เกิด UI แบบ Staggered Grid (Masonry)
            final double ratio = index.isEven ? 0.8 : 1.2;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => Dialog(
                    backgroundColor: Colors.transparent,
                    insetPadding: const EdgeInsets.all(16),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // กำหนดขนาดให้ชัดเจนป้องกันไม่ให้ Dialog ระเบิดเวลาโหลดรูป
                        AspectRatio(
                          aspectRatio: ratio,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: InteractiveViewer(
                              panEnabled: true,
                              minScale: 1.0,
                              maxScale: 4.0,
                              child: Image.network(
                                photo['url']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: -10,
                          right: -10,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              decoration: BoxDecoration(
                                color: brownColor, // สีน้ำตาลจากตีมของแอป
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: AspectRatio(
                  aspectRatio: ratio,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.network(
                        photo['url']!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.8),
                              Colors.transparent,
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Text(
                          photo['title']!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
