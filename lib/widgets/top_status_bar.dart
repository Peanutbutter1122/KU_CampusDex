import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopStatusBar extends StatelessWidget {
  const TopStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    const double expProgress = 0.65; // หลอด EXP สีเขียว/เหลือง 65%

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title: KU CAMPUS DEX
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ไอคอนหมวกปริญญา
            const Text('🎓', style: TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Stack(
              children: [
                Text(
                  'KU CAMPUS DEX',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 4.0
                      ..color = Colors.black, // ขอบดำหนา
                  ),
                ),
                const Text(
                  'KU CAMPUS DEX',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                    color: Colors.white, // ตัวอักษรสีขาว
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(0, 3),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),

        // The White Card (Player Info)
        Container(
          height: 85,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFFDF8ED), // สีพื้นหลังตามภาพคือขาวครีม
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF3B2213), // ขอบสีน้ำตาลเข้ม
              width: 3.5,
            ),
          ),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 55,
                height: 55,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/character.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 20),

              // Name / Level and EXP
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text: LV. 12 Location
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'LV .12',
                          style: GoogleFonts.mali(
                            color: const Color(0xFF3B2213),
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Location',
                          style: GoogleFonts.mali(
                            color: const Color(0xFF3B2213),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // EXP Bar
                    Container(
                      height: 18,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF8ED),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF3B2213),
                          width: 2.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: expProgress,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(
                                0xFFDCA930,
                              ), // สีตามในภาพเป๊ะๆ (ทองตุ่นๆ)
                              border: Border(
                                right: BorderSide(
                                  color: Color(0xFF3B2213),
                                  width: 2.5,
                                ),
                              ),
                            ),
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
      ],
    );
  }
}
