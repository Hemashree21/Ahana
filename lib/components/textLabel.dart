import 'package:flutter/material.dart';

class TextFieldLabel extends StatelessWidget {
  final String label;

  const TextFieldLabel({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: label.contains("(if any)") ? Colors.grey : Colors.black,
      ),
    );
  }
}