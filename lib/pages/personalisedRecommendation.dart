import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Recommendation extends StatefulWidget {
  final String selectedSymptom;
  const Recommendation({Key? key, required this.selectedSymptom}) : super(key: key);

  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  Map<String, String> recommendations = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    generateRecommendations();
  }

  Future<void> generateRecommendations() async {
    try {
      final apiKey = dotenv.env['GEMINI_API_KEY'];
      if (apiKey == null) throw Exception('GEMINI_API_KEY not found in .env');

      final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: apiKey,
      );

      final sections = {
        'Yoga': '''Create a focused yoga and exercise plan for ${widget.selectedSymptom} during menstruation.
                Include 4-5 specific poses with their benefits.
                Format each pose as: [Pose Name] - [Brief benefit description]
                Focus on gentle, effective movements.''',

        'Nutrition': '''List specific dietary recommendations for managing ${widget.selectedSymptom}.
                Include:
                - Key nutrients and their food sources
                - Foods to avoid
                - Meal timing tips
                Format as clear paragraphs with subheadings.''',

        'Lifestyle': '''Provide practical lifestyle adjustments for ${widget.selectedSymptom}.
                Include daily routine changes, sleep tips, and stress management.
                Format as actionable bullet points.''',

        'Remedies': '''Suggest natural remedies for ${widget.selectedSymptom}.
                Include herbs and essential oils.
                Provide brief preparation instructions.''',

        'Self-Care': '''Outline daily self-care practices for ${widget.selectedSymptom}.
                Include morning and evening routines.
                Focus on emotional and physical wellness.'''
      };

      for (var entry in sections.entries) {
        final response = await model.generateContent([Content.text(entry.value)]);
        recommendations[entry.key] = response.text ?? 'Unable to generate recommendations';
      }

      setState(() => isLoading = false);
    } catch (e) {
      setState(() {
        recommendations = {};
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Wellness Plan for ${widget.selectedSymptom}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF630A00),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: isLoading
                    ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Color(0xFF630A00)),
                      SizedBox(height: 16),
                      Text('Creating your personalized plan...')
                    ],
                  ),
                )
                    : ListView.builder(
                  itemCount: recommendations.length,
                  itemBuilder: (context, index) {
                    String section = recommendations.keys.elementAt(index);
                    String content = recommendations[section] ?? '';

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              section,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF630A00),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              content,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Color(0xFF031E3A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}