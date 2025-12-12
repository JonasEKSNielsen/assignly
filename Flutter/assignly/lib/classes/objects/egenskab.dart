class Egenskab {
  String? id, titel;

  Egenskab({required this.id, required this.titel});

  static Egenskab? getEgenskabFromJsonMap(Map<String, dynamic> response) {
    try {
      return Egenskab(
        id: response['id'],
        titel: response['titel'],
      );
    } catch (_) {
    }
    return null;
  }
}