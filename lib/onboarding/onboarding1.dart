import 'package:ahana/components/myButton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ahana/onboarding/onboarding2.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<Onboarding1> {
  final _formKey = GlobalKey<FormState>();

  void savePersonalDetails() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CycleDetailsPage()),
      );
    } else {
      // Optionally, show a snackbar or alert to notify the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all the fields before proceeding"),
          backgroundColor: Color(0xFF8B0000),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE7CA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        const Color(0xFFAAAAAA).withOpacity(0.6),
                        const Color(0xFFAAAAAA).withOpacity(0.6),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildRectangle(),
                          const SizedBox(width: 5),
                          _buildRectangle(),
                          const SizedBox(width: 5),
                          _buildRectangle(),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        "Personal Details",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF640000),
                        ),
                      ),
                      const SizedBox(height: 12),
                      const CustomTextField(label: "Name", hint: "Enter your name"),
                      const SizedBox(height: 4),
                      const CustomTextField(
                        label: "Contact Number",
                        hint: "Enter your Contact Number",
                        isNumeric: true,
                      ),
                      const SizedBox(height: 4),
                      const CustomTextField(
                        label: "Age",
                        hint: "Enter your age",
                        isNumeric: true,
                      ),
                      const SizedBox(height: 4),
                      const CustomTextField(label: "Location", hint: "Enter your location"),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                MyButton(onTap: savePersonalDetails, buttonText: 'Next')
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRectangle() {
    return Container(
      width: 99.33,
      height: 6,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isContact;
  final bool isNumeric;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.isContact = false,
    this.isNumeric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Color(0xff605C5C)),
              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF630A00)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF630A00)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF630A00), width: 2),
              ),
            ),
            keyboardType: isNumeric
                ? TextInputType.number
                : isContact
                ? TextInputType.emailAddress
                : TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter $label.";
              }
              if (isContact && !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                return "Please enter a valid 10-digit contact number.";
              }
              if (isNumeric && int.tryParse(value) == null) {
                return "Please enter a valid age.";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}

class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Next Page"),
      ),
      body: const SafeArea(
        child: Center(
          child: Text(
            "This is a Next page",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ),
      ),
    );
  }
}