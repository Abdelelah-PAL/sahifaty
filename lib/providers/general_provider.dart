import 'package:flutter/material.dart';

class GeneralProvider with ChangeNotifier {
  static final GeneralProvider _instance = GeneralProvider._internal();

  factory GeneralProvider() => _instance;

  GeneralProvider._internal();


  int mainScreenView = 1;
  bool thirdsMenuItem = true;
  bool partsMenuItem = false;
  bool assessmentMenuItem = false;


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
