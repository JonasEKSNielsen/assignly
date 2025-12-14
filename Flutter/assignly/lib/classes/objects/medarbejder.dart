import 'dart:convert';

import 'package:assignly/classes/objects/fravaer.dart';
import 'package:assignly/classes/objects/rolle.dart';

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

  Medarbejder({
    required this.id,
    required this.navn,
    required this.email,
    required this.password,
    this.tlf,
    this.farve,
    this.arbejdsdagStart,
    this.arbejdsdagSlut,
    this.arbejdstimerOmUgen,
    this.fravaer = const [],
    this.roller = const [],
  });

  static List<Medarbejder> getMedarbejderFromJson(String response) {
    try {
      List<Medarbejder> medarbejdere = [];
      
      final result = jsonDecode(response);
      if (result != null) {
        if (result is List && result.isNotEmpty) {
          for (var element in result) {
            Medarbejder? newMedarbejder = getMedarbejderFromJsonMap(element);
            if (newMedarbejder != null) {
              medarbejdere.add(newMedarbejder);
            }
          }
          return medarbejdere;
        } else if (result is Map<String, dynamic>) {
          Medarbejder? newMedarbejder = getMedarbejderFromJsonMap(result);
          if (newMedarbejder != null) {
            medarbejdere.add(newMedarbejder);
            return medarbejdere;
          } else {
            return [];
          }
        }
      }
    } catch (_) {}

    return [];
  }

  static Medarbejder? getMedarbejderFromJsonMap(Map<String, dynamic> response) {
    try {
      Medarbejder medarbejder = Medarbejder(
        id: response['id'],
        navn: response['navn'],
        email: response['email'],
        password: response['password'],
        tlf: response['tlf'],
        farve: response['farve'],
        arbejdsdagStart: response['arbejdsdagStart'] != null ? DateTime.parse(response['arbejdsdagStart']) : null,
        arbejdsdagSlut: response['arbejdsdagSlut'] != null ? DateTime.parse(response['arbejdsdagSlut']) : null,
        arbejdstimerOmUgen: response['arbejdstimerOmUgen'],
      );

      // Fravær
      var fravaerJson = response['fravaer'];
      if (fravaerJson != null && fravaerJson is List && fravaerJson.isNotEmpty) {
        for (var fravaerElement in fravaerJson) {
          Fravaer? fravaer = Fravaer.getFravaerFromJsonMap(fravaerElement);
          if (fravaer != null) {
            medarbejder.fravaer.add(fravaer);
          }
        }
      }

      // Roller
      var rolleJson = response['roller'];
      if (rolleJson != null && rolleJson is List && rolleJson.isNotEmpty) {
        for (var rolleElement in rolleJson) {
          Rolle? rolle = Rolle.getRolleFromJsonMap(rolleElement);
          if (rolle != null) {
            medarbejder.roller.add(rolle);
          }
        }
      }

      return medarbejder;

    } catch (_) {}

    return null;
  }
}