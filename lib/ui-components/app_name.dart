import 'package:flutter/material.dart';
import 'package:choresmate/ui-components/theme.dart';


class AppNameText extends StatelessWidget {
  const AppNameText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "CHORES-MATE",
      style: TextStyle(
        color: CustomColorSwatch.pimary,
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
