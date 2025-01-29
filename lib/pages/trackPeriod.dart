import 'package:ahana/components/periodCalendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PeriodTrackerPage extends StatefulWidget {
  const PeriodTrackerPage({super.key});

  @override
  _PeriodTrackerPageState createState() => _PeriodTrackerPageState();
}

class _PeriodTrackerPageState extends State<PeriodTrackerPage> {
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Period Tracker',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Color(0xFF630A00),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat.yMMMM().format(focusedDay), // This will display the correct month and year
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
            _buildSuggestedYogasanas(),
            const SizedBox(height: 16),
            _buildSuggestedHomeFoods(),
          ],
        ),
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
              _buildYogaCard(
                title: 'Balasana',
                subtitle: "(Child's Pose)",
                description: "Relieves lower back pain and calms the mind.",
                image: 'lib/assets/exercise1.jpg',
              ),
              _buildYogaCard(
                title: 'Marjaryasana-Bitilasana',
                subtitle: 'Cat-Cow Pose',
                description: 'Eases cramps and stretches the spine.',
                image: 'lib/assets/exercise2.webp',
              ),
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
                              if (title == "Marjaryasana-Bitilasana") ...[
                                Text(
                                  "How to Do It:",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color : Color(0xFF031E3A)),
                                ),
                                Text(
                                  "Begin on your hands and knees in a tabletop position. Inhale, arch your back, and lift your head and tailbone (Cow Pose). Exhale, round your spine, tuck your chin, and draw your belly in (Cat Pose). Repeat slowly, flowing with your breath.",
                                  style: TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Benefits:",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color : Color(0xFF031E3A)),
                                ),
                                Text(
                                  "This pose helps relieve lower back pain, stretches the spine, and improves flexibility. It is especially useful for relieving menstrual discomfort and stress.",
                                  style: TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                              ]
                              else if (title == "Balasana") ...[
                                Text(
                                  "How to Do It:",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color : Color(0xFF031E3A)),
                                ),
                                Text(
                                  "Kneel on the mat, bring your big toes together, and sit back on your heels. Extend your arms forward and lower your chest toward the floor. Rest your forehead down and breathe deeply.",
                                  style: TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Benefits:",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color : Color(0xFF031E3A)),
                                ),
                                Text(
                                  "Child's Pose helps to relieve lower back pain, calm the nervous system, and ease menstrual cramps by gently stretching the hips, thighs, and lower back.",
                                  style: TextStyle(fontSize: 14, color: Colors.black87),
                                ),
                              ],
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
                'According to your lifestyle habits, here are some of the home foods you can try out!',
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
                      'lib/assets/RagiLadoo.png',
                      height: 119,
                      width: 92.33,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ragi Laddoo',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF031E3A),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Enriched with fiber, protein, calcium, and phosphorus, these laddus promote digestion, weight loss, bone strength, and blood sugar regulation. Elevate your health with this delicious choice!',
                          style: TextStyle(
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
                  onPressed: () {Navigator.pushNamed(context, '/shopping');},
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