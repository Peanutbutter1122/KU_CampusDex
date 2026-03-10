import 'package:flutter/material.dart';
import 'dart:math' as math;

class BottomNavBar extends StatelessWidget {
  final double speed;
  final String destinationName;
  final int distanceMeters;
  final bool isNearDestination;
  final VoidCallback onButtonPressed;

  const BottomNavBar({
    super.key,
    required this.speed,
    required this.destinationName,
    required this.distanceMeters,
    required this.isNearDestination,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    // ===========================================================
    // 🛠️ SETTINGS: ตั้งค่าขนาดหลัก
    // ===========================================================
    const double backgroundHeight = 140.0; // ความสูงรวมของวงกลม
    const double pillHeight = 100.0; // ความสูงของแท่งสี่เหลี่ยม

    // --- คำนวณตำแหน่งอัตโนมัติ ---
    const double thickStroke = 6.0;
    const double circleCenterY = backgroundHeight / 2;
    const double rOuterCircle = circleCenterY - (thickStroke / 2);
    // ขอบล่างของ pill เสมอกับขอบล่างวงกลม
    const double pillBottom = circleCenterY + rOuterCircle;
    const double pillTop = pillBottom - pillHeight;
    // ระยะ margin จากขอบล่างสุดของ container ขึ้นมาถึงตัว pill
    const double pillBottomMargin = backgroundHeight - pillBottom;

    return Container(
      width: double.infinity,
      height: backgroundHeight,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ===========================================================
          // LAYER 1: Background Shape & Gauge Painter
          // ===========================================================
          Positioned.fill(
            child: CustomPaint(painter: BottomBarBackgroundPainter()),
          ),

          // ===========================================================
          // LAYER 2: Gauge Text (ตัวเลขความเร็วตรงกลาง)
          // ===========================================================
          Positioned(
            left: 0,
            top: 0,
            width: backgroundHeight,
            height: backgroundHeight,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    speed.toStringAsFixed(1),
                    style: const TextStyle(
                      fontFamily: 'Georgia',
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 38,
                      height: 0.9,
                    ),
                  ),
                  Text(
                    'km/h',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ===========================================================
          // LAYER 3: Destination Info (แก้ไข: ขยับไปทางขวา)
          // ===========================================================
          Positioned(
            // ✅ แก้ไขจุดที่ 1: เพิ่มค่า left เพื่อผลักข้อความไปทางขวาให้ห่างจากวงกลม
            left: backgroundHeight,
            right: 80, // ปรับ right นิดหน่อยให้สมดุล
            top: pillTop,
            bottom: pillBottomMargin,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NEXT DESTINATION:',
                  style: TextStyle(
                    fontFamily: 'Georgia',
                    color: Color(0xFF6B3A2C),
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  destinationName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                Text(
                  '(${distanceMeters}m)',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),

          // ===========================================================
          // LAYER 4: Compass Button (ปุ่มเข็มทิศ)
          // ===========================================================
          Positioned(
            right: 18,
            top: pillTop,
            bottom: pillBottomMargin,
            child: Center(
              child: GestureDetector(
                onTap: onButtonPressed,
                child: Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: isNearDestination
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFF6B838C),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF3B2213),
                      width: 3.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 3),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  child: Center(
                    child: isNearDestination
                        ? const Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                            size: 34,
                          )
                        : Transform.rotate(
                            angle: math.pi / 4,
                            child: const Icon(
                              Icons.navigation,
                              color: Colors.black,
                              size: 34,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==============================================================================
// PAINTER: วาดฉากหลังและเกจ์ความเร็ว (แก้ไข: ลดขนาดเกจ์ลง)
// ==============================================================================
class BottomBarBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double h = size.height; // 140
    final double w = size.width;

    final outlineColor = const Color(0xFF3B2213);
    final creamColor = const Color(0xFFF5F0E1);

    final darkTrackColor = const Color(0xFF4F3B31);
    final greenTrackColor = const Color(0xFF56812D);
    final lightTrackColor = const Color(0xFF93685E);

    const double thickStroke = 6.0;
    const double thinStroke = 2.0;

    // ✅ แก้ไขจุดที่ 2: ปรับขนาดเกจ์ให้เล็กลงและบางลง
    const double gap =
        15.0; // เพิ่ม gap เพื่อบีบเกจ์เข้าไปข้างในมากขึ้น (เดิม 6.0)
    const double trackWidth = 12.0; // ลดความหนาของแถบสีลง (เดิม 18.0)

    final double circleCenterX = h / 2;
    final double circleCenterY = h / 2;

    // ----------------------------------------------------------------------
    // 1. OUTER SHAPE: สี่เหลี่ยมขอบล่างตรงเป๊ะ
    // ----------------------------------------------------------------------
    final double rOuterCircle = (h / 2) - (thickStroke / 2);

    // ขอบล่างต้องเสมอวงกลมเป๊ะๆ
    final double pillOuterBottom = circleCenterY + rOuterCircle;

    // ** ต้องตรงกับ pillHeight ด้านบนของคลาส BottomNavBar **
    final double pillOuterHeight = 100.0;
    final double pillOuterTop = pillOuterBottom - pillOuterHeight;

    Path outerCircle = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(circleCenterX, circleCenterY),
          radius: rOuterCircle,
        ),
      );

    final Radius rightRadius = Radius.circular(pillOuterHeight / 2);
    Path outerPill = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTRB(
            circleCenterX,
            pillOuterTop,
            w - (thickStroke / 2),
            pillOuterBottom,
          ),
          topLeft: Radius.zero,
          bottomLeft: Radius.zero,
          topRight: rightRadius,
          bottomRight: rightRadius,
        ),
      );

    Path outerPath = Path.combine(PathOperation.union, outerCircle, outerPill);

    canvas.drawShadow(outerPath, Colors.black45, 6.0, true);
    canvas.drawPath(
      outerPath,
      Paint()
        ..color = creamColor
        ..style = PaintingStyle.fill,
    );
    canvas.drawPath(
      outerPath,
      Paint()
        ..color = outlineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = thickStroke
        ..strokeJoin = StrokeJoin.round,
    );

    // ----------------------------------------------------------------------
    // 2. INNER GAUGE BORDERS (คำนวณใหม่ตาม gap ที่เพิ่มขึ้น)
    // ----------------------------------------------------------------------
    final double rThinOuter = rOuterCircle - gap - (thinStroke / 2);
    final double rThinInner = rThinOuter - trackWidth;

    Paint thinBorderPaint = Paint()
      ..color = outlineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = thinStroke;

    double deg2Rad(double deg) => deg * math.pi / 180.0;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(circleCenterX, circleCenterY),
        radius: rThinOuter,
      ),
      deg2Rad(135),
      deg2Rad(270),
      false,
      thinBorderPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(circleCenterX, circleCenterY),
        radius: rThinInner,
      ),
      deg2Rad(135),
      deg2Rad(270),
      false,
      thinBorderPaint,
    );

    canvas.drawLine(
      Offset(
        circleCenterX + rThinInner * math.cos(deg2Rad(135)),
        circleCenterY + rThinInner * math.sin(deg2Rad(135)),
      ),
      Offset(
        circleCenterX + rThinOuter * math.cos(deg2Rad(135)),
        circleCenterY + rThinOuter * math.sin(deg2Rad(135)),
      ),
      thinBorderPaint,
    );
    canvas.drawLine(
      Offset(
        circleCenterX + rThinInner * math.cos(deg2Rad(45)),
        circleCenterY + rThinInner * math.sin(deg2Rad(45)),
      ),
      Offset(
        circleCenterX + rThinOuter * math.cos(deg2Rad(45)),
        circleCenterY + rThinOuter * math.sin(deg2Rad(45)),
      ),
      thinBorderPaint,
    );

    // ----------------------------------------------------------------------
    // 3. GAUGE ARCS (คำนวณใหม่ตาม trackWidth ที่ลดลง)
    // ----------------------------------------------------------------------
    final double trackCenterRadius = (rThinOuter + rThinInner) / 2;
    final Rect trackRect = Rect.fromCircle(
      center: Offset(circleCenterX, circleCenterY),
      radius: trackCenterRadius,
    );
    final double actualTrackWidth = rThinOuter - rThinInner;

    Paint mkTrackPaint(Color c) => Paint()
      ..color = c
      ..style = PaintingStyle.stroke
      ..strokeWidth = actualTrackWidth;

    canvas.drawArc(
      trackRect,
      deg2Rad(135),
      deg2Rad(45),
      false,
      mkTrackPaint(greenTrackColor),
    );
    canvas.drawArc(
      trackRect,
      deg2Rad(180),
      deg2Rad(180),
      false,
      mkTrackPaint(darkTrackColor),
    );
    canvas.drawArc(
      trackRect,
      deg2Rad(0),
      deg2Rad(45),
      false,
      mkTrackPaint(lightTrackColor),
    );

    Paint dividerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;
    canvas.drawLine(
      Offset(
        circleCenterX + rThinInner * math.cos(deg2Rad(180)),
        circleCenterY + rThinInner * math.sin(deg2Rad(180)),
      ),
      Offset(
        circleCenterX + rThinOuter * math.cos(deg2Rad(180)),
        circleCenterY + rThinOuter * math.sin(deg2Rad(180)),
      ),
      dividerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
