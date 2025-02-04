import 'package:ahana/components/basePage.dart';
import 'package:flutter/material.dart';
import 'package:ahana/pages/doctorDetails.dart';

class AppointmentPage extends StatelessWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book Appointment',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Color(0xFF630A00),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
                itemCount: doctorsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final doctor = doctorsList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BasePage(
                              activeSection: 'consultation',
                              body: DoctorDetailsPage(doctor: doctor)
                          ),
                        ),
                      );
                    },
                    child: DoctorCard(doctor: doctor),
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
  final Doctor doctor;

  const DoctorCard({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE7A49C),
        borderRadius: BorderRadius.circular(12.0),
        // border: Border.all(
        //   color: Color(0xFF630A00),
        //   width: 2.0,
        // ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
              doctor.imageUrl,
              height: 140.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Color(0xFF424242),
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  doctor.specialty,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 14.0),
                    const SizedBox(width: 4.0),
                    Text(
                      doctor.rating,
                      style: const TextStyle(fontSize: 12.0, color: Color(0xFF616161)),
                    ),
                    const SizedBox(width: 8.0),
                    const Text(
                      '•',
                      style: TextStyle(fontSize: 12.0, color: Color(0xFF630A00)),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      '${doctor.patients} Patients',
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
final List<Doctor> doctorsList = [
  Doctor(
    imageUrl: 'lib/assets/doctor_1.jpg',
    name: 'Haydee, MD',
    specialty: 'Gynecologist',
    rating: '5.0',
    patients: 160,
    about: 'Dr. Haydee is a renowned specialist with years of experience in the field of gynecology. She is known for her dedication and compassionate care for patients.',
    timing: 'Monday to Friday: 9:00 AM - 5:00 PM\nSaturday: 10:00 AM - 3:00 PM\nSunday: Closed',
    services: [
      'General Gynecological Consultation',
      'Prenatal Care',
      'Women\'s Health Screenings',
      'Family Planning Services'
    ],
  ),
  Doctor(
    imageUrl: 'lib/assets/doctor_2.jpg',
    name: 'John Doe, MBBS',
    specialty: 'Dietician',
    rating: '4.5',
    patients: 124,
    about: 'Dr. John Doe specializes in women\'s reproductive health and has extensive experience in treating various gynecological conditions.',
    timing: 'Monday to Friday: 10:00 AM - 6:00 PM\nSaturday: 9:00 AM - 2:00 PM\nSunday: Closed',
    services: [
      'Gynecological Examinations',
      'Fertility Treatments',
      'Menopause Management',
      'Gynecologic Surgery'
    ],
  ),
  Doctor(
    imageUrl: 'lib/assets/doctor_3.jpg',
    name: 'Allexa, MS',
    specialty: 'Gynecologist',
    rating: '4.9',
    patients: 100,
    about: 'Dr. Allexa is highly skilled in providing comprehensive women\'s healthcare services with a focus on preventive care.',
    timing: 'Monday to Friday: 8:00 AM - 4:00 PM\nSaturday: 9:00 AM - 1:00 PM\nSunday: Closed',
    services: [
      'Reproductive Health Care',
      'Obstetric Care',
      'Gynecologic Ultrasound',
      'Minimally Invasive Surgery'
    ],
  ),
  Doctor(
    imageUrl: 'lib/assets/doctor_4.jpg',
    name: 'Victoria, MD.',
    specialty: 'Gynecologist',
    rating: '4.9',
    patients: 89,
    about: 'Dr. Victoria brings innovative approaches to women\'s healthcare with a special focus on adolescent gynecology.',
    timing: 'Monday to Friday: 9:00 AM - 5:00 PM\nSaturday: 10:00 AM - 2:00 PM\nSunday: Closed',
    services: [
      'Adolescent Gynecology',
      'Contraceptive Care',
      'STD Testing and Treatment',
      'Hormonal Disorders Treatment'
    ],
  ),
  Doctor(
    imageUrl: 'lib/assets/doctor_5.jpeg',
    name: 'Dara, MD',
    specialty: 'Dietician',
    rating: '4.8',
    patients: 78,
    about: 'Dr. Dara specializes in high-risk pregnancies and advanced gynecological procedures with a patient-centered approach.',
    timing: 'Monday to Friday: 8:30 AM - 4:30 PM\nSaturday: 9:00 AM - 12:00 PM\nSunday: Closed',
    services: [
      'High-Risk Pregnancy Care',
      'Advanced Gynecological Procedures',
      'Infertility Evaluation',
      'Endometriosis Treatment'
    ],
  ),
  Doctor(
    imageUrl: 'lib/assets/doctor_6.jpeg',
    name: 'Viki, MBBS',
    specialty: 'Gynecologist',
    rating: '4.4',
    patients: 60,
    about: 'Dr. Viki is dedicated to providing comprehensive women\'s health care with a focus on preventive medicine and education.',
    timing: 'Monday to Friday: 9:30 AM - 5:30 PM\nSaturday: 10:00 AM - 3:00 PM\nSunday: Closed',
    services: [
      'Well-Woman Exams',
      'Reproductive Health Education',
      'Menstrual Disorders Treatment',
      'Preventive Care Services'
    ],
  ),
];