
import 'dart:convert';
import 'package:assignly/classes/objects/maskine.dart';
import 'package:assignly/classes/objects/medarbejder.dart';

class Modul {
  String? id, medarbejderId, maskineId;
  DateTime? start, end;
  Medarbejder? medarbejder;
  Maskine? maskine;

  Modul({this.id, required this.start, required this.end, this.medarbejderId, this.medarbejder, this.maskineId, this.maskine});

  static List<Modul> getModulFromJson(String response) {
    try {
      List<Modul> moduler = [];
      
      final result = jsonDecode(response);
      if (result != null) {
        if (result is List && result.isNotEmpty) {
          for (var element in result) {
            Modul? newModul = getModulFromJsonMap(element);
            if (newModul != null) {
              moduler.add(newModul);
            }
          }
          return moduler;
        } else if (result is Map<String, dynamic>) {
          Modul? newModul = getModulFromJsonMap(result);
          if (newModul != null) {
            moduler.add(newModul);
            return moduler;
          } else {
            return [];
          }
        }
      }
    } catch (_) {}

    return [];
  }


  static Modul? getModulFromJsonMap(Map<String, dynamic> response) {
    try {
      return Modul(
        start: response['start'] != null ? DateTime.parse(response['start']) : null,
        end: response['end'] != null ? DateTime.parse(response['end']) : null,
        medarbejderId: response['medarbejderId'],
        medarbejder: response['medarbejder'] != null ? Medarbejder.getMedarbejderFromJsonMap(response['medarbejder']) : null,
        maskineId: response['maskineId'],
        maskine: response['maskine'] != null ? Maskine.getMaskineFromJsonMap(response['maskine']) : null,
        id: response['id'],
      );
    } catch (_) {
    }
    return null;
  }
}