import 'package:flutter/material.dart';

class MediumTitleText extends StatelessWidget {
  const MediumTitleText({
    required this.text,
    this.align = TextAlign.start,
    this.style,
    this.textColor,
    this.maxLine = 1,
    super.key,
  });
  final String text;
  final TextAlign? align;
  final TextStyle? style;
  final Color? textColor;
  final int? maxLine;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLine,
      style: style ??
          TextStyle(
            color: textColor,
            height: 1.7,
            fontWeight: FontWeight.w900,
            fontSize: 24,
          ),
    );
  }
}

class SmallTitleText extends StatelessWidget {
  const SmallTitleText({
    required this.text,
    this.align = TextAlign.start,
    this.style,
    this.textColor,
    this.maxLine = 1,
    super.key,
  });
  final String text;
  final TextAlign? align;
  final TextStyle? style;
  final Color? textColor;
  final int? maxLine;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLine,
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

class ParagraphText extends StatelessWidget {
  const ParagraphText(
    this.text, {
    super.key,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: const TextStyle(height: 1.7, fontSize: 16, color: Colors.grey),
    );
  }
}
