import 'package:flutter/material.dart';


class GeneralProvider with ChangeNotifier {
  Map<int, String> selectedValues = {}; // selected text for each index
  Map<int, Color> selectedColors = {};  // selected color for each index

  // Update selection
  void selectOption(int index, String value, Color color) {
    selectedValues[index] = value;
    selectedColors[index] = color;
    notifyListeners();
  }

  String? getSelectedValue(int index) => selectedValues[index];
  Color getSelectedColor(int index) =>
      selectedColors[index] ?? Colors.grey; // default color
}
