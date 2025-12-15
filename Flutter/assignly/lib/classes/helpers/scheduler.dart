import 'dart:math';
import 'package:assignly/classes/helpers/api.dart';
import 'package:assignly/classes/helpers/notifiers.dart';
import 'package:assignly/classes/objects/maskine.dart';
import 'package:assignly/classes/objects/modul.dart';
import 'package:assignly/classes/objects/medarbejder.dart';
import 'package:assignly/classes/objects/path.dart';

/// FUNKTIONALITET:
/// - get maskine, medarbejder and modul fra API
/// - finder huller på skemaet efter given dato
/// - vælger en tilgængelig medarbejder og poster et modul til API
class Scheduler {
  final int workStartHour;

  final int workEndHour;

  Scheduler({this.workStartHour = 8, this.workEndHour = 16});

  // GET MASKINER FROM API
  Future<List<Maskine>> getMaskiner() async {
    // GET FROM API
    final resp = await API.getRequest(ApiPath.maskine);

    // IF SUCCESS
    if (resp.statusCode == 200) {
      try {
        return Maskine.getMaskineFromJson(resp.body);
      } catch (_) {}
    }
    return [];
  }

  // GET MEDARBJDERE FROM API
  Future<List<Medarbejder>> getMedarbejdere() async {
    // GET FROM API
    final resp = await API.getRequest(ApiPath.medarbejder);
    
    // IF SUCCESS
    if (resp.statusCode == 200) {
      try {
        return Medarbejder.getMedarbejderFromJson(resp.body);
      } catch (_) {}
    }

    return [];
  }

  // GET MODULER FROM API
  Future<List<Modul>> getModuler() async {
    // GET FROM API
    final resp = await API.getRequest(ApiPath.modul);

    // IF SUCCESS
    if (resp.statusCode == 200) {
      try {
        return Modul.getModulFromJson(resp.body);
      } catch (_) {}
    }
    return [];
  }

  // SHORTENED OVERLAP CHECK
  bool _overlaps(DateTime aStart, DateTime aEnd, DateTime bStart, DateTime bEnd) {
    return aStart.isBefore(bEnd) && bStart.isBefore(aEnd);
  }

  // CHECK IF MEDARBEJDER IS AVAILABLE (IS WITHIN ARBEJDSDAG, FRAVÆR)
  bool _isMedarbejderAvailable(Medarbejder medarb, DateTime start, DateTime end) {
    // CHECK OM DET ER INDENFOR MEDARBEJDERENS ARBEJDSDAG

    // TODO: DET HER LORT FUCKER
    /*if (medarb.arbejdsdagStart != null && medarb.arbejdsdagSlut != null) {
      final dayStart = DateTime(start.year, start.month, start.day, medarb.arbejdsdagStart!.hour, medarb.arbejdsdagStart!.minute);
      final dayEnd = DateTime(start.year, start.month, start.day, medarb.arbejdsdagSlut!.hour, medarb.arbejdsdagSlut!.minute);
      if (start.isBefore(dayStart) || end.isAfter(dayEnd)) return false;
    }*/

    // CHECK OM MEDARBEJDEREN ER FRAVÆRENDE INDENFOR TIDSPERIODEN
    if (medarb.fravaer.isNotEmpty) {
      for (var f in medarb.fravaer) {
        // NUlL CHECK
        if (f == null) continue;
        if (f.start != null && f.end != null) {
          // HVIS DER ER FRAVÆR SOM OVERLAPPER MED MODULENS TIDSPERIODE RETURNER FALSE
          if (_overlaps(start, end, f.start!, f.end!)) return false;
        }
      }
    }

    return true;
  }

  /// ASSIGN MISSING SLOTS
    Future<void> scheduleUnassignedForDate(DateTime date,
      {int durationMinutes = 60,
      bool dryRun = true,
      int iterations = 3000,
      List<Maskine>? machinesParam,
      List<Medarbejder>? medarbejdereParam,
      List<Modul>? allModulerParam,
      void Function(String)? onLog}) async {

    // GET FRA API
    final maskiner = machinesParam ?? await getMaskiner();
    final medarbejdere = medarbejdereParam ?? await getMedarbejdere();
    final allModuler = allModulerParam ?? await getModuler();

    // UGE START (MANDAG 00:00)
    final weekStart = DateTime(date.year, date.month, date.day).subtract(Duration(days: date.weekday - 1));

    // NÆSTE UGE MANDAG
    final weekEnd = weekStart.add(const Duration(days: 7));

    // FIND HVOR MANGE MINUTTER MEDARBEJDERE ALLEREDE ER TILKOBLET
    final Map<String, int> assignedWeekMinutes = {};
    for (final modul in allModuler) {
      // NULL CHECK
      if (modul.medarbejderId == null || modul.start == null || modul.end == null) continue;

      // CHECK OVERLAP
      if (modul.start!.isBefore(weekEnd) && modul.end!.isAfter(weekStart)) {
        final overlapStart = modul.start!.isBefore(weekStart) ? weekStart : modul.start!;
        final overlapEnd = modul.end!.isAfter(weekEnd) ? weekEnd : modul.end!;
        final minutes = overlapEnd.difference(overlapStart).inMinutes;
        assignedWeekMinutes[modul.medarbejderId!] = (assignedWeekMinutes[modul.medarbejderId!] ?? 0) + minutes;
      }
    }

    // FINDER ALLE MANGLEDE MODULLER PÅ ALLE MASKINER
    final List<_ModuleObject> freeModuler = [];
    for (final maskine in maskiner) {
      
      // HENTER EXISTERENDE MODULLER
      final existing = <Modul>[];
      for (final m in maskine.moduler) {
        if (m.start != null && m.end != null) {
          if (m.start!.year == date.year && m.start!.month == date.month && m.start!.day == date.day) {
            existing.add(m);
          }
        }
      }

      // SORTERE EFTER START TIDSPUNKT
      existing.sort((a, b) => a.start!.compareTo(b.start!));

      final dayStart = DateTime(date.year, date.month, date.day, workStartHour);
      final dayEnd = DateTime(date.year, date.month, date.day, workEndHour);

      // SCANNER DAGEN
      DateTime cursor = dayStart;
      for (final modul in existing) {
        // NULL CHECK
        if (modul.start == null) continue;
        
        if (cursor.isBefore(modul.start!)) {
          final gapStart = cursor;
          final gapEnd = modul.start!;

          DateTime freeModul = gapStart;

          // OMDAN FRI TIL MODUL
          while (freeModul.add(Duration(minutes: durationMinutes)).isBefore(gapEnd) || freeModul.add(Duration(minutes: durationMinutes)).isAtSameMomentAs(gapEnd)) {
            freeModuler.add(_ModuleObject(maskine, freeModul, freeModul.add(Duration(minutes: durationMinutes))));
            freeModul = freeModul.add(Duration(minutes: durationMinutes));
          }
        }

        if (cursor.isBefore(modul.end!)) cursor = modul.end!;
      }

      if (cursor.isBefore(dayEnd)) {
        DateTime s = cursor;
        while (s.add(Duration(minutes: durationMinutes)).isBefore(dayEnd) || s.add(Duration(minutes: durationMinutes)).isAtSameMomentAs(dayEnd)) {
          freeModuler.add(_ModuleObject(maskine, s, s.add(Duration(minutes: durationMinutes))));
          s = s.add(Duration(minutes: durationMinutes));
        }
      }
    }

    if (freeModuler.isEmpty) return;

    // HENT ALLE MEDARBEJDERE DER PASSER MED ROLLERNE UDEN AT KIGGE PÅ TIMERPÅUGE ELLER ANDET
    // MAP MED GYLDIGE INDEX
    final Map<int, List<int>> validIndex = {};
    for (int i = 0; i < freeModuler.length; i++) {
      final slot = freeModuler[i];
      final List<int> list = [];
      for (int index = 0; index < medarbejdere.length; index++) {
        final m = medarbejdere[index];
 
        //  MEDARBEJDER SKAL HAVE ROLLE MATCHENDE TIL EGENSKAB I MASKINE
        bool hasSkill = true;
        if (slot.maskine.egenskab != null) {
          hasSkill = false;
          for (final r in m.roller) {
            if (r == null) continue;
            for (final e in r.egenskaber) {
              if (e != null && e.id == slot.maskine.egenskab!.id) {
                hasSkill = true;
                break;
              }
            }
            if (hasSkill) break;
          }
        }
        // TODO: ADD BACK
        //if (!hasSkill) continue;

        // CHECK OM DE ER LEDIGE I TIDSRUMMET
        if (!_isMedarbejderAvailable(m, slot.start, slot.end)) continue;

        // HVIS INDEX ER GYLDIG TILFØJ TIL LISTEN
        list.add(index);
      }
      // TILFØJ LISTEN TIL GYLDIG MAP
      validIndex[i] = list;
    }

    // FINDER RESTERENDE TID OM UGEN
    int remainingMinutesFor(int index, Map<int, int> extraAssignedMinutes) {
      final m = medarbejdere[index];

      // ARBEJDSTIMER I UGEN I MINUTTER
      final allowed = (m.arbejdstimerOmUgen ?? 37) * 60;

      // BRUGTE MINUTTER
      final used = assignedWeekMinutes[m.id ?? ''] ?? 0;

      // EXTRA UDOVER
      final extra = extraAssignedMinutes[index] ?? 0;

      // RESTERENDE MINUTTER TILGÆNGELIGE
      return allowed - used - extra;
    }

    // TAGER DEN FØRSTE GYLDIGE MED TID
    final List<int?> solution = List<int?>.filled(freeModuler.length, null);

    final Map<int, int> extraAssigned = {};
    for (int i = 0; i < freeModuler.length; i++) {
      final modul = freeModuler[i];
      final slotMinutes = modul.durationInMinutes;

      for (final medarbejderIndex in validIndex[i] ?? []) {
        if (remainingMinutesFor(medarbejderIndex, extraAssigned) >= slotMinutes) {
          
          // TJEKKER AT DER IKKE ER OVERLAP MED ANDRE MODULER FOR DEN MEDARBEJDER
          bool conflict = false;
          for (int index = 0; index < freeModuler.length; index++) {
            if (solution[index] == medarbejderIndex) {
              final other = freeModuler[index];
              if (_overlaps(modul.start, modul.end, other.start, other.end)) {
                conflict = true;
                break;
              }
            }
          }

          // HVIS DER IKKE ER NOGLE KONFLIKTER SÅ TAGER DEN OG TILFØJER TIL SOLUTION OG EXTRA
          if (!conflict) {
            solution[i] = medarbejderIndex;
            extraAssigned[medarbejderIndex] = (extraAssigned[medarbejderIndex] ?? 0) + slotMinutes;
            break;
          }
        }
      }
    }

    Map<int, int> extraFromSolution(List<int?> sol) {
      final Map<int, int> extra = {};
      for (int i = 0; i < sol.length; i++) {
        final midx = sol[i];
        if (midx == null) continue;
        extra[midx] = (extra[midx] ?? 0) + freeModuler[i].durationInMinutes;
      }
      return extra;
    }

    int costOf(List<int?> sol) {
      // MINIMER ANTAL FRITID
      int unfilled = 0;
      for (int i = 0; i < sol.length; i++) {
        if (sol[i] == null) unfilled += freeModuler[i].durationInMinutes;
      }

      // BALANCER
      final extra = extraFromSolution(sol);
      final List<int> totals = [];
      for (int j = 0; j < medarbejdere.length; j++) {
        final used = assignedWeekMinutes[medarbejdere[j].id ?? ''] ?? 0;
        final add = extra[j] ?? 0;
        totals.add(used + add);
      }
      int imbalance = 0;
      if (totals.isNotEmpty) {
        final mx = totals.reduce((a, b) => a > b ? a : b);
        final mn = totals.reduce((a, b) => a < b ? a : b);
        imbalance = mx - mn;
      }

      // cost = unfilled_minutes * 1000 + imbalance * weight(5)
      return unfilled * 1000 + imbalance * 5;
    }

    // Simulated annealing
    final rnd = Random();
    double T = 1.0;
    const double cooling = 0.995;
    List<int?> best = List<int?>.from(solution);
    int bestCost = costOf(best);
    List<int?> current = List<int?>.from(solution);
    Map<int, int> currentExtra = Map<int, int>.from(extraAssigned);

    for (int i = 0; i < iterations; i++) {
      // neighbor: vælg random slot og assign/unassign/change
      final idx = rnd.nextInt(freeModuler.length);
      final slot = freeModuler[idx];
      final cur = current[idx];

      // build candidate list: gyldig
      final elig = List<int?>.from(validIndex[idx] ?? []);
      elig.add(null);
      final choice = elig[rnd.nextInt(elig.length)];

      // apply change if valid
      bool valid = true;
      final newExtra = Map<int, int>.from(currentExtra);
      // remove current assignment
      if (cur != null) {
        newExtra[cur] = (newExtra[cur] ?? 0) - slot.durationInMinutes;
      }
      if (choice != null) {
        // check capacity
        if (remainingMinutesFor(choice, newExtra) < slot.durationInMinutes) valid = false;
        // check conflicts with other slots assigned to same
        if (valid) {
          for (int index = 0; index < freeModuler.length; index++) {
            if (index == idx) continue;
            if (current[index] == choice) {
              if (_overlaps(slot.start, slot.end, freeModuler[index].start, freeModuler[index].end)) {
                valid = false;
                break;
              }
            }
          }
        }
        if (valid) {
          newExtra[choice] = (newExtra[choice] ?? 0) + slot.durationInMinutes;
        }
      }

      if (!valid) {
        // skip this neighbor
        T = T * cooling;
        continue;
      }

      // evaluate
      final candidate = List<int?>.from(current);
      candidate[idx] = choice;
      final candidateCost = costOf(candidate);
      final currentCost = costOf(current);

      if (candidateCost <= currentCost || rnd.nextDouble() < exp((currentCost - candidateCost) / T)) {
        current = candidate;
        currentExtra = newExtra;
        if (candidateCost < bestCost) {
          best = List<int?>.from(candidate);
          bestCost = candidateCost;
        }
      }

      T = T * cooling;
      if (T < 1e-4) T = 1e-4;
    }

    // Apply best solution: create
    for (int i = 0; i < best.length; i++) {
      final midx = best[i];
      if (midx == null) continue;
      final slot = freeModuler[i];
      final chosen = medarbejdere[midx];
      final modul = Modul(start: slot.start, end: slot.end, medarbejderId: chosen.id, maskineId: slot.maskine.id);
      final envelope = API.createModulPostEnvelope(modul);
      final msg = 'Assign ${chosen.navn} to ${slot.maskine.navn} ${slot.start} - ${slot.end}';
      if (dryRun) {
        final out = 'DRY: $msg';
        print(out);
        if (onLog != null) onLog(out);
      } else {
        try {
          final resp = await API.postRequest(envelope, ApiPath.modul);
          if (resp.statusCode >= 200 && resp.statusCode < 300) {
            final out = 'Assigned ${chosen.navn} to machine ${slot.maskine.navn} from ${slot.start} to ${slot.end}';
            print(out);
            if (onLog != null) onLog(out);
          } else {
            final out = 'Failed to post modul: ${resp.statusCode} ${resp.body}';
            print(out);
            if (onLog != null) onLog(out);
          }
        } catch (e) {
          final out = 'Error posting modul: $e';
          print(out);
          if (onLog != null) onLog(out);
        }
      }
    }
    notifyModulesChanged();
  }
}

class _ModuleObject {
  final Maskine maskine;
  final DateTime start;
  final DateTime end;
  _ModuleObject(this.maskine, this.start, this.end);
  int get durationInMinutes => end.difference(start).inMinutes;
}

/// Example quick-run helper.
Future<void> scheduleToday({int durationMinutes = 60}) async {
  final sched = Scheduler();
  final today = DateTime.now();
  await sched.scheduleUnassignedForDate(DateTime(today.year, today.month, today.day), durationMinutes: durationMinutes);
}
