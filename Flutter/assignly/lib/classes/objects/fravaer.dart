import 'package:assignly/classes/objects/medarbejder.dart';

class Fravaer {
  String? id, medarbejderId;
  DateTime? start, end;
  Medarbejder? medarbejder;

  Fravaer({required this.id, required this.start, required this.end, this.medarbejderId, this.medarbejder});

  static Fravaer? getFravaerFromJsonMap(Map<String, dynamic> response) {
    try {
      return Fravaer(
        id: response['id'],
        start: response['start'] != null ? DateTime.parse(response['start']) : null,
        end: response['end'] != null ? DateTime.parse(response['end']) : null,
        medarbejderId: response['medarbejderId'],
      );
    } catch (_) {
    }
    return null;
  }
}