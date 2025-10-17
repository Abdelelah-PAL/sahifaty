import 'package:flutter/material.dart';

class GeneralProvider with ChangeNotifier {
  static final GeneralProvider _instance = GeneralProvider._internal();

  factory GeneralProvider() => _instance;

  GeneralProvider._internal();

  Map<int, String> selectedValues = {};
  Map<int, Color> selectedColors = {};
  int mainScreenView = 1;
  bool thirdsMenuItem = true;
  bool partsMenuItem = false;
  bool assessmentMenuItem = false;

  void selectOption(int index, String value, Color color) {
    selectedValues[index] = value;
    selectedColors[index] = color;
    notifyListeners();
  }

  String? getSelectedValue(int index) => selectedValues[index];

  Color getSelectedColor(int index) => selectedColors[index] ?? Colors.grey;

  void toggleThirdsMenuItem() {
    if (!partsMenuItem && !assessmentMenuItem) return;
    thirdsMenuItem = !thirdsMenuItem;
    if (thirdsMenuItem) {
      mainScreenView = 1;
      partsMenuItem = false;
      assessmentMenuItem = false;
    }
    notifyListeners();
  }

  void togglePartsMenuItem() {
    partsMenuItem = !partsMenuItem;
    if (partsMenuItem) {
      mainScreenView = 2;
      thirdsMenuItem = false;
      assessmentMenuItem = false;
    }
    notifyListeners();
  }

  void toggleAssessmentMenuItem() {
    assessmentMenuItem = !assessmentMenuItem;
    if (assessmentMenuItem) {
      mainScreenView = 3;
      thirdsMenuItem = false;
      partsMenuItem = false;
    }
    notifyListeners();
  }
}
