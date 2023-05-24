import 'package:flutter/material.dart';
import 'package:choresmate/ui-components/theme.dart';


class BlackText extends StatelessWidget {
  final String text;
  final double? fontSize;
  const BlackText({
    super.key,
    required this.text,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:  TextStyle(
        color: CustomColorSwatch.subheadingColor,
        fontSize: fontSize?? 14.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
