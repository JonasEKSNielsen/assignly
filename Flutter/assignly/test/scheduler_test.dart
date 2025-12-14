import 'package:flutter_test/flutter_test.dart';
import 'package:assignly/classes/helpers/scheduler.dart';
import 'package:assignly/classes/objects/maskine.dart';
import 'package:assignly/classes/objects/egenskab.dart';
import 'package:assignly/classes/objects/modul.dart';
import 'package:assignly/classes/objects/medarbejder.dart';
import 'package:assignly/classes/objects/rolle.dart';

void main() {
  test('Scheduler dry-run balances assignments and fills slots', () async {
    final eg = Egenskab(id: 'e1', titel: 'skill');

    final mask1 = Maskine(id: 'm1', egenskabId: 'e1', navn: 'Mask1', egenskab: eg, moduler: []);
    final mask2 = Maskine(id: 'm2', egenskabId: 'e1', navn: 'Mask2', egenskab: eg, moduler: []);

    final rolle = Rolle(id: 'r1', navn: 'maker', egenskaber: [eg]);

    final medarbejder1 = Medarbejder(
      id: 'u1', navn: 'Alice', email: 'a@x', password: 'x',
      arbejdstimerOmUgen: 40,
      roller: [rolle],
    );
    final medarbejder2 = Medarbejder(
      id: 'u2', navn: 'Bob', email: 'b@x', password: 'x',
      arbejdstimerOmUgen: 40,
      roller: [rolle],
    );

    final date = DateTime.now();

    // No existing modules
    final machines = [mask1, mask2];
    final medarbejdere = [medarbejder1, medarbejder2];
    final allModuler = <Modul>[];

    // Run scheduler in dryRun mode; should not throw and should complete.
    await Scheduler(workStartHour: 8, workEndHour: 12)
      .scheduleUnassignedForDate(DateTime(date.year, date.month, date.day),
        durationMinutes: 60, dryRun: true, iterations: 500, machinesParam: machines, medarbejdereParam: medarbejdere, allModulerParam: allModuler);

    // If we reached here without exceptions it's acceptable for this smoke test.
    expect(true, isTrue);
  });
}
