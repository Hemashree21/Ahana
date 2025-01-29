import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class PeriodCalendar extends StatefulWidget {
  const PeriodCalendar({super.key});

  @override
  _PeriodCalendarState createState() => _PeriodCalendarState();
}

class _PeriodCalendarState extends State<PeriodCalendar> {
  bool isExpanded = false;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  bool isCurrentDate(DateTime date) {
    return date.day == DateTime.now().day && date.month == DateTime.now().month && date.year == DateTime.now().year;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Color(0xFF630A00),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Row(
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
                      setState(() {
                        focusedDay = DateTime(focusedDay.year, focusedDay.month + 1);
                      });
                    },
                    child: const Icon(
                      Icons.arrow_right,
                      color: Color(0xFF630A00),
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (!isExpanded)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSimpleDate('15', 'Mon', isHighlighted: isCurrentDate(DateTime(focusedDay.year, focusedDay.month, 15))),
                    _buildSimpleDate('16', 'Tue', isHighlighted: isCurrentDate(DateTime(focusedDay.year, focusedDay.month, 16))),
                    _buildSimpleDate('17', 'Wed', isHighlighted: isCurrentDate(DateTime(focusedDay.year, focusedDay.month, 17))),
                    _buildSimpleDate('18', 'Thu', isHighlighted: isCurrentDate(DateTime(focusedDay.year, focusedDay.month, 18))),
                    _buildSimpleDate('19', 'Fri', isHighlighted: isCurrentDate(DateTime(focusedDay.year, focusedDay.month, 19))),
                    _buildSimpleDate('20', 'Sat', isPeriodDay: true, isDroplet: true, isHighlighted: isCurrentDate(DateTime(focusedDay.year, focusedDay.month, 20))),
                    _buildSimpleDate('21', 'Sun', isPeriodDay: true, isDroplet: true, isHighlighted: isCurrentDate(DateTime(focusedDay.year, focusedDay.month, 21))),
                    _buildSimpleDate('22', 'Mon', isPeriodDay: true, isDroplet: true, isHighlighted: isCurrentDate(DateTime(focusedDay.year, focusedDay.month, 22))),
                  ],
                )
              else
                TableCalendar(
                  focusedDay: focusedDay,
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2030),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: const Color(0xFFE7A49C),
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    outsideDaysVisible: false,
                    weekendTextStyle: const TextStyle(color: Color(0xFF630A00)),
                    markerDecoration: BoxDecoration(
                      color: const Color(0xFF630A00),
                      shape: BoxShape.circle,
                    ),
                  ),
                  selectedDayPredicate: (day) => isSameDay(day, selectedDay),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      if ([20, 21, 22].contains(day.day) &&
                          day.month == focusedDay.month &&
                          day.year == focusedDay.year) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF630A00),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      this.selectedDay = selectedDay;
                      this.focusedDay = focusedDay;
                    });
                  },
                  headerVisible: false,
                ),
              const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: () => setState(() => isExpanded = !isExpanded),
                  child: Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: const Color(0xFF630A00),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleDate(
      String date,
      String day, {
        bool isHighlighted = false,
        bool isPeriodDay = false,
        bool isDroplet = false,
        Color? color,
      }) {
    bool isCurrentDay = DateTime.now().day.toString() == date;

    return Column(
      children: [
        Text(
          day,
          style: TextStyle(
            fontSize: 12,
            color: isPeriodDay ? const Color(0xFF630A00) : Colors.brown[600],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isPeriodDay
                ? const Color(0xFF630A00)
                : isHighlighted || isCurrentDay
                ? const Color(0xFFE7A49C)
                : null,
            shape: isDroplet ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: isDroplet
                ? BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            )
                : null,
          ),
          child: Center(
            child: Text(
              date,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isPeriodDay || isHighlighted || isCurrentDay
                    ? Colors.white
                    : Colors.brown[800],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
