import 'package:ahana/authentication/login.dart';
import 'package:ahana/authentication/register.dart';
import 'package:ahana/onboarding/onboarding1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Track which page to show: Login or Register
  bool showLoginPage = true;

  // Toggle between Login and Register Pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            return Onboarding1();
          }

          // User not logged in
          else {
            return showLoginPage
                ? LoginPage(onTap: togglePages) // Pass the toggle function to LoginPage
                : RegisterPage(onTap: togglePages); // Pass the toggle function to RegisterPage
          }
        },
      ),
    );
  }
}
