import 'package:ahana/onboarding/onboarding5.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  Widget _buildRectangle(Color color) {
    return Container(
      width: 99.33,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  Widget buildProgressBar(int filled, Color filledColor, Color emptyColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: _buildRectangle(index < filled ? filledColor : emptyColor),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SubscriptionPage()),
        );
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFAAAAAA).withOpacity(0.6),
                    const Color(0xFFAAAAAA).withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildProgressBar(
                      3, const Color(0xFF640000), const Color(0xFFD9D9D9)),
                  const SizedBox(height: 20),
                  const Icon(Icons.check_circle,
                      size: 100, color: Color(0xFF640000)),
                  const SizedBox(height: 20),
                  const Text(
                    "Success!",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF640000)),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                      "Your medical details have been saved successfully."),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
