import 'package:ahana/components/basePage.dart';
import 'package:flutter/material.dart';
import 'package:ahana/pages/bookAppointment.dart';

// Doctor class remains the same
class Doctor {
  final String name;
  final String specialty;
  final String imageUrl;
  final String rating;
  final int patients;
  final String about;
  final String timing;
  final List<String> services;

  Doctor({
    required this.name,
    required this.specialty,
    required this.imageUrl,
    required this.rating,
    required this.patients,
    required this.about,
    required this.timing,
    required this.services,
  });
}

class DoctorDetailsPage extends StatelessWidget {
  final Doctor doctor;

  const DoctorDetailsPage({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          // Custom AppBar
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          doctor.imageUrl,
                          height: 350.0,
                          width: 500.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      doctor.name,
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF424242),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      doctor.specialty,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18.0),
                        const SizedBox(width: 4.0),
                        Text(
                          doctor.rating,
                          style: const TextStyle(fontSize: 16.0, color: Color(0xFF616161)),
                        ),
                        const SizedBox(width: 16.0),
                        const Text(
                          '•',
                          style: TextStyle(fontSize: 16.0, color: Color(0xFF630A00)),
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          '${doctor.patients} Patients',
                          style: const TextStyle(fontSize: 16.0, color: Color(0xFF630A00)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'About Doctor:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF630A00),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      doctor.about,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Available Timings:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF630A00),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      doctor.timing,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    const Text(
                      'Services Provided:',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF630A00),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: doctor.services.map((service) => Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          '• $service',
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black87,
                            height: 1.5,
                          ),
                        ),
                      )).toList(),
                    ),
                    const SizedBox(height: 32.0),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BasePage(
                                  activeSection: 'consultation',
                                  body: BookAppointment(doctorName: doctor.name, doctorImage: doctor.imageUrl),
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF630A00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text(
                          'Book Appointment',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
    );
  }
}