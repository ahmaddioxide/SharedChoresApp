import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String buttonText;
  final double width;
  const BlueButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
      child: RawMaterialButton(
        elevation: 7,
        fillColor: Theme.of(context).primaryColor,
        // splashColor: Theme.of(context).primaryColor,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
