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
    thirdsMenuItem = !thirdsMenuItem;
    if (thirdsMenuItem) {
      mainScreenView = FilterTypes.thirds;
      partsMenuItem = false;
      hizbsMenuItem = false;
      subjectsMenuItem = false;
    } else {
      // If turned off, fallback to something else if nothing is active
      if (!partsMenuItem && !hizbsMenuItem && !subjectsMenuItem) {
        // Default to thirds if everything is off? Or keep it off?
        // Let's fallback to Parts if we turned off Thirds, just to keep a view active
        partsMenuItem = true;
        mainScreenView = FilterTypes.parts;
      }
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
    } else {
      if (!thirdsMenuItem && !hizbsMenuItem && !subjectsMenuItem) {
        thirdsMenuItem = true;
        mainScreenView = FilterTypes.thirds;
      }
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
    } else {
      if (!thirdsMenuItem && !partsMenuItem && !subjectsMenuItem) {
        thirdsMenuItem = true;
        mainScreenView = FilterTypes.thirds;
      }
    }
    notifyListeners();
  }

  void toggleSubjectMenuItem() {
    subjectsMenuItem = !subjectsMenuItem;
    if (subjectsMenuItem) {
      mainScreenView = FilterTypes.subjects;
      thirdsMenuItem = false;
      partsMenuItem = false;
      hizbsMenuItem = false;
    } else {
      if (!thirdsMenuItem && !partsMenuItem && !hizbsMenuItem) {
        thirdsMenuItem = true;
        mainScreenView = FilterTypes.thirds;
      }
    }
    notifyListeners();
  }
}
