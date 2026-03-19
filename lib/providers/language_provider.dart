import 'package:flutter/material.dart';
import '../services/languages_services.dart';

class LanguageProvider with ChangeNotifier {
  String langCode = 'ar';
  
  List<dynamic> languages = [
    {"code": "ar", "name": "العربية"},
    {"code": "en", "name": "English"}
  ];
  
  bool isLoadingLanguages = false;
  final LanguageServices _services = LanguageServices();

  void setLangCode(String code) {
    langCode = code;
    notifyListeners();
  }

  Future<void> fetchLanguages() async {
    isLoadingLanguages = true;
    notifyListeners();

    final fetched = await _services.fetchLanguages();
    if (fetched != null) {
      languages = fetched;
    }
    
    isLoadingLanguages = false;
    notifyListeners();
  }
}
