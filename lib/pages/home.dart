import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ahana/pages/articles.dart';
import 'package:ahana/components/basePage.dart';

// BasePage widget for reusing AppBar and BottomNavigationBar
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isExpanded = false; // Controls calendar expansion
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BasePage(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting Text
            Text(
              'Hi Sara!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF630A00),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'January, 2025',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF767600),
              ),
            ),
            SizedBox(height: 16),

            // Calendar Section
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.pink, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildWeekCalendar(),
                  if (isExpanded) _buildFullCalendar(),
                  IconButton(
                    icon: Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.pink,
                    ),
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Today Section
            Text(
              'Today',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF630A00),
              ),
            ),
            SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _nextAppointmentCard(),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      _card(
                        icon: Icons.book,
                        title: 'My Periods',
                        iconColor: Color(0xFF630A00),
                        backgroundColor: Color(0xFFA76760),
                        textColor: Color(0xFF630A00),
                        subtitle: 'History',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Popular Articles Section
            Text(
              'Popular Articles',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF630A00),
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticlePage(),
                      settings: RouteSettings(name: '/articles')
                  ),
                );
              },
              child: _articleCard(
                image: 'lib/assets/art.png',
                title: '5 things everyone should know about menstruation',
                author: 'Maria Cohut, Ph.D.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeekCalendar() {
    final days = List.generate(7, (index) => selectedDay.add(Duration(days: index)));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days.map((day) {
        final isToday = day.day == DateTime.now().day;
        final isHighlight = day.isAfter(DateTime.now()) &&
            day.isBefore(DateTime.now().add(Duration(days: 4)));
        return Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isToday
                ? Colors.pink
                : isHighlight
                ? Color(0xFF630A00)
                : Colors.pink[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][day.weekday - 1],
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                '${day.day}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isToday || isHighlight ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFullCalendar() {
    return TableCalendar(
      focusedDay: focusedDay,
      firstDay: DateTime(2020),
      lastDay: DateTime(2030),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Colors.pink,
          shape: BoxShape.circle,
        ),
        outsideDaysVisible: false,
        cellMargin: EdgeInsets.all(6),
        rangeHighlightColor: Color(0xFF630A00),
      ),
      selectedDayPredicate: (day) => isSameDay(day, selectedDay),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          this.selectedDay = selectedDay;
          this.focusedDay = focusedDay;
        });
      },
    );
  }

  Widget _nextAppointmentCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFA76760),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              'lib/assets/doctor.png',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next Appointment',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF630A00),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '18 January 2025\n01:30 PM\nDr. Selly\nGeneral Practitioner',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _card({
    required IconData icon,
    required String title,
    String? subtitle,
    String? additional,
    required Color iconColor,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 56,
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: textColor,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(color: Colors.white),
            ),
          ],
          if (additional != null) ...[
            SizedBox(height: 8),
            Text(
              additional,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ],
      ),
    );
  }

  Widget _articleCard({
    required String image,
    required String title,
    required String author,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFFA76760),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  author,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}