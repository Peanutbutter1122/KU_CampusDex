import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

class TopStatusBar extends StatelessWidget {
  const TopStatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    const double barHeight = 90.0;

    // 💡 ตัวแปรจำลองความคืบหน้า (0.0 ถึง 1.0)
    const double unlockProgress = 0.25; // แถบขาววงกลมเริ่มจากซ้ายกลาง
    const double expProgress = 0.65; // หลอด EXP สีเขียว 65%

    return Container(
      width: double.infinity,
      height: barHeight,
      margin: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ===========================================================
          // LAYER 1: Background Painter (วงกลมทับสี่เหลี่ยม)
          // ===========================================================
          Positioned.fill(
            child: CustomPaint(
              painter: TopBarBackgroundPainter(progress: unlockProgress),
            ),
          ),

          // ===========================================================
          // LAYER 2: Level Text (LV.12 LOC)
          // ===========================================================
          Positioned(
            left: 0,
            top: 0,
            width: barHeight,
            height: barHeight,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Text(
                        'LV.12',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                          height: 1.0,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 4.0
                            ..color = const Color(0xFF3B2213),
                        ),
                      ),
                      const Text(
                        'LV.12',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                          height: 1.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 1),
                  Stack(
                    children: [
                      Text(
                        'LOC',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          height: 1.0,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3.0
                            ..color = const Color(0xFF3B2213),
                        ),
                      ),
                      const Text(
                        'LOC',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          height: 1.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ===========================================================
          // LAYER 3: User Info (Avatar + Name + EXP Bar)
          // ===========================================================
          Positioned(
            left: barHeight + 5,
            right: 20,
            top: 0,
            bottom: 0,
            child: Row(
              children: [
                // --- Avatar ---
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                      height: 70,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/character.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 12),

                // --- ชื่อและหลอด EXP ---
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kasetsart GUY',
                        style: GoogleFonts.mali(
                          // ใช้ GoogleFonts.mali แทน TextStyle เดิม
                          color: const Color(0xFF4A2B23),
                          fontSize: 18,
                          fontWeight:
                              FontWeight.bold, // ปรับความหนาได้ตามต้องการ
                          letterSpacing: 0.5,
                          height: 1.0, // ช่วยตัดพื้นที่ว่างด้านล่างของฟอนต์ทิ้ง
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // 🌟 หลอด EXP แบบใหม่
                      Container(
                        // ✅ สั่งให้หลอดยืดสุดพื้นที่ทางขวา เพื่อให้เห็นพื้นหลังสีครีมชัดเจน!
                        width: double.infinity,
                        height: 16,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFFDF8ED,
                          ), // สีครีมพื้นหลังหลอด (บอกหลอดเต็ม)
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF3B2213), // เส้นขอบหลอด
                            width: 2.5,
                          ),
                        ),
                        // กลไกเติมหลอดสีเขียว
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.5),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor:
                                expProgress, // 👈 ใช้ตัวแปร expProgress
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF358C46), // สีเขียว
                                border: Border(
                                  // เส้นขอบสีน้ำตาลปิดท้ายหลอดสีเขียวแบบในต้นฉบับ
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
      ),
    );
  }
}

// ==============================================================================
// PAINTER: วาดแบบ Layer ทับกัน (วงกลมอยู่บนสุด)
// ==============================================================================
class TopBarBackgroundPainter extends CustomPainter {
  final double progress;

  TopBarBackgroundPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final double h = size.height;
    final double w = size.width;

    final outlineColor = const Color(0xFF3B2213); // สีขอบและเงา
    final creamColor = const Color(0xFFFDF8ED); // สีครีมแคปซูล
    final greenColor = const Color(0xFF358C46); // สีเขียววงกลม

    const double thickStroke = 6.0;

    final double circleCenterX = h / 2;
    final double circleCenterY = h / 2;
    final double rOuterCircle = (h / 2) - (thickStroke / 2);

    final double pillHeight = 60.0;
    final double pillTop = (h - pillHeight) / 2;
    final double pillBottom = pillTop + pillHeight;

    // --- 1. สร้าง Path ---
    Path outerCircle = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(circleCenterX, circleCenterY),
          radius: rOuterCircle,
        ),
      );

    Path outerPill = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTRB(
            circleCenterX,
            pillTop,
            w - (thickStroke / 2),
            pillBottom,
          ),
          Radius.circular(pillHeight / 2),
        ),
      );

    Path shadowPath = Path.combine(PathOperation.union, outerCircle, outerPill);

    // --- 2. วาดเงา 3D ด้านล่างสุด ---
    canvas.save();
    canvas.translate(0, 5.0);
    canvas.drawPath(
      shadowPath,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.fill,
    );
    canvas.restore();

    // --- 3. วาดเลเยอร์สี่เหลี่ยมสีครีม (อยู่ชั้นล่าง) ---
    canvas.drawPath(
      outerPill,
      Paint()
        ..color = creamColor
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      outerPill,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickStroke
        ..strokeJoin = StrokeJoin.round,
    );

    // --- 4. วาดเลเยอร์วงกลมสีเขียว (วาดทับชั้นบนสุด) ---
    canvas.drawPath(
      outerCircle,
      Paint()
        ..color = greenColor
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      outerCircle,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickStroke,
    );

    // --- 5. 🌟 วาดมาตรวัดแถบสีขาว ---
    const double trackWidth = 10.0;
    final double trackCenterRadius = rOuterCircle - (trackWidth / 2) - 1.0;

    double deg2Rad(double deg) => deg * math.pi / 180.0;

    // ✅ องศาเป็นบวกเพื่อกวาดตามเข็มนาฬิกา
    final double sweepAngle = 360.0 * progress;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(circleCenterX, circleCenterY),
        radius: trackCenterRadius,
      ),
      deg2Rad(180), // ✅ เริ่ม 180 องศา (ตำแหน่ง 9 นาฬิกา / ซ้ายกลาง)
      deg2Rad(sweepAngle),
      false,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = trackWidth
        ..strokeCap = StrokeCap.butt,
    );

    // --- 6. วาดเส้นขอบวงกลมสีน้ำตาลด้านใน ---
    const double innerStrokeWidth = 3.5;
    final double innerBorderRadius = trackCenterRadius - (trackWidth / 2);

    canvas.drawCircle(
      Offset(circleCenterX, circleCenterY),
      innerBorderRadius,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = innerStrokeWidth,
    );
  }

  @override
  bool shouldRepaint(covariant TopBarBackgroundPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
