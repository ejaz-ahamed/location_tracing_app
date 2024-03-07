import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Color buttonColor;
  final String buttonName;
  final VoidCallback onPressed;
  const ButtonWidget(
      {super.key,
      required this.buttonName,
      required this.onPressed,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: buttonColor,
            foregroundColor: Colors.white),
        onPressed: onPressed,
        child: Text(buttonName),
      ),
    );
  }
}
