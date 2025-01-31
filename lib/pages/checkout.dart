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
              onTap: () {
                // Handle continue button tap
              },
              buttonText: 'Continue',
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
        _buildPaymentOption('lib/assets/visa.png', '**** **** **** 2109'),
        const SizedBox(height: 12),
        _buildPaymentOption('lib/assets/paypal.png', '**** **** **** 2109'),
        const SizedBox(height: 12),
        _buildPaymentOption('lib/assets/maestro.png', '**** **** **** 2109'),
        const SizedBox(height: 12),
        _buildPaymentOption('lib/assets/apple_pay.png', '**** **** **** 2109'),
      ],
    );
  }

  Widget _buildPaymentOption(String imagePath, String maskedNumber) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF640000),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            height: 40,
            width: 40,
          ),
          const SizedBox(width: 12),
          Text(
            maskedNumber,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}