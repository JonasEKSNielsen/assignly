import 'package:assignly/classes/objects/egenskab.dart';
import 'dart:convert';

class Rolle {
  String? id, navn;
  List<Egenskab?> egenskaber = [];

  static Rolle getRolleFromJson(String response) {
    try {
      final data = jsonDecode(response);
      final results = data;

    } catch (_) {
    }
    return Rolle();
  }
}