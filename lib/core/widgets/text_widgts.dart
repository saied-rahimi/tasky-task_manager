import 'package:flutter/material.dart';

class MediumTitleText extends StatelessWidget {
  const MediumTitleText({
    required this.text,
    required this.align,
    this.style,
    this.textColor,
    super.key,
  });
  final String text;
  final TextAlign align;
  final TextStyle? style;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: style ??
           TextStyle(
            color: textColor,
            height: 1.7,
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
    );
  }
}class SmallTitleText extends StatelessWidget {
  const SmallTitleText({
    required this.text,
    required this.align,
    this.style,
    this.textColor,
    super.key,
  });
  final String text;
  final TextAlign align;
  final TextStyle? style;
  final Color? textColor;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style: style ??
           TextStyle(
            color: textColor,
            height: 1.7,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
    );
  }
}
