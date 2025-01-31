import 'package:ahana/onboarding/onboarding3.dart';
import 'package:flutter/material.dart';
import 'package:ahana/components/onboardingTextfield.dart';
import 'package:ahana/components/myButton.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CycleDetailsPage extends StatefulWidget {
  @override
  _CycleDetailsPageState createState() => _CycleDetailsPageState();
}

class _CycleDetailsPageState extends State<CycleDetailsPage> {
  double painSeverity = 2;
  int periodDuration = 5;
  String? flowIntensity = 'light';
  late TextEditingController _periodDurationController;
  final TextEditingController cyclelength = TextEditingController();
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _periodDurationController = TextEditingController(text: periodDuration.toString());
  }

  @override
  void dispose() {
    _periodDurationController.dispose();
    cyclelength.dispose();
    super.dispose();
  }

  void saveCycleDetails() {
    if (cyclelength.text.isEmpty || _periodDurationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all the required fields'),
          backgroundColor: Color(0xFF8B0000),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MedicalDetailsScreen()),
      );
    }
  }

  Widget _buildCalendarSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'First day of Last Period',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF630A00), width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          focusedDay = DateTime(focusedDay.year, focusedDay.month - 1);
                        });
                      },
                      child: const Icon(
                        Icons.arrow_left,
                        color: Color(0xFF630A00),
                        size: 30,
                      ),
                    ),
                    Text(
                      DateFormat.yMMMM().format(focusedDay),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF630A00),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final nextMonth = DateTime(focusedDay.year, focusedDay.month + 1);
                        if (!nextMonth.isAfter(DateTime.now())) {
                          setState(() {
                            focusedDay = nextMonth;
                          });
                        }
                      },
                      child: const Icon(
                        Icons.arrow_right,
                        color: Color(0xFF630A00),
                        size: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                      .map((day) => Text(
                    day,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF630A00),
                    ),
                  ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemCount: 42,
                itemBuilder: (context, index) {
                  final date = DateTime(focusedDay.year, focusedDay.month, 1)
                      .subtract(Duration(
                      days: DateTime(focusedDay.year, focusedDay.month, 1).weekday - 1))
                      .add(Duration(days: index));

                  final isSelected = isSameDay(date, selectedDay);
                  final isCurrentMonth = date.month == focusedDay.month;
                  final isFutureDate = date.isAfter(DateTime.now());

                  return GestureDetector(
                    onTap: () {
                      if (!isFutureDate) {
                        setState(() {
                          selectedDay = date;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? const Color(0xFF630A00)
                            : Colors.transparent,
                        border: isCurrentMonth && !isSelected && !isFutureDate
                            ? Border.all(color: const Color(0xFF630A00))
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            color: isFutureDate
                                ? Colors.grey.withOpacity(0.3)
                                : !isCurrentMonth
                                ? Colors.grey
                                : isSelected
                                ? Colors.white
                                : const Color(0xFF630A00),
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Selected Date: ${DateFormat('MMM dd, yyyy').format(selectedDay)}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF630A00),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFAAAAAA).withOpacity(0.6),
                          Color(0xFFAAAAAA).withOpacity(0.6),
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
                            _buildRectangle(Color(0xFFD9D9D9)),
                            const SizedBox(width: 5),
                            _buildRectangle(Color(0xFFD9D9D9)),
                          ],
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Cycle Details',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF640000),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildCalendarSection(),
                        const SizedBox(height: 16),
                        CustomTextBox(
                            label: 'Cycle Length',
                            controller: cyclelength,
                            placeholder: 'Enter your cycle length'
                        ),
                        const SizedBox(height: 16),
                        _buildSectionTitle('Period Duration'),
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
                        const Padding(padding: EdgeInsets.all(16))
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
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
            visualDensity: const VisualDensity(horizontal: -4),
            title: const Text('Light', style: TextStyle(fontSize: 12)),
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
            visualDensity: const VisualDensity(horizontal: -4),
            title: const Text('Moderate', style: TextStyle(fontSize: 12)),
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
            visualDensity: const VisualDensity(horizontal: -4),
            title: const Text('Heavy', style: TextStyle(fontSize: 12)),
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

}