import 'package:assignly/classes/objects/medarbejder.dart';
import 'dart:convert';

class Fravaer {
  String? id, medarbejderId;
  DateTime? start, end;
  Medarbejder? medarbejder;

  static Fravaer getFravaerFromJson(String response) {
    try {
      final data = jsonDecode(response);
      final results = data;

    } catch (_) {
    }
    return Fravaer();
  }
}