import 'package:flutter/material.dart';

class OrderConfirmationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const Text(
          'Order Confirmation',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xFF640000),
          ),
          ),
            Image.asset('lib/assets/confirm.png', height: 200),
            const SizedBox(height: 20),
            const Text(
              'Order Successfully Placed!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/'); // Navigate back to the main page
              },
              child: const Text('Back to Home'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF640000),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
