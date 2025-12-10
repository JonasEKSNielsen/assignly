

enum ApiPath {
  egenskab,
  fravaer,
  maskine,
  medarbejder,
  modul,
  nedetid,
  periode,
  rolle,
}

extension PathExtension on ApiPath {
  String get value {
    String name;
    switch (this) {
      case ApiPath.egenskab:
        name = 'Egenskabs';
      case ApiPath.fravaer:
        name = 'Fravaers';
      case ApiPath.maskine:
        name = 'Maskines';
      case ApiPath.medarbejder:
        name = 'Medarbejders';
      case ApiPath.modul:
        name = 'Moduls';
      case ApiPath.nedetid:
        name = 'Nedetids';
      case ApiPath.periode:
        name = 'Periodes';
      case ApiPath.rolle:
        name = 'Rolles';
    }
    return name;
  }
}
