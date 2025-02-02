import 'package:flutter_dotenv/flutter_dotenv.dart';

String get stripePublishableKey => dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
String get stripeSecretKey => dotenv.env['STRIPE_SECRET_KEY']!;

