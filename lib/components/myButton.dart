import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText; // Add button text as a parameter

  const MyButton({
    super.key,
    required this.onTap,
    required this.buttonText, // Mark buttonText as required
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: const Color(0xFF630A00),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            buttonText, // Use the buttonText parameter
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
