import 'package:flutter/material.dart';

String truncateText(String text, double maxWidth, Size screenSize) {
  final maxLength = (screenSize.width * maxWidth).toInt();
  if (text.length > maxLength) {
    return '${text.substring(0, maxLength - 4)}...';
  } else {
    return text;
  }
}
