import 'package:flutter/material.dart';
import 'package:sahifaty/controllers/filter_types.dart';

class GeneralProvider with ChangeNotifier {
  static final GeneralProvider _instance = GeneralProvider._internal();

  factory GeneralProvider() => _instance;

  GeneralProvider._internal();

  int mainScreenView = 1;
  bool thirdsMenuItem = true;
  bool partsMenuItem = false;
  bool hizbsMenuItem = false;
  bool subjectsMenuItem = false;

  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme() {
    themeMode = themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleThirdsMenuItem() {
    if (!partsMenuItem && !hizbsMenuItem) return;
    thirdsMenuItem = !thirdsMenuItem;
    if (thirdsMenuItem) {
      mainScreenView = FilterTypes.thirds;
      partsMenuItem = false;
      hizbsMenuItem = false;
      subjectsMenuItem = false;
    }
    notifyListeners();
  }

  void togglePartsMenuItem() {
    partsMenuItem = !partsMenuItem;
    if (partsMenuItem) {
      mainScreenView = FilterTypes.parts;
      thirdsMenuItem = false;
      hizbsMenuItem = false;
      subjectsMenuItem = false;
    }
    notifyListeners();
  }

  void toggleHizbMenuItem() {
    hizbsMenuItem = !hizbsMenuItem;
    if (hizbsMenuItem) {
      mainScreenView = FilterTypes.hizbs;
      thirdsMenuItem = false;
      partsMenuItem = false;
      subjectsMenuItem = false;
    }
    print(hizbsMenuItem);
    print(subjectsMenuItem);
    notifyListeners();
  }

  void toggleSubjectMenuItem() {
    subjectsMenuItem = !subjectsMenuItem;
    if (subjectsMenuItem) {
      mainScreenView = FilterTypes.subjects;
      thirdsMenuItem = false;
      partsMenuItem = false;
      hizbsMenuItem = false;
    }
    notifyListeners();
  }
}
