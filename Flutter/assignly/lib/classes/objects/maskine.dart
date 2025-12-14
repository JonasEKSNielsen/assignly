import 'package:assignly/classes/objects/egenskab.dart';
import 'package:assignly/classes/objects/hverdag.dart';
import 'package:assignly/classes/objects/modul.dart';
import 'package:assignly/classes/objects/nedetid.dart';
import 'dart:convert';

class Maskine {
  String? id, egenskabId, navn;
  Egenskab? egenskab;
  List<Modul> moduler;
  List<Nedetid> nedetider;

  Maskine({required this.id, required this.egenskabId, required this.navn, this.egenskab, this.moduler = const [], this.nedetider = const []});

  static List<Maskine> getMaskineFromJson(String response) {
    try {
      final result = jsonDecode(response);
      List<Maskine> maskiner = [];

      if (result != null) {
        if (result is List && result.isNotEmpty) {
          for (var element in result) {
            // Get egenskab
            Maskine? newMaskine = getMaskineFromJsonMap(element);

            if (newMaskine != null) {
              // Add to list
              maskiner.add(newMaskine);
            }
          }
        } else if (!result is List) {
          // Single object
          maskiner.add(Maskine(
            id: result['id'],
            egenskabId: result['egenskabId'],
            navn: result['navn'],
          ));
        }
      }
      return maskiner;

    } catch (_) {}
    return [];
  }

  static Maskine? getMaskineFromJsonMap(element) {
    Egenskab egenskab = Egenskab(
      titel: element['egenskab']['titel'],
      id: element['egenskab']['id'],
    );
    
    // Get moduler
    List<Modul> moduler = [];
    var modulJson = element['moduler']; 
    if (modulJson != null) {
      if (modulJson is List && modulJson.isNotEmpty) {
        for (var modul in modulJson) {
          Modul? newModul = Modul.getModulFromJsonMap(modul);
          if (newModul != null) {
            moduler.add(newModul);
          }
        }
      } else if (modulJson is! List) {
        Modul? newModul = Modul.getModulFromJsonMap(modulJson);
        if (newModul != null) {
          moduler.add(newModul);
        }
      }
    }
    
    // Get nedetider
    List<Nedetid> nedetider = [];
    var nedetidJson = element['nedetider'];
    if (nedetidJson != null && nedetidJson is List && nedetidJson.isNotEmpty) {
      for (var nedetid in nedetidJson) {
        Nedetid newNedetid = Nedetid(
          dag: nedetid['dag'] != null ? HverdagExtension.fromInt(nedetid['dag']) : null,
          tidspunkt: nedetid['tidspunkt'],
          gentagende: nedetid['gentagende'],
          start: nedetid['start'] != null ? DateTime.parse(nedetid['start']) : null,
          end: nedetid['end'] != null ? DateTime.parse(nedetid['end']) : null,
          id: nedetid['id'],
        );
        nedetider.add(newNedetid);
      }
    }
    
    // Create Maskine
    Maskine newMaskine = Maskine(
      id: element['id'],
      navn: element['navn'],
      egenskabId: element['egenskabId'],
      egenskab: egenskab,
      moduler: moduler,
      nedetider: nedetider,
    );

    return newMaskine;
  }
}