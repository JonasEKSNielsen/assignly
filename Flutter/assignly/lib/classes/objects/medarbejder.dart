import 'package:assignly/classes/objects/fravaer.dart';
import 'package:assignly/classes/objects/rolle.dart';
import 'dart:convert';

class Medarbejder {
  String? id,
      navn, 
      email, 
      password, 
      tlf, 
      farve;
  DateTime? arbejdsdagStart, arbejdsdagSlut;
  int? arbejdstimerOmUgen;
  List<Fravaer?> fravaer = [];
  List<Rolle?> roller = [];

  static Medarbejder getMedarbejderFromJson(String response) {
    try {
      final data = jsonDecode(response);
      final results = data;

    } catch (_) {
    }
    return Medarbejder();
  }
}