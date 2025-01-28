import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title: "Book Appointment"
            Text(
              'Book Appointment',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF630A00), // Color for the title text
              ),
            ),
            const SizedBox(height: 16.0), // Space between title and grid
            // Grid view for doctors
            Expanded(
              child: GridView.builder(
                itemCount: doctors.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two cards per row
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.8, // Reduce this to make cards smaller
                ),
                itemBuilder: (context, index) {
                  final doctor = doctors[index];
                  return DoctorCard(
                    imageUrl: doctor['imageUrl']!,
                    name: doctor['name']!,
                    specialty: doctor['specialty']!,
                    rating: doctor['rating']!,
                    patients: doctor['patients']!,
                  );
                },
              ),
            ),
          ],
        ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String specialty;
  final String rating;
  final String patients;

  const DoctorCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.patients,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE7A49C), // Doctor details card background color
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.black, // Black border
          width: 2.0, // Border thickness
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Subtle shadow
            blurRadius: 8.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
            child: Image.asset(
              imageUrl, // Using local assets
              height: 140.0, // Image height remains the same
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0), // Reduced padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0, // Reduced text size
                    color: Color(0xFF424242), // Dark grey for text
                  ),
                ),
                const SizedBox(height: 2.0), // Reduced space
                Text(
                  specialty,
                  style: const TextStyle(
                    fontSize: 12.0, // Reduced font size
                    color: Colors.black, // Medium grey
                  ),
                ),
                const SizedBox(height: 4.0), // Reduced space
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14.0), // Smaller icon
                    const SizedBox(width: 4.0),
                    Text(rating, style: const TextStyle(fontSize: 12.0, color: Color(0xFF424242))),
                    const SizedBox(width: 8.0),
                    const Text(
                      '•',
                      style: TextStyle(fontSize: 12.0, color: Color(0xFF630A00)),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '$patients Patients',
                      style: const TextStyle(fontSize: 12.0, color: Color(0xFF630A00)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// List of doctors
final List<Map<String, String>> doctors = [
  {
    'imageUrl': 'lib/assets/doctor_1.jpg',
    'name': 'Haydee, Ph.D.',
    'specialty': 'Gynecologist',
    'rating': '5.0',
    'patients': '160',
  },
  {
    'imageUrl': 'lib/assets/doctor_2.jpg',
    'name': 'Angela, Ph.D.',
    'specialty': 'Gynecologist',
    'rating': '5.0',
    'patients': '124',
  },
  {
    'imageUrl': 'lib/assets/doctor_3.jpg',
    'name': 'Allexa, Ph.D.',
    'specialty': 'Gynecologist',
    'rating': '4.9',
    'patients': '100',
  },
  {
    'imageUrl': 'lib/assets/doctor_4.jpg',
    'name': 'Victoria, Ph.D.',
    'specialty': 'Gynecologist',
    'rating': '4.9',
    'patients': '89',
  },
  {
    'imageUrl': 'lib/assets/doctor_5.jpeg',
    'name': 'Dara, Ph.D.',
    'specialty': 'Gynecologist',
    'rating': '4.8',
    'patients': '78',
  },
  {
    'imageUrl': 'lib/assets/doctor_6.jpeg',
    'name': 'Viki, Ph.D.',
    'specialty': 'Gynecologist',
    'rating': '4.4',
    'patients': '60',
  },
];