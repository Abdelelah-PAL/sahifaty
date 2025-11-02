import 'dart:core';
import 'package:sahifaty/models/school.dart';
import 'package:sahifaty/services/sahifaty_api.dart';

class SchoolServices {
  final SahifatyApi _sahifatyApi = SahifatyApi();

 Future<School> getQuickQuestionsSchool() async {
   try {
     var res = await _sahifatyApi.get('schools/1');
     if(res != null) {
       return School.fromJson(res);
     }
     else {
       return res;
     }
   } catch (ex) {
     rethrow;
   }
 }
}