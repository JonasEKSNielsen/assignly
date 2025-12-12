import 'package:assignly/classes/objects/egenskab.dart';

class Rolle {
  String? id, navn;
  List<Egenskab?> egenskaber = [];

  Rolle({required this.id, required this.navn, this.egenskaber = const []});

  static Rolle? getRolleFromJsonMap(Map<String, dynamic> response) {
    try {
      List<Egenskab?> egenskaber = [];
      var egenskabJson = response['egenskaber'];
      if (egenskabJson != null && egenskabJson is List && egenskabJson.isNotEmpty) {

        for (var egenskabElement in egenskabJson) {
          Egenskab? egenskab = Egenskab.getEgenskabFromJsonMap(egenskabElement);
          if (egenskab != null) {
            egenskaber.add(egenskab);
          }
        }
      }

      return Rolle(
        id: response['id'],
        navn: response['navn'],
        egenskaber: egenskaber,
      );
    } catch (_) {}
    return null;
  }
}