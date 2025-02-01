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
  final DateTime today = DateTime.now();

  bool isCurrentDate(DateTime date) {
    return date.day == today.day &&
        date.month == today.month &&
        date.year == today.year;
  }

  List<DateTime> _getWeekDates() {
    final weekDay = today.weekday;
    final startDate = today.subtract(Duration(days: weekDay - 1));
    return List.generate(8, (index) {
      return startDate.add(Duration(days: index));
    });
  }

  List<String> _getWeekDays() {
    return ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun', 'Mon'];
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = _getWeekDates();
    final weekDays = _getWeekDays();

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
                  children: List.generate(
                    8,
                        (index) {
                      final date = weekDates[index];
                      return _buildSimpleDate(
                        date,
                        weekDays[index],
                        isPeriodDay: [20, 21, 22].contains(date.day) && date.month == focusedDay.month,
                        isDroplet: [20, 21, 22].contains(date.day) && date.month == focusedDay.month,
                        showOutline: isCurrentDate(date) && date.month == focusedDay.month,
                      );
                    },
                  ),
                )
              else
                TableCalendar(
                  focusedDay: focusedDay,
                  firstDay: DateTime(2020),
                  lastDay: DateTime(2030),
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: TextStyle(
                      color: Colors.black,
                    ),
                    weekendTextStyle: TextStyle(
                      color: Color(0xFF630A00),
                    ),
                    outsideDaysVisible: false,
                  ),
                  selectedDayPredicate: (day) => isSameDay(day, selectedDay),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      bool isPeriodDay = [20, 21, 22].contains(day.day) &&
                          day.month == focusedDay.month;
                      bool isTodayInCurrentMonth = isCurrentDate(day) &&
                          day.month == focusedDay.month;

                      if (isTodayInCurrentMonth) {
                        return Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF630A00),
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '${day.day}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }

                      if (isPeriodDay) {
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
                    todayBuilder: (context, day, focusedDay) {
                      if (day.month != focusedDay.month) return null;

                      return Container(
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFF630A00),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '${day.day}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
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
      DateTime date,
      String day, {
        bool isPeriodDay = false,
        bool isDroplet = false,
        bool showOutline = false,
        Color? color,
      }) {
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
                : Colors.transparent,
            shape: isDroplet ? BoxShape.rectangle : BoxShape.circle,
            border: showOutline
                ? Border.all(
              color: Color(0xFF630A00),
              width: 2,
            )
                : null,
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
              '${date.day}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: isPeriodDay
                    ? Colors.white
                    : showOutline
                    ? Colors.black
                    : Colors.brown[800],
              ),
            ),
          ),
        ),
      ],
    );
  }
}