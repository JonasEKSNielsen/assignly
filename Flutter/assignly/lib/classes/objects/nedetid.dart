// ignore_for_file: constant_identifier_names
import 'package:assignly/classes/objects/hverdag.dart';


class Nedetid {
  String? id;
  Hverdag? dag;
  // TIMEONLY FORMAT HH:MM
  String? tidspunkt;
  bool? gentagende;
  DateTime? start;
  DateTime? end;

  Nedetid({required this.id, required this.dag, required this.tidspunkt, required this.gentagende, required this.start, required this.end});

  

}
