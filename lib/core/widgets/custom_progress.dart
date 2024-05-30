import 'package:flutter/material.dart';

class CustomProgress extends StatelessWidget {
  const CustomProgress({this.color, super.key});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? Colors.white,
      ),
    );
  }
}
