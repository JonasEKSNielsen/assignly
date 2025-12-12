import 'dart:convert';

class Egenskab {
  String? id, titel;

  Egenskab({required this.id, required this.titel});

  static Egenskab? getEgenskabFromJson(String response) {
    try {
      final data = jsonDecode(response);
      final results = data;

    } catch (_) {
    }
    return null;
  }
}