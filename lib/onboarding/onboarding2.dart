import 'package:ahana/onboarding/onboarding3.dart';
import 'package:flutter/material.dart';
import 'package:ahana/components/onboardingTextfield.dart';
import 'package:ahana/components/myButton.dart';

class CycleDetailsPage extends StatefulWidget {
  @override
  _CycleDetailsPageState createState() => _CycleDetailsPageState();
}

class _CycleDetailsPageState extends State<CycleDetailsPage> {
  double painSeverity = 2;
  int periodDuration = 5;
  String? flowIntensity = 'light';
  late TextEditingController _periodDurationController;
  final TextEditingController lastperiod = TextEditingController();
  final TextEditingController cyclelength = TextEditingController();

  @override
  void initState() {
    super.initState();
    _periodDurationController =
        TextEditingController(text: periodDuration.toString());
  }

  @override
  void dispose() {
    _periodDurationController.dispose();
    super.dispose();
  }

  void saveCycleDetails() {
    // Check if all fields are filled
    if (lastperiod.text.isEmpty || cyclelength.text.isEmpty || _periodDurationController.text.isEmpty) {
      // Show an error message or highlight the empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the required fields'),
          backgroundColor: Color(0xFF8B0000),
        ),
      );
    } else {
      // If all fields are filled, proceed to the next page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MedicalDetailsScreen()),
      );
    }
  }


  void _updatePeriodDuration(int change) {
    setState(() {
      periodDuration += change;
      if (periodDuration < 0) {
        periodDuration = 0;
      }
      _periodDurationController.text = periodDuration.toString();
    });
  }

  String _getPainSeverityLabel(double value) {
    const labels = ['None', 'Mild', 'Moderate', 'Severe', 'Very Severe'];
    return labels[value.toInt()];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20), // Space between notification bar and cream box
                  Container(
                    padding: const EdgeInsets.all(20), // Reduced top padding inside the cream box
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
                        // Rectangle indicators
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildRectangle(Color(0xFF8B0000)),
                            const SizedBox(width: 5),
                            _buildRectangle(Color(0xFFD9D9D9)),
                            const SizedBox(width: 5),
                            _buildRectangle(Color(0xFFD9D9D9)),
                          ],
                        ),
                        const SizedBox(height: 30), // Adjusted spacing
                        const Text(
                          'Cycle Details',
                          style: TextStyle(
                            fontSize: 22, // Reduced from 22 to 20
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF640000),
                          ),
                        ),
                        const SizedBox(height: 12),
                        CustomTextBox(label: 'First day of Last Period', controller: lastperiod, placeholder: 'Enter your last period'),
                        const SizedBox(height: 4),
                        CustomTextBox(label: 'Cycle Length', controller: cyclelength, placeholder: 'Enter your cycle length'),
                        const SizedBox(height: 8),
                        _buildSectionTitle(
                            'Period Duration'),
                        const SizedBox(height: 8),
                        _buildDurationSelector(),
                        const SizedBox(height: 18),
                        _buildSectionTitle('Flow Intensity'),
                        _buildFlowIntensityOptions(),
                        const SizedBox(height: 8),
                        _buildSectionTitle('Severity of Pain'),
                        const SizedBox(height: 1),
                        Slider(
                          value: painSeverity,
                          min: 0,
                          max: 4,
                          divisions: 4,
                          label: _getPainSeverityLabel(painSeverity),
                          activeColor: const Color(0xFF8B0000),
                          onChanged: (value) {
                            setState(() {
                              painSeverity = value;
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('None', style: TextStyle(fontSize: 12)),
                            Text('Mild', style: TextStyle(fontSize: 12)),
                            Text('Moderate', style: TextStyle(fontSize: 12)),
                            Text('Severe', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                        Padding(padding: const EdgeInsets.all(16))
                      ],
                    ),
                  ),
                  const SizedBox(height: 40), // Space between cream box and "Next"
                  MyButton(onTap: saveCycleDetails, buttonText: 'Next'),
                ],
              ),
            ),
          ),
        ),
      ),
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDurationSelector() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => _updatePeriodDuration(-1),
            icon: const Icon(
              Icons.remove_circle_outline,
              color: Colors.brown,
            ),
          ),
          Container(
            width: 190,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.brown, width: 2),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: _periodDurationController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
              onChanged: (value) {
                if (int.tryParse(value) != null) {
                  setState(() {
                    periodDuration = int.parse(value);
                  });
                }
              },
            ),
          ),
          IconButton(
            onPressed: () => _updatePeriodDuration(1),
            icon: const Icon(
              Icons.add_circle_outline,
              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlowIntensityOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: RadioListTile<String>(
            activeColor: const Color(0xFF8B0000),
            contentPadding: EdgeInsets.zero,
            dense: true,
            visualDensity: VisualDensity(horizontal: -4),
            title: const Text('Light', style: TextStyle(fontSize: 12)), // Reduced from 13 to 12
            value: 'light',
            groupValue: flowIntensity,
            onChanged: (value) {
              setState(() {
                flowIntensity = value;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            activeColor: const Color(0xFF8B0000),
            contentPadding: EdgeInsets.zero,
            dense: true,
            visualDensity: VisualDensity(horizontal: -4),
            title: const Text('Moderate', style: TextStyle(fontSize: 12)), // Reduced from 13 to 12
            value: 'moderate',
            groupValue: flowIntensity,
            onChanged: (value) {
              setState(() {
                flowIntensity = value;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            activeColor: const Color(0xFF8B0000),
            contentPadding: EdgeInsets.zero,
            dense: true,
            visualDensity: VisualDensity(horizontal: -4),
            title: const Text('Heavy', style: TextStyle(fontSize: 12)), // Reduced from 13 to 12
            value: 'heavy',
            groupValue: flowIntensity,
            onChanged: (value) {
              setState(() {
                flowIntensity = value;
              });
            },
          ),
        ),
      ],
    );
  }
}