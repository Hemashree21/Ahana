import 'package:ahana/authentication/auth_page.dart';
import 'package:ahana/pages/articles.dart';
import 'package:ahana/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFE7CA), // Global background color
      ),
      initialRoute: '/auth', // Set the initial route here
      routes: {
        '/': (context) => HomePage(), // Home page as the initial route
        '/auth': (context) => AuthPage(), // Authentication page route
        '/articles': (context) => ArticlePage(), // Articles page route
        // Add other routes here as needed
      },
    );
  }
}
