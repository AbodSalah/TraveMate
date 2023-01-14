import 'package:flutter/material.dart';

class CustomTextfeild extends StatelessWidget {
  final String titel;
  final bool? obsecuer;
  final IconData? icon;
  final void Function()? iconontap;
  final String? Function(String?)? onsaved;
  final String? Function(String?)? valid;
  final double? width, height;
  final TextDirection? textDirection;
  final String? inialvalue;
  final BorderStyle? isBoarder;
  final int? maxLines;
  final Color? fillColor;
  final bool? isenabledBorder;
  final bool readOnly;

  final void Function()? onTap;
  const CustomTextfeild({
    super.key,
    this.iconontap,
    this.obsecuer,
    this.icon,
    required this.valid,
    required this.onsaved,
    required this.titel,
    this.width,
    this.height,
    this.textDirection,
    this.inialvalue,
    this.isBoarder,
    this.maxLines,
    this.fillColor,
    this.isenabledBorder = true,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: width,
      height: height,
      child: TextFormField(
        onTap: onTap,
        readOnly: readOnly,
        initialValue: inialvalue,
        textDirection: textDirection,
        obscureText: obsecuer == null ? false : obsecuer!,
        onSaved: onsaved,
        validator: valid,
        decoration: InputDecoration(hintText: titel, prefixIcon: Icon(icon)),
      ),
    );
  }
}
