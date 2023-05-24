import 'package:flutter/material.dart';
import 'package:choresmate/ui-components/theme.dart';

class BlueText extends StatelessWidget {
  final String text;
  final double fontSize;
  const BlueText({
    super.key,
    required this.text,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:  TextStyle(
        color: CustomColorSwatch.pimary,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
