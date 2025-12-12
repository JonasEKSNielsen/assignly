// ignore_for_file: constant_identifier_names
import 'dart:convert';

enum Hverdag {
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
  Sunday
}

class Nedetid {
  String? id;
  Hverdag? dag;
  // TIMEONLY FORMAT HH:MM
  String? tidspunkt;
  bool? gentagende;
  DateTime? start;
  DateTime? end;

  static Nedetid getNedetidFromJson(String response) {
    try {
      final data = jsonDecode(response);
      final results = data;

    } catch (_) {
    }
    return Nedetid();
  }
}
