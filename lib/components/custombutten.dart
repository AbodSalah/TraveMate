import 'package:flutter/material.dart';

// ignore: camel_case_types
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.width,
    required this.haigh,
    required this.color,
    required this.text,
    required this.press,
    this.rectangel,
    this.colorText,
    this.colorborder,
    this.sideIs,
    this.fontSize,
  });

  final Color color;
  final String text;
  final double width, haigh;
  final void Function()? press;
  final double? rectangel;
  final Color? colorText;
  final Color? colorborder;
  final BorderSide? sideIs;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(7),
      width: width,
      height: haigh,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: sideIs ?? BorderSide.none,
              borderRadius: BorderRadius.circular(rectangel ?? 12),
            ),
          ),
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Sofia",
              fontWeight: FontWeight.w500,
              fontSize: 19.5,
              letterSpacing: 1.2),
        ),
      ),
    );
  }
}
