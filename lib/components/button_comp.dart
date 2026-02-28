import 'package:flutter/material.dart';

class ButtonComp extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const ButtonComp({
    super.key, 
    required this.onTap,
    required this.text,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: Material(
      color: Colors.green[400],
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.antiAlias, //ไม่ให้effect ล้นขอบปุ่ม
        child: InkWell(
          onTap: onTap,
          splashColor: Colors.green[600],
          child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),),
              ),
            ),
          ),
      ),
        
      
    );
  }
}