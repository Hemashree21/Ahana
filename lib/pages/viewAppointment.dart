import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'viewAppointment.g.dart';

@HiveType(typeId: 1)
class Appointment extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String date;

  @HiveField(2)
  late String time;

  @HiveField(3)
  late String image;
}

class AppointmentService {
  static Future<void> initHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AppointmentAdapter());

    // Only open the box if it's not already open
    if (!Hive.isBoxOpen('appointments')) {
      await Hive.openBox<Appointment>('appointments');
    }
  }

  static Future<void> addAppointment(Appointment appointment) async {
    // Ensure the box is open before adding
    if (!Hive.isBoxOpen('appointments')) {
      await Hive.openBox<Appointment>('appointments');
    }

    final box = Hive.box<Appointment>('appointments');
    await box.add(appointment);
  }
}

class ViewAppointment extends StatefulWidget {
  const ViewAppointment({Key? key}) : super(key: key);

  @override
  _ViewAppointmentState createState() => _ViewAppointmentState();
}

class _ViewAppointmentState extends State<ViewAppointment> {
  late Box<Appointment> _appointmentsBox;

  @override
  void initState() {
    super.initState();
    _appointmentsBox = Hive.box<Appointment>('appointments');
  }

  void _cancelAppointment(int index) {
    // Show a confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Cancellation'),
          content: const Text('Are you sure you want to cancel this appointment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();  // Close the dialog
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                final appointment = _appointmentsBox.getAt(index);
                appointment?.delete();

                // Trigger a rebuild of the widget to update the UI
                setState(() {
                  // This will force the widget to rebuild, reflecting the deletion immediately
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Appointment cancelled successfully'),
                    backgroundColor: Colors.red,
                  ),
                );
                Navigator.of(context).pop();  // Close the dialog
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              "Booked Appointments",
              style: TextStyle(
                fontSize: 25,
                color: Color(0xFF630A00),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: _appointmentsBox.isEmpty
                  ? const Center(child: Text("No appointments booked."))
                  : ListView.builder(
                itemCount: _appointmentsBox.length,
                itemBuilder: (context, index) {
                  final appointment = _appointmentsBox.getAt(index)!;
                  return Card(
                    color: Color(0xFFEFE7CA),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xFF630A00), // Border color is black
                        width: 2.5,          // Border width is 2.0
                      ),
                      borderRadius: BorderRadius.circular(8.0), // Optional: Adjust the corner radius if needed
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(appointment.image),
                      ),
                      title: Text(
                        appointment.name,
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(text: appointment.date, style: const TextStyle(color: Color(0xFF630A00), fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: appointment.time,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF630A00),
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.cancel, color: Color(0xFF630A00)),
                        onPressed: () => _cancelAppointment(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}