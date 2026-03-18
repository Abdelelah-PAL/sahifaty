import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationService extends Translations {
  static final locale = Locale('ar', 'AE');
  static final fallbackLocale = Locale('ar', 'AE');

  static final languages = ['Arabic', 'English'];
  static final locales = [
    const Locale('ar', 'AE'),
    const Locale('en', 'US'),
  ];

  // Static maps to hold loaded translations
  static Map<String, String> arKeys = {};
  static Map<String, String> enKeys = {};

  Future<void> init() async {
    final String arString = await rootBundle.loadString('assets/json/intl_ar.json');
    final String enString = await rootBundle.loadString('assets/json/intl_en.json');

    arKeys = Map<String, String>.from(json.decode(arString));
    enKeys = Map<String, String>.from(json.decode(enString));
  }

  @override
  Map<String, Map<String, String>> get keys {
    return {
      'ar': arKeys,
      'ar_AE': arKeys,
      'en': enKeys,
      'en_US': enKeys,
    };
  }

  Future<void> changeLocale(String lang) async {
    final locale = _getLocaleFromLanguage(lang);
    await Get.updateLocale(locale);
    await _saveLocale(lang);
  }

  Future<void> changeLocaleByCode(String code) async {
    final newLocale = Locale(code);
    await Get.updateLocale(newLocale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', code);
  }

  Locale _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < languages.length; i++) {
      if (lang == languages[i]) return locales[i];
    }
    return Get.locale!;
  }

  static Future<void> _saveLocale(String lang) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language', lang);
  }

  static Future<Locale> getCurrentLocale() async {
      final prefs = await SharedPreferences.getInstance();
      
      final langCode = prefs.getString('language_code');
      if (langCode != null && langCode.isNotEmpty) {
        return Locale(langCode);
      }

      final lang = prefs.getString('language') ?? 'Arabic';
      int index = languages.indexOf(lang);
      if(index == -1) return locale;
      return locales[index];
  }
}
