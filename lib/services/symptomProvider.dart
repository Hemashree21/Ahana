import 'package:ahana/services/symptomManagement.dart';
import 'package:flutter/cupertino.dart';

class SymptomProvider extends ChangeNotifier {
  List<String> _selectedSymptoms = [];
  String _personalizedPlan = '';

  List<String> get selectedSymptoms => _selectedSymptoms;
  String get personalizedPlan => _personalizedPlan;

  void toggleSymptom(String symptom) {
    if (_selectedSymptoms.contains(symptom)) {
      _selectedSymptoms.remove(symptom);
    } else {
      _selectedSymptoms.add(symptom);
    }
    notifyListeners();
  }

  Future<void> generatePlan() async {
    final model = SymptomManagementModel(selectedSymptoms: _selectedSymptoms);
    _personalizedPlan = await model.generatePersonalizedPlan();
    notifyListeners();
  }
}