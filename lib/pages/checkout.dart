
import 'package:ahana/components/basePage.dart';
import 'package:ahana/pages/orderConfirmation.dart';
import 'package:ahana/services/stripeService.dart';
import 'package:flutter/material.dart';
import 'package:ahana/components/myButton.dart';
import 'package:ahana/pages/cartService.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartService _cartService = CartService();
  bool _isLoading = true;
  String _selectedPaymentMethod = 'visa'; // Default selection

  @override
  void initState() {
    super.initState();
    _loadCart();
  }

  Future<void> _loadCart() async {
    await _cartService.loadCart();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Checkout',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Color(0xFF640000),
              ),
            ),
            const SizedBox(height: 30),
            _buildOrderSummary(),
            const SizedBox(height: 30),
            _buildPaymentSection(),
            const SizedBox(height: 30),
            MyButton(
              onTap: () async {
                try {
                  setState(() => _isLoading = true);
                  int amountInPaise = (_cartService.total * 100).round();
                  await StripeService.instance.makePayment(
                    amount: amountInPaise,
                  );

                  // Clear the cart after successful payment
                  _cartService.clearCart();

                  // Navigate to Order Confirmation Page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BasePage(
                        activeSection: 'shopping',
                        body: OrderConfirmationPage())),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Payment failed: ${e.toString()}')),
                  );
                } finally {
                  setState(() => _isLoading = false);
                }
              },
              buttonText: _isLoading ? 'Processing...' : 'Continue',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSummaryRow('Order', '₹ ${_cartService.total}'),
        const SizedBox(height: 12),
        _buildSummaryRow('Shipping', 'Free'),
        const SizedBox(height: 12),
        Divider(color: Color(0xFF630A00)),
        const SizedBox(height: 12),
        _buildSummaryRow('Total', '₹ ${_cartService.total}', isTotal: true),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Options',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF640000),
          ),
        ),
        const SizedBox(height: 16),
        _buildPaymentOption(
          'visa',
          'lib/assets/visa.png',
          '**** **** **** 2109',
          'Credit/Debit Card',
        ),
        const SizedBox(height: 12),
        _buildPaymentOption(
          'paypal',
          'lib/assets/paypal.png',
          '**** **** **** 2109',
          'PayPal',
        ),
        const SizedBox(height: 12),
        _buildPaymentOption(
          'apple_pay',
          'lib/assets/apple_pay.png',
          '**** **** **** 2109',
          'Apple Pay',
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
      String method,
      String imagePath,
      String maskedNumber,
      String label,
      ) {
    bool isSelected = _selectedPaymentMethod == method;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xFF640000) : Color(0xFF640000),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.transparent : Colors.transparent,
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              height: 40,
              width: 40,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    maskedNumber,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Color(0xFF640000),
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
