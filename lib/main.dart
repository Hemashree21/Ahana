import 'package:ahana/authentication/auth_page.dart';
import 'package:ahana/pages/articles.dart';
import 'package:ahana/pages/home.dart';
import 'package:ahana/pages/productDetails.dart';
import 'package:ahana/pages/viewProducts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv
import 'package:go_router/go_router.dart'; // Import GoRouter

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the .env file
  await dotenv.load(fileName: ".env");

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp()); // Removed const here
}

class MyApp extends StatelessWidget {
  // Removed const here
  final GoRouter _router = GoRouter(
    initialLocation: '/home', // Set the initial route here
    routes: [
      // Define your routes here
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(), // Home page route
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => AuthPage(), // Authentication page route
      ),
      GoRoute(
        path: '/shopping',
        builder: (context, state) => ProductListPage(), // View Products List Page
      ),
      GoRoute(
        path: '/productdetails',
        builder: (context, state) => ProductPage(),
      ),
      GoRoute(
        path: '/articles',
        builder: (context, state) => ArticlePage(), // Articles page route
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEFE7CA), // Global background color
      ),
      routerConfig: _router, // Use GoRouter configuration
    );
  }
}
