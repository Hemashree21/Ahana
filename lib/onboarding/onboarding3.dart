import 'package:ahana/components/onboardingTextfield.dart';
import 'package:flutter/material.dart';
import 'package:ahana/onboarding/onboarding4.dart';
import 'package:ahana/components/myButton.dart';
import 'package:ahana/components/onboardingTextfield.dart';

class MedicalDetailsScreen extends StatefulWidget {
  const MedicalDetailsScreen({Key? key}) : super(key: key);

  @override
  State<MedicalDetailsScreen> createState() => _MedicalDetailsScreenState();
}

class _MedicalDetailsScreenState extends State<MedicalDetailsScreen> {
  final TextEditingController medicalConditionsController = TextEditingController();
  final TextEditingController medicationsController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();

  String _selectedActivityLevel = 'Sedentary';
  String _selectedDietaryPreference = 'Vegan';

  void _saveMedicalDetails() {
    String medicalConditions = medicalConditionsController.text.trim();
    String medications = medicationsController.text.trim();
    String allergies = allergiesController.text.trim();

    if (medicalConditions.isEmpty || medications.isEmpty || allergies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all medical details"),
          backgroundColor: Color(0xFF8B0000),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SuccessScreen()),
    );
  }

  Widget _buildRectangle(Color color) {
    return Container(
      width: 99.33,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFE7CA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFAAAAAA).withOpacity(0.6), // Light grey with opacity
                    Color(0xFFAAAAAA).withOpacity(0.6), // Same light grey with opacity
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
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
                      _buildRectangle(Color(0xFF8B0000)),
                      const SizedBox(width: 5),
                      _buildRectangle(Color(0xFF8B0000)),
                      const SizedBox(width: 5),
                      _buildRectangle(Color(0xFFD9D9D9)),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Medical Details",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF640000),
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextBox(label: 'Medical Conditions', placeholder: 'Ex: PCOD, PCOS', controller: medicalConditionsController),
                  const SizedBox(height: 4),
                  CustomTextBox(label: 'Current Medications', placeholder: 'Enter Current Medications', controller: medicationsController),
                  const SizedBox(height: 4),
                  CustomTextBox(label: 'Allergies', placeholder: 'Enter Allergies', controller: allergiesController),
                  const SizedBox(height: 8),
                  const Text(
                    "Activity Level",
                    style: TextStyle(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildRadioOption("Sedentary"),
                      const SizedBox(width: 5),
                      _buildRadioOption("Moderate"),
                      const SizedBox(width: 5),
                      _buildRadioOption("Active"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Dietary Preference",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: [
                      _buildDietOption("Vegan"),
                      _buildDietOption("Vegetarian"),
                      _buildDietOption("Keto"),
                      _buildDietOption("Non-Vegetarian"),
                      _buildDietOption("Gluten-Free"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            MyButton(
              onTap: _saveMedicalDetails,
              buttonText: 'Save',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label) {
    return Row(
      children: [
        Radio<String>(
          value: label,
          groupValue: _selectedActivityLevel,
          activeColor: const Color(0xFF640000),
          onChanged: (value) {
            setState(() {
              _selectedActivityLevel = value!;
            });
          },
        ),
        Text(label),
      ],
    );
  }

  Widget _buildDietOption(String label) {
    bool isSelected = _selectedDietaryPreference == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDietaryPreference = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF640000) : Colors.transparent,
          border: Border.all(color: const Color(0xFF640000), width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF640000),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter $label",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF640000)),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}