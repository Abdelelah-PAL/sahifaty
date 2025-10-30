import 'dart:convert';
import 'dart:core';

import 'package:sahifaty/services/sahifaty_api.dart';

class QuickQuestionsServices {
  final SahifatyApi _sahifatyApi = SahifatyApi();

  // Future<Category?> getAllCategories() async {
  //   try {
  //     var res = await _sahifatyApi.get('auth/categories');
  //     if(res != null) {
  //       return Category.fromJson(res);
  //     }
  //     else {
  //       return res;
  //     }
  //   } catch (ex) {
  //     rethrow;
  //   }
  // }
}