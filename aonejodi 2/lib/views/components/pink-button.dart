import 'package:app/Theme/theme-colors.dart';
import 'package:flutter/material.dart';

class PinkButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const PinkButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: pinkColor,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
