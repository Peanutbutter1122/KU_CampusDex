import 'package:flutter/material.dart';


class Boxframe extends StatelessWidget {
  final String label;
  final Widget inner;
  final bool showCheck;

  const Boxframe({
    super.key,
    required this.label,
    required this.inner,
    this.showCheck = false,
  });

  @override
  Widget build(BuildContext context) {
    const borderColor = Color(0xFF4A2E2A);
    const panelColor = Color(0xFFF7F6F2);
    const innerColor = Color(0xFFD2C8B9);

    return Container(
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: borderColor, width: 4),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: innerColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: inner,
                ),
                if (showCheck)
                  const Positioned(
                    right: 6,
                    bottom: 6,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFF17A34A),
                      child: Icon(Icons.check, color: Colors.white, size: 16),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label, 
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14, 
              fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
