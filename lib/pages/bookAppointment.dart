import 'package:ahana/components/basePage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'viewAppointment.dart';  // Import the new file

class BookAppointment extends StatefulWidget {
  final String doctorName;
  final String doctorImage;

  const BookAppointment({
    Key? key,
    required this.doctorName,
    required this.doctorImage
  }) : super(key: key);

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  DateTime _selectedDate = DateTime.now();
  int _selectedTimeIndex = -1;
  int _selectedSlotRangeIndex = -1;

  final List<String> _morningSlots = ["09:00 AM", "10:00 AM", "11:00 AM"];
  final List<String> _eveningSlots = ["04:00 PM", "05:00 PM", "06:00 PM"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom title instead of AppBar
            const Text(
              "Book Appointment",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF630A00), // Dark Red color
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            _buildCalendar(),
            const SizedBox(height: 20),
            _buildSlotRangePicker(),
            const SizedBox(height: 20),
            if (_selectedSlotRangeIndex != -1) _buildTimeSlotChips(),
            const SizedBox(height: 40),
            _buildBookingButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _selectedDate,
      firstDay: DateTime.now(),
      lastDay: DateTime(2030),
      selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
        });
      },
      calendarStyle: CalendarStyle(
        todayTextStyle: TextStyle(color: Colors.black),
        selectedTextStyle: TextStyle(color: Colors.black),
        selectedDecoration: BoxDecoration(
          color: Color(0xFFE7A49C), // Dark Red color for selected date
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildSlotRangePicker() {
    return Wrap(
      spacing: 10,
      children: List.generate(2, (index) {
        return ChoiceChip(
          label: Text(index == 0 ? "Morning" : "Evening"),
          selected: _selectedSlotRangeIndex == index,
          onSelected: (selected) {
            setState(() {
              _selectedSlotRangeIndex = selected ? index : -1;
              _selectedTimeIndex = -1;
            });
          },
          selectedColor: Color(0xFFE7A49C), // Dark Red color for selected chip
          backgroundColor: Colors.grey[200],
        );
      }),
    );
  }

  Widget _buildTimeSlotChips() {
    final List<String> timeSlots = _selectedSlotRangeIndex == 0 ? _morningSlots : _eveningSlots;
    return Wrap(
      spacing: 10,
      children: List.generate(timeSlots.length, (index) {
        return ChoiceChip(
          label: Text(timeSlots[index]),
          selected: _selectedTimeIndex == index,
          onSelected: (selected) {
            setState(() {
              _selectedTimeIndex = selected ? index : -1;
            });
          },
          selectedColor: Color(0xFFE7A49C), // Dark Red color for selected time slot
          backgroundColor: Colors.grey[200],
        );
      }),
    );
  }

  Widget _buildBookingButton() {
    return ElevatedButton(
      onPressed: _selectedTimeIndex == -1 ? null : _handleBooking,
      child: const Text("Confirm Booking"),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF630A00), // Light red color for button
        foregroundColor: Colors.white, // Black text color
        minimumSize: Size(double.infinity, 50), // Set width to fill the parent and height to 50
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Set border radius to 30
        ),
      ),
    );

  }

  void _handleBooking() async {
    // Format the selected date
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

    // Get the selected time slot
    final List<String> timeSlots = _selectedSlotRangeIndex == 0 ? _morningSlots : _eveningSlots;
    String selectedTime = timeSlots[_selectedTimeIndex];

    // Create and save the appointment
    final appointment = Appointment()
      ..name = widget.doctorName
      ..date = "$formattedDate at "
      ..time = selectedTime
      ..image = widget.doctorImage;

    await AppointmentService.addAppointment(appointment);

    // Navigate to ViewAppointment
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => BasePage(
              activeSection: 'consultation',
              body: const ViewAppointment()
          )
      ),
    );
  }
}
