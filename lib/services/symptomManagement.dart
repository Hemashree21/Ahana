import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class SymptomManagementModel {
  final List<String> selectedSymptoms;

  SymptomManagementModel({required this.selectedSymptoms});

  // Predefined nutrition recommendations
  final Map<String, List<String>> nutritionRecommendations = {
    'Cramps': [
      'Magnesium-rich foods like spinach and almonds',
      'Omega-3 fatty acids from walnuts and chia seeds',
      'Herbal teas with ginger',
    ],
    'Mood Swings': [
      'Dark chocolate',
      'Foods rich in Vitamin D',
      'Complex carbohydrates',
    ],
    'Bloating': [
      'Hydrating foods',
      'Potassium-rich foods like bananas',
      'Herbal teas',
    ],
  };

  // AI-generated personalized plan
  Future<String> generatePersonalizedPlan() async {
    try {
      final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: 'YOUR_GEMINI_API_KEY', // Replace with your actual API key
      );

      final symptomString = selectedSymptoms.join(', ');

      final prompt = '''
      Create a personalized period management plan for someone experiencing: $symptomString
      
      Include:
      1. Dietary recommendations
      2. Lifestyle suggestions
      3. Stress management techniques
      4. Exercise recommendations
      
      Be specific and actionable.
      ''';

      final response = await model.generateContent([
        Content.text(prompt)
      ]);

      return response.text ?? 'Unable to generate personalized plan';
    } catch (e) {
      return 'Error generating plan: ${e.toString()}';
    }
  }

  // Recommended products based on symptoms
  List<Product> getRecommendedProducts() {
    return selectedSymptoms.expand((symptom) {
      switch (symptom) {
        case 'Cramps':
          return [
            Product(name: 'Heating Pad', price: 29.99),
            Product(name: 'Herbal Tea Blend', price: 15.50),
          ];
        case 'Mood Swings':
          return [
            Product(name: 'Mood Support Supplement', price: 24.99),
            Product(name: 'Stress Relief Candle', price: 18.99),
          ];
        case 'Bloating':
          return [
            Product(name: 'Digestive Support Drink', price: 22.99),
            Product(name: 'Compression Leggings', price: 45.00),
          ];
        default:
          return <Product>[];
      }
    }).toList();
  }
}

class Product {
  final String name;
  final double price;

  Product({required this.name, required this.price});
}