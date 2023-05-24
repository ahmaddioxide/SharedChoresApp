import 'package:flutter/material.dart';
import 'package:choresmate/ui-components/theme.dart';


class GreyText extends StatelessWidget {
  final String text;
  const GreyText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: CustomColorSwatch.pimaryAccent,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
