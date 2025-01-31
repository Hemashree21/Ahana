import 'package:ahana/authentication/auth_page.dart';
import 'package:ahana/components/basePage.dart';
import 'package:ahana/pages/articles.dart';
import 'package:ahana/pages/cart.dart';
import 'package:ahana/pages/cartService.dart';
import 'package:ahana/pages/checkout.dart';
import 'package:ahana/pages/community.dart';
import 'package:ahana/pages/consultDoctor.dart';
import 'package:ahana/pages/home.dart';
import 'package:ahana/pages/trackPeriod.dart';
import 'package:ahana/pages/viewAppointment.dart';
import 'package:ahana/pages/viewProducts.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ahana/pages/viewAppointment.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(AppointmentAdapter());
  }

  await Hive.openBox<Appointment>('appointments');

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await CartService.init();

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
      initialRoute: '/', // Set the initial route here
      routes: {
        '/': (context) => HomePage(), // Home page as the initial route
        '/auth': (context) => AuthPage(), // Authentication page route
        '/articles': (context) => BasePage(
            activeSection: 'articles',
            body: ArticlePage(),
        ), // Articles page route
        '/shopping': (context) => BasePage(
          activeSection: 'shopping',
          body: ProductListPage(),
        ), // View All Products Page
        '/consultation': (context) => BasePage(
            activeSection: 'consultation',
            body: AppointmentPage()
        ),
        '/cart': (context) => BasePage(
            activeSection: 'shopping',
            body: CartPage(),
        ),
        '/community': (context) => BasePage(
            activeSection: 'community',
            body: CommunityPage(),
        ),
        '/periodtracker': (context) => BasePage(
            activeSection: 'period_tracker',
            body: PeriodTrackerPage(),
        ),
        '/checkout': (context) => BasePage(
            activeSection: 'shopping',
            body: CheckoutPage(),
        ),
        '/viewappointment': (context) => BasePage(
            activeSection: 'consultation',
            body: ViewAppointment(),
        )
      },
    );
  }
}