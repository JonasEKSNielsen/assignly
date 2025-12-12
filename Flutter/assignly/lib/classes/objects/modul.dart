
import 'package:assignly/classes/objects/medarbejder.dart';
import 'dart:convert';

class Modul {
  String? id, medarbejderId;
  DateTime? start, end;
  Medarbejder? medarbejder;

  Modul({required this.id, required this.start, required this.end, this.medarbejderId, this.medarbejder});

  static Modul? getModulFromJson(String response) {
    try {
      final data = jsonDecode(response);
      final results = data;

    } catch (_) {
    }
    return null;
  }


    static Modul? getModulFromJsonMap(Map<String, dynamic> response) {
    try {
      return Modul(
        start: response['start'] != null ? DateTime.parse(response['start']) : null,
        end: response['end'] != null ? DateTime.parse(response['end']) : null,
        medarbejderId: response['medarbejderId'],
        medarbejder: response['medarbejder'] != null ? Medarbejder.getMedarbejderFromJson(jsonDecode(response['medarbejder'])) : null,
        id: response['id'],
      );
    } catch (_) {
    }
    return null;
  }
}