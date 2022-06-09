import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetry/core/models/student_model.dart';
import 'package:firebasetry/core/models/user_request.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  static const String FIREBASE_AUTH_URL =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=AIzaSyDPFq-Fdov_FDfoIpKOIeAWEZnAbytA-Cc";
  static const String FirebaseUser =
      'https://firabase-try-f02d5-default-rtdb.firebaseio.com/user.json';
  static const String FIRABASE_URL =
      'https://firabase-try-f02d5-default-rtdb.firebaseio.com/student/-MzREr7tW7MdNKwsvOLO.json';
  Future<List<Student>?> getStudent() async {
    final response = await http.get(Uri.parse(FIRABASE_URL));
    if (response.statusCode == HttpStatus.ok) {
      try {
        List<dynamic> jsonModel = jsonDecode(response.body);

        List<Student> students = jsonModel
            .map(
              (e) => Student.fromJson(e),
            )
            .toList();

        return students;
      } catch (e) {
        /* throw Exception('${response.statusCode} hata $e'); */
      }
    } else {
      return [];
    }
  }

//Tek bir Student nesnesi çekmek istiyorsak böyle yapabiliriz
  Future<Student> getStu() async {
    late Student student;
    final response = await http.get(Uri.parse(FirebaseUser));
    final jsonModel = jsonDecode(response.body) as Map;
    jsonModel.forEach(
      (key, value) {
        student = Student.fromJson(value);
      },
    );
    return student;
  }

  Future<bool> postUSer(UserRequest request) async {
    //isteğimi tojson metoduyla jsona çevirdi daha sonra daha sonra bunu encode ile birleştirdik ve post kısmında body e bunu yerleştirdik
    var jsonModel = jsonEncode(request.toJson());
    final response =
        await http.post(Uri.parse(FIREBASE_AUTH_URL), body: jsonModel);
    try {
      if (response == HttpStatus.ok) {
        print('evet');
        return true;
      } else {
        print('hayır');
        return false;
      }
    } catch (e) {
      throw Exception('${response.statusCode} ve hata $e');
    }
  }

  Future<void> post2User(UserRequest request) async {
    var jsonModel = jsonEncode(request.toJson());
    final response =
        await http.post(Uri.parse(FIREBASE_AUTH_URL), body: jsonModel);
  }
}
