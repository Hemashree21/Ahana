import 'package:ahana/components/basePage.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class BookAppointment extends StatefulWidget {
  final String doctorName;

  const BookAppointment({Key? key, required this.doctorName}) : super(key: key);

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  int _selectedSlotRangeIndex = -1;
  int _selectedTimeIndex = -1;

  final String hospitalName = "General Hospital";

  final List<String> _morningSlots = [
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "01:00 PM"
  ];

  final List<String> _eveningSlots = [
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
    "06:00 PM",
    "07:00 PM",
    "08:00 PM"
  ];

  final List<String> bookedAppointments = [];

  bool _isDateSelectable(DateTime date) {
    return date.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        date.weekday != DateTime.sunday;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildDoctorInfoBox(),
              const SizedBox(height: 20),
              _buildCalendar(),
              const SizedBox(height: 20),
              _buildSlotRangePicker(),
              const SizedBox(height: 20),
              if (_selectedSlotRangeIndex != -1) _buildTimeSlotChips(),
              const SizedBox(height: 20),
              _buildBookingButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorInfoBox() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF630A00),
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.doctorName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            hospitalName,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE7A49C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildCalendarHeader(),
          const SizedBox(height: 16),
          _buildTableCalendar(),
        ],
      ),
    );
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_left, color: Color(0xFF630A00), size: 30),
          onPressed: () {
            setState(() {
              _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1, _focusedDay.day);
            });
          },
        ),
        Text(
          DateFormat.yMMMM().format(_focusedDay),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF630A00),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_right, color: Color(0xFF630A00), size: 30),
          onPressed: () {
            setState(() {
              _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1, _focusedDay.day);
            });
          },
        ),
      ],
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      focusedDay: _focusedDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2030),
      selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
      enabledDayPredicate: _isDateSelectable,
      calendarStyle: const CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Color(0xFF630A00),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Color(0xFFA76760),
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false,
        weekendTextStyle: TextStyle(color: Color(0xFF630A00)),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        if (_isDateSelectable(selectedDay)) {
          setState(() {
            _selectedDate = selectedDay;
            _focusedDay = focusedDay;
          });
        }
      },
      headerVisible: false,
    );
  }

  Widget _buildSlotRangePicker() {
    return Wrap(
      spacing: 10,
      children: List.generate(2, (index) {
        final slotLabel = index == 0 ? "09:00 AM - 2:00 PM" : "03:00 PM - 10:00 PM";
        return ChoiceChip(
          label: Text(
            slotLabel,
            style: TextStyle(
              color: _selectedSlotRangeIndex == index ? Colors.white : Colors.black,
            ),
          ),
          selected: _selectedSlotRangeIndex == index,
          onSelected: (selected) {
            setState(() {
              _selectedSlotRangeIndex = selected ? index : -1;
              _selectedTimeIndex = -1;
            });
          },
          selectedColor: const Color(0xFFA76760),
        );
      }),
    );
  }

  Widget _buildTimeSlotChips() {
    final List<String> timeSlots = _selectedSlotRangeIndex == 0 ? _morningSlots : _eveningSlots;
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(timeSlots.length, (index) {
        return ChoiceChip(
          label: Text(
            timeSlots[index],
            style: TextStyle(
              color: _selectedTimeIndex == index ? Colors.white : Colors.black,
            ),
          ),
          selected: _selectedTimeIndex == index,
          onSelected: (selected) {
            setState(() {
              _selectedTimeIndex = selected ? index : -1;
            });
          },
          selectedColor: const Color(0xFFA76760),
        );
      }),
    );
  }

  Widget _buildBookingButton() {
    return ElevatedButton(
      onPressed: _selectedTimeIndex == -1
          ? null
          : () => _handleBooking(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFA76760),
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'Book Appointment',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void _handleBooking(BuildContext context) {
    final selectedSlots = _selectedSlotRangeIndex == 0 ? _morningSlots : _eveningSlots;
    final appointmentDetail = "${DateFormat('yyyy-MM-dd').format(_selectedDate)} at ${selectedSlots[_selectedTimeIndex]}";
    final fullAppointmentDetails = "${widget.doctorName} - $hospitalName: $appointmentDetail";

    setState(() {
      bookedAppointments.add(fullAppointmentDetails);
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BasePage(
          activeSection: 'consultation',
          body: AppointmentPage(
            appointmentDetails: fullAppointmentDetails,
            bookedAppointments: bookedAppointments,
            onCancelAppointment: (index) {
              setState(() {
                bookedAppointments.removeAt(index);
              });
            },
          ),
        ),
      ),
    );
  }
}

class AppointmentPage extends StatelessWidget {
  final String appointmentDetails;
  final List<String> bookedAppointments;
  final Function(int) onCancelAppointment;

  const AppointmentPage({
    Key? key,
    required this.appointmentDetails,
    required this.bookedAppointments,
    required this.onCancelAppointment,
  }) : super(key: key);

  void _showCancelConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancel Appointment'),
          content: const Text('Are you sure you want to cancel this appointment?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                onCancelAppointment(index);
                Navigator.pop(context); // Close dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Appointment cancelled successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('Yes', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Booked Appointments',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              appointmentDetails,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA76760),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Go to Home',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: bookedAppointments.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(
                      Icons.event,
                      color: Color(0xFF630A00),
                    ),
                    title: Text(bookedAppointments[index]),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      onPressed: () => _showCancelConfirmationDialog(context, index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

