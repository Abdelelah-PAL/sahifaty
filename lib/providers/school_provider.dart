import 'package:flutter/material.dart';
import 'package:sahifaty/services/school_services.dart';

import '../models/school.dart';

class SchoolProvider with ChangeNotifier {
  late School quickQuestionsSchool;
  bool isLoading = false;
  final SchoolServices _schoolServices = SchoolServices();

  Future<void> getQuickQuestionsSchool() async {
    setLoading();
    quickQuestionsSchool = await _schoolServices.getQuickQuestionsSchool();
    resetLoading();
  }

  void setLoading() {
    isLoading = true;
    notifyListeners();
  }

  void resetLoading() {
    isLoading = false;
    notifyListeners();
  }
}
