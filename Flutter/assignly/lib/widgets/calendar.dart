import 'dart:math';

import 'package:assignly/classes/helpers/api.dart';
import 'package:assignly/classes/objects/maskine.dart';
import 'package:assignly/classes/objects/modul.dart';
import 'package:assignly/classes/objects/path.dart';
/// Package imports.
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';
import 'package:assignly/classes/helpers/notifiers.dart';

/// Calendar import.
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// Widget class of shift scheduler Calendar.
class ShiftScheduler extends StatefulWidget {
  /// Creates Calendar of shift scheduler.
  const ShiftScheduler({super.key});

  @override
  _ShiftSchedulerState createState() => _ShiftSchedulerState();
}

class _ShiftSchedulerState<T extends StatefulWidget> extends State<T> {
  _ShiftSchedulerState();

  List<Appointment> _shiftCollection = <Appointment>[];
  List<CalendarResource> _employeeCollection = <CalendarResource>[];
  List<String> _nameCollection = <String>[];
  final CalendarController _calendarController = CalendarController();
  List<Maskine> _maskiner = [];
  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.timelineWorkWeek,
    CalendarView.timelineMonth,
  ];
  late _ShiftDataSource _events;

  Future<void> load() async {
    await _addResourceDetails();
    _addResources();
    await _addAppointments();
    // Recreate data source so the calendar gets the populated lists.
    _events = _ShiftDataSource(_shiftCollection, _employeeCollection);
  }

  @override
  void initState() {
    _calendarController.view = CalendarView.timelineWeek;
    _events = _ShiftDataSource(_shiftCollection, _employeeCollection);

    // Listen for external module changes and reload when they occur.
    modulesVersion.addListener(_onModulesChanged);

    super.initState();
  }

  Future<void> _onModulesChanged() async {
    await _reloadData();
  }

  Future<void> _reloadData() async {
    _shiftCollection.clear();
    _employeeCollection.clear();
    _nameCollection.clear();

    await load();
    _events = _ShiftDataSource(_shiftCollection, _employeeCollection);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SfCalendar(
            showDatePickerButton: true,
            controller: _calendarController,
            allowedViews: _allowedViews,
            dataSource: _events,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  /// Creates the required resource details as list.
  Future<void> _addResourceDetails() async {
    _nameCollection = [];
    Response response = await API.getRequest(ApiPath.maskine);
    _maskiner = Maskine.getMaskineFromJson(response.body);

    for (Maskine maskine in _maskiner) {
      if (maskine.navn != null) {
        _nameCollection.add(maskine.navn!);
      }
    }
  }

  /// Method that creates the resource collection for the Calendar, with the
  /// required information.
  void _addResources() {
    _employeeCollection = [];

    for (int i = 0; i < _maskiner.length; i++) {
      _employeeCollection.add(
        CalendarResource(
          displayName: _maskiner[i].navn ?? 'UNKNOWN',
          id: _maskiner[i].id ?? '0',
          // GENERATE RANDOM COLOR FOR MASKINE
          color: Color.fromRGBO(
            Random().nextInt(255),
            Random().nextInt(255),
            Random().nextInt(255),
            1,
          ),
          // TODO: USE REAL IMAGE
          image: null,
        ),
      );
    }
  }

  /// Method that creates the collection the data source for Calendar, with
  /// required information.
  Future<void> _addAppointments() async {
    _shiftCollection = [];
    var resp = await API.getRequest(ApiPath.modul);
    List<Modul> allModul = Modul.getModulFromJson(resp.body);

    for (Modul modul in allModul) {
      _shiftCollection.add(
        Appointment(
          subject: modul.medarbejder?.navn ?? 'Unassigned',
          startTime: modul.start ?? DateTime.now(),
          endTime: modul.end ?? DateTime.now().add(const Duration(hours: 1)),
          color: HexColor('#${modul.medarbejder?.farve ?? 'a86d32'}'),
          startTimeZone: '',
          endTimeZone: '',
          resourceIds: [modul.maskineId ?? ''],
        ), 
      );
    }
  }

  @override
  void dispose() {
    modulesVersion.removeListener(_onModulesChanged);
    _calendarController.dispose();
    super.dispose();
  }
}

/// An object to set the appointment collection data source to collection, which
/// used to map the custom appointment data to the Calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class _ShiftDataSource extends CalendarDataSource {
  _ShiftDataSource(
    List<Appointment> source,
    List<CalendarResource> resourceColl,
  ) {
    appointments = source;
    resources = resourceColl;
  }
}
