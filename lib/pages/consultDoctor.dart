import 'package:flutter/material.dart';

class ConsultDoctor extends StatelessWidget {
  const ConsultDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Doctor",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Ragi Laddu",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),Text(
                "Doctor",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ]
        )
      ],
    );
  }
}
