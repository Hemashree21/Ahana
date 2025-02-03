import 'package:ahana/components/periodCalendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PeriodTrackerPage extends StatefulWidget {
  const PeriodTrackerPage({super.key});

  @override
  _PeriodTrackerPageState createState() => _PeriodTrackerPageState();
}

class _PeriodTrackerPageState extends State<PeriodTrackerPage> {
  bool isExpanded = false;
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  int selectedCategory = 0; // Track selected category

  // Define category data
  final List<Map<String, dynamic>> categories = [
    {
      'icon': 'lib/assets/cramp.jpg',
      'name': 'cramps',
      'yogasanas': [
        {
          'title': 'Apanasana',
          'subtitle': "(Knees to Chest Pose)",
          'description': "Helps reduce stress, anxiety, and lower back pain.",
          'image': 'lib/assets/apanasana.jpeg',
          'instructions': "Kneel on the mat, bring your big toes together, and gently draw your knees toward your chest. Hold for a few breaths, then release.",
          'benefits': "Apanasana stretches the lower back and pelvis, which helps reduce lower back pain. It also calms the mind and reduces stress and anxiety.",
        },
        {
          'title': 'Setu Bandhasana',
          'subtitle': 'Bridge Pose',
          'description': 'Relieves back and pelvic discomfort.',
          'image': 'lib/assets/sethubandhasana.jpg',
          'instructions': "Lie flat on your back with your knees bent and feet flat on the floor, hip-width apart. Press your feet into the mat and lift your hips up, creating a bridge shape with your body. Keep your arms flat on the ground by your sides or clasp your hands under your back. Hold the pose and breathe deeply.",
          'benefits': "This pose helps relieve back and pelvic discomfort, opens up the chest, and promotes relaxation."
        }
      ],
      'foods': {
        'title': 'Herbal Drink',
        'description': 'This herbal drink with Ajwain, Ginger, Tulsi, and Jeera helps relieve cramps, improve digestion, and reduce bloating. It is packed with fiber, protein, calcium, and phosphorus for overall wellness.',
        'image': 'lib/assets/Herbaldrink.jpg'
      }
    },
    {
      'icon': 'lib/assets/acne.jpg',
      'name': 'acne',
      'yogasanas': [
        {
          'title': 'Pranayama',
          'subtitle': 'Breathing Techniques',
          'description': 'Deep breathing helps reduce stress and balance hormones.',
          'image': 'lib/assets/pranayama.jpg',
          'instructions': 'Sit in a comfortable position, close your eyes, and practice deep, slow breathing. For Nadi Shodhana, alternate nostril breathing, close one nostril and inhale through the other, then switch.',
          'benefits': 'Helps reduce stress and anxiety, balance hormones, and calm the mind, which can reduce acne.'
        },
        {
          'title': 'Bhujangasana',
          'subtitle': '(Cobra Pose)',
          'description': 'Stimulates the adrenal glands and improves circulation.',
          'image': 'lib/assets/bhujangasana.jpeg',
          'instructions': "Lie flat on your stomach, place your palms on the floor under your shoulders, and lift your chest upward while keeping your elbows slightly bent.",
          'benefits': "Stimulates the adrenal glands, which help regulate hormones. Reduces stress and improves circulation."
        }
        ,
      ],
      'foods':{
        'title': 'Nellikai Rasayana',
        'description': 'A healthy mix of Amla and Jaggery, known for its detoxifying and immunity-boosting properties.',
        'image': 'lib/assets/amla.jpg',
      }
    },
    {
      'icon': 'lib/assets/insomia.jpg',
      'name': 'insomia',
      'yogasanas': [
        {
          "title": "Savasana",
          "subtitle": "(Corpse Pose)",
          "description": "A deeply relaxing pose that promotes a restful mind.",
          "image": "lib/assets/Savasana.jpg",
          "instructions": "Lie flat on your back with your legs extended and arms relaxed by your sides. Close your eyes and focus on your breath, allowing your body to completely relax.",
          "benefits": "Helps reduce stress, promotes relaxation, and calms the nervous system, aiding in better sleep."
        }
        ,
        {
          "title": "Viparita Karani",
          "subtitle": "(Legs-Up-the-Wall Pose)",
          "description": "A gentle inversion that helps relax the body and calm the mind.",
          "image": "lib/assets/ViparitaKarani.jpg",
          "instructions": "Sit close to a wall and lie on your back. Swing your legs up against the wall, keeping your arms relaxed by your sides. Focus on your breath and allow your body to relax.",
          "benefits": "Improves circulation, reduces stress, and calms the nervous system, promoting restful sleep."
        },
      ],
      'foods': {
        "title": "Sheer Pak (Nutmeg & Warm Milk Tonic)",
        "description": "A soothing drink that promotes relaxation and enhances sleep. Nutmeg is known for its calming properties, while warm milk helps in reducing stress and anxiety.",
        "image": "lib/assets/sheek_pak.webp"
      }

    },
    {
      'icon': 'lib/assets/headache.jpg',
      'name': 'Headache',
      'yogasanas': [
        {
          "title": "Balasana",
          "subtitle": "(Child’s Pose)",
          "description": "Relieves tension and promotes relaxation.",
          "image": "lib/assets/Balasana.png",
          "instructions": "Kneel on the floor and sit back on your heels. Lower your torso to the ground, extending your arms forward and forehead to the mat.",
          "benefits": "Relaxes the nervous system, reduces stress-related headaches, increases blood circulation to the brain, and eases neck stiffness—common headache triggers."
        }
        ,{
          'title': 'Sukhasana',
          'subtitle': '(Easy Pose with Pranayama)',
          'description': 'A seated posture combined with deep breathing exercises.',
          'image': 'lib/assets/sukhasana.avif',
          'instructions': "Sit with your legs crossed in a comfortable position, keeping your spine straight. Place your hands on your knees, and close your eyes. Begin deep breathing exercises, inhaling deeply through your nose and exhaling through your mouth.",
          'benefits': "Helps reduce stress and anxiety, balancing the body and mind, which can prevent or alleviate tension headaches. The deep breathing techniques increase oxygen flow, calm the nervous system, and promote mental clarity."
        }
        ,
      ],
      'foods': {
        'title': 'Coriander & Dry Ginger Kashaya',
        'description': 'A warming herbal drink made with coriander and dry ginger, known for its digestive and anti-inflammatory benefits.',
        'image': 'lib/assets/ginger_juice.jpg'
      }
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Period Manager',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: Color(0xFF630A00),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat.yMMMM().format(focusedDay),
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF031E3A),
              ),
            ),
            const SizedBox(height: 16),
            const PeriodCalendar(),
            const SizedBox(height: 16),
            _buildMessageCard(),
            const SizedBox(height: 16),
            _buildCategoryCircles(),
            const SizedBox(height: 16),
            _buildSuggestedYogasanas(),
            const SizedBox(height: 16),
            _buildSuggestedHomeFoods(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCircles() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = index;
                });
              },
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300), // Animation duration
                    curve: Curves.easeInOut, // Animation curve
                    width: selectedCategory == index ? 70 : 60, // Grows when selected
                    height: selectedCategory == index ? 70 : 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedCategory == index
                            ? const Color(0xFF630A00)
                            : Colors.transparent,
                        width: selectedCategory == index ? 3 : 2,
                      ),
                      boxShadow: selectedCategory == index
                          ? [
                        BoxShadow(
                          color: const Color(0xFF630A00).withOpacity(0.3),
                          blurRadius: 8,
                          spreadRadius: 2,
                        )
                      ]
                          : [],
                    ),
                    child: TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 300),
                      tween: Tween<double>(
                        begin: 1.0,
                        end: selectedCategory == index ? 1.1 : 1.0,
                      ),
                      builder: (context, double scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: ClipOval(
                        child: Image.asset(
                          categories[index]['icon'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: selectedCategory == index ? 14 : 12,
                      fontWeight: selectedCategory == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: selectedCategory == index
                          ? const Color(0xFF630A00)
                          : Colors.grey,
                    ),
                    child: Text(categories[index]['name']),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildSimpleDate(
      String date,
      String day, {
        bool isHighlighted = false,
        bool isPeriodDay = false,
        bool isDroplet = false,
        Color? color,  // Add a color parameter here
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
            color: color ?? // Use passed color, or fallback to default color
                (isHighlighted
                    ? const Color(0xFFE7A49C)
                    : isPeriodDay
                    ? const Color(0xFF630A00)
                    : null),
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
                color: isPeriodDay ? Colors.white : Colors.brown[800],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE7A49C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        "It looks like your period might be starting in a few days."
            "Take care of yourself, and if you need any tips or support"
            "to feel more comfortable, I'm here for you! 💕",
        style: TextStyle(fontSize: 16, color: Color(0xFF630A00)),
      ),
    );
  }

  Widget _buildSuggestedYogasanas() {
    final yogasanas = categories[selectedCategory]['yogasanas'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Suggested Yogasanas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF031E3A),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF630A00)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Yoga during your period can be incredibly beneficial for easing cramps, reducing stress, and promoting relaxation.',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF031E3A),
                  ),
                ),
              ),
              ...yogasanas.map((yoga) => _buildYogaCard(
                title: yoga['title'],
                subtitle: yoga['subtitle'],
                description: yoga['description'],
                image: yoga['image'],
              )).toList(),
            ],
          ),
        ),
      ],
    );
  }



  Widget _buildYogaCard({
    required String title,
    required String subtitle,
    required String description,
    required String image,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                              child: Image.asset(image, fit: BoxFit.cover),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.black),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF031E3A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                subtitle,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF031E3A),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                description,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xFF031E3A),
                                ),
                              ),
                              const SizedBox(height: 12),
                              if (title == "Sukhasana") ...[
                                Text(
                                  "How to Do It:",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                ),
                                Text(
                                  "Sit on the floor with your legs crossed and your feet under your knees. Keep your spine straight and your shoulders relaxed. Place your hands on your knees, palms facing up or down. Focus on your breath, and stay in the pose for a few minutes to calm your mind and body.",
                                  style: TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Benefits:",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                ),
                                Text(
                                  "Sukhasana helps relieve tension and stress, which can be a common cause of headaches. It promotes relaxation and improves circulation, which can help reduce the frequency and severity of headaches.",
                                  style: TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                              ]
                              else if (title == "Balasana") ...[
                                Text(
                                  "How to Do It:",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                ),
                                Text(
                                  "Kneel on the mat, bring your big toes together, and sit back on your heels. Extend your arms forward and lower your chest toward the floor. Rest your forehead down and breathe deeply.",
                                  style: TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Benefits:",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                ),
                                Text(
                                  "Child's Pose helps to relieve lower back pain, calm the nervous system, and ease menstrual cramps by gently stretching the hips, thighs, and lower back.",
                                  style: TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                              ]
                              else if (title == "Apanasana") ...[
                                  Text(
                                    "How to Do It:",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                  ),
                                  Text(
                                    "Lie on your back and hug your knees to your chest. Keep your head and neck relaxed. Breathe deeply and gently rock your body side to side to massage the lower back.",
                                    style: TextStyle(fontSize: 14, color: Colors.black87),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "Benefits:",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                  ),
                                  Text(
                                    "Apanasana is great for relieving menstrual cramps by relaxing the lower back and abdomen, helping to reduce discomfort.",
                                    style: TextStyle(fontSize: 14, color: Colors.black87),
                                  ),
                                ]
                                else if (title == "Setu Bandhasana") ...[
                                    Text(
                                      "How to Do It:",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                    ),
                                    Text(
                                      "Lie on your back with your knees bent and feet flat on the floor. Press your feet into the floor and lift your hips towards the ceiling, keeping your arms by your sides.",
                                      style: TextStyle(fontSize: 14, color: Colors.black87),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Benefits:",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                    ),
                                    Text(
                                      "Setu Bhandasana helps alleviate cramps and discomfort by opening the hips and stretching the abdominal muscles.",
                                      style: TextStyle(fontSize: 14, color: Colors.black87),
                                    ),
                                  ]
                                  else if (title == "Pranayama") ...[
                                      Text(
                                        "How to Do It:",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                      ),
                                      Text(
                                        "Sit comfortably, close your eyes, and inhale deeply through your nose. Hold the breath for a moment and exhale slowly. Focus on your breath and repeat for a few minutes.",
                                        style: TextStyle(fontSize: 14, color: Colors.black87),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Benefits:",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                      ),
                                      Text(
                                        "Pranayama helps to clear acne by reducing stress and increasing blood circulation, promoting a healthier complexion.",
                                        style: TextStyle(fontSize: 14, color: Colors.black87),
                                      ),
                                    ]
                                    else if (title == "Bhujangasana") ...[
                                        Text(
                                          "How to Do It:",
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                        ),
                                        Text(
                                          "Lie face down on the floor with your hands under your shoulders. Press into your palms as you lift your chest off the floor, extending your back.",
                                          style: TextStyle(fontSize: 14, color: Colors.black87),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          "Benefits:",
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                        ),
                                        Text(
                                          "Bhujangasana helps to clear acne by stimulating blood flow to the skin and improving the health of your skin.",
                                          style: TextStyle(fontSize: 14, color: Colors.black87),
                                        ),
                                      ]
                                      else if (title == "Savasana") ...[
                                          Text(
                                            "How to Do It:",
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                          ),
                                          Text(
                                            "Lie flat on your back with your arms by your sides and your legs extended. Close your eyes, relax, and focus on your breath. Stay in the pose for several minutes.",
                                            style: TextStyle(fontSize: 14, color: Colors.black87),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "Benefits:",
                                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                          ),
                                          Text(
                                            "Savasana helps reduce stress and anxiety, making it an effective remedy for insomnia.",
                                            style: TextStyle(fontSize: 14, color: Colors.black87),
                                          ),
                                        ]
                                        else if (title == "Viparita Karani") ...[
                                            Text(
                                              "How to Do It:",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                            ),
                                            Text(
                                              "Lie on your back with your legs up the wall. Keep your arms by your sides and breathe deeply.",
                                              style: TextStyle(fontSize: 14, color: Colors.black87),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Benefits:",
                                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF031E3A)),
                                            ),
                                            Text(
                                              "Viparita Karani is great for improving circulation and calming the nervous system, which can help with insomnia.",
                                              style: TextStyle(fontSize: 14, color: Colors.black87),
                                            ),
                                          ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    image,
                    height: 60,
                    width: 129.07,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF031E3A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF031E3A),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: Color(0xFF031E3A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestedHomeFoods() {
    final food = categories[selectedCategory]['foods'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Suggested HomeFoods',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF031E3A),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFF630A00)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'According to your symptoms, here are some of the home foods you can try out!',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF031E3A),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      food['image'],
                      height: 119,
                      width: 92.33,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food['title'],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF031E3A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          food['description'],
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF031E3A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF630A00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    minimumSize: const Size(215, 33),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/shopping');
                  },
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}