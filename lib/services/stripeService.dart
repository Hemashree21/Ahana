import 'package:ahana/const.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  Future<void> makePayment({required int amount}) async {
    try {
      final paymentIntentData = await _createPaymentIntent(amount, "inr");
      if (paymentIntentData == null) return;

      print("Payment Intent Data: $paymentIntentData");

      // Handle 3D Secure if required
      if (paymentIntentData['status'] == 'requires_action') {
        final paymentIntent = await Stripe.instance.handleNextAction(
          paymentIntentData['client_secret'],
        );

        if (paymentIntent.status == 'succeeded') {
          print("Payment succeeded after 3D Secure authentication");
          return;
        } else {
          throw PaymentException("Payment failed after 3D Secure authentication");
        }
      }

      // Proceed with the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          merchantDisplayName: "Ahana",
          style: ThemeMode.system,
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              background: Colors.white,
              primary: Color(0xFF640000),
              componentBackground: Colors.white,
            ),
          ),
          billingDetails: const BillingDetails(),
        ),
      );
      print("Payment Sheet Initialized Successfully");

      await _processPayment();
    } catch (e) {
      print("Error in makePayment: $e");
      throw PaymentException(_getErrorMessage(e));
    }
  }

  Future<Map<String, dynamic>?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();

      // Simplified body with only required parameters
      final Map<String, dynamic> body = {
        'amount': amount.toString(),
        'currency': currency,
        'description': 'Payment for Ahana services',
        'automatic_payment_methods[enabled]': 'true',  // Changed format for Stripe API
      };

      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        options: Options(
          headers: {
            'Authorization': 'Bearer $stripeSecretKey',
            'Stripe-Version': '2023-10-16',
          },
          contentType: Headers.formUrlEncodedContentType,
          validateStatus: (status) => status! < 500,  // Accept 400 responses to read error message
        ),
        data: body,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print("Stripe Error Response: ${response.data}");
        throw Exception(response.data['error']?['message'] ?? "Failed to create payment intent");
      }
    } catch (e) {
      print("Error in _createPaymentIntent: $e");
      rethrow;
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Payment successful");
    } on StripeException catch (e) {
      print("Stripe error: ${e.error.localizedMessage}");
      throw PaymentException(_getErrorMessage(e));
    } catch (e) {
      print("Generic error: $e");
      throw PaymentException("Payment failed. Please try again.");
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is StripeException) {
      switch (error.error.code) {
        case FailureCode.Canceled:
          return "Payment cancelled";
        case FailureCode.Failed:
          return "Payment failed. Please try again.";
        default:
          return error.error.localizedMessage ?? "Payment failed";
      }
    }
    return "Payment failed. Please try again.";
  }
}

class PaymentException implements Exception {
  final String message;
  PaymentException(this.message);

  @override
  String toString() => message;
}