import 'dart:math';

import 'package:assignly/classes/helpers/api.dart';
import 'package:assignly/classes/objects/maskine.dart';
import 'package:assignly/classes/objects/modul.dart';
import 'package:assignly/classes/objects/path.dart';
import 'package:assignly/widgets/appointmenteditor.dart';
import 'package:assignly/widgets/pop_up_editor.dart';
/// Package imports.
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';

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

  final List<String> _subjectCollection = <String>[];
  final List<Color> _colorCollection = <Color>[];
  final List<Appointment> _shiftCollection = <Appointment>[];
  final List<CalendarResource> _employeeCollection = <CalendarResource>[];
  final List<TimeRegion> _specialTimeRegions = <TimeRegion>[];
  final List<String> _nameCollection = <String>[];
  final List<String> _colorNames = <String>[];
  final List<String> _timeZoneCollection = <String>[];
  final CalendarController _calendarController = CalendarController();
  List<Maskine> _maskiner = [];
  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.timelineDay,
    CalendarView.timelineWeek,
    CalendarView.timelineWorkWeek,
    CalendarView.timelineMonth,
  ];
  late List<DateTime> _visibleDates;
  late _ShiftDataSource _events;
  String _subject = '';
  bool _isAllDay = false;
  int _selectedColorIndex = 0;
  Appointment? _selectedAppointment;

  Future<void> load() async {
    await _addResourceDetails();
    _addResources();
    _addSpecialRegions();
    _addAppointmentDetails();
    _addAppointments();
  }

  @override
  void initState() {
    _calendarController.view = CalendarView.timelineWeek;
    _events = _ShiftDataSource(_shiftCollection, _employeeCollection);

    super.initState();
  }

  void _onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    _visibleDates = visibleDatesChangedDetails.visibleDates;
  }

  /// Navigates to appointment editor page when the Calendar elements tapped
  /// other than the header, handled the editor fields based on tapped element.
  void _onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    /// Condition added to open the editor, when the Calendar elements tapped
    /// other than the header.
    if (calendarTapDetails.targetElement == CalendarElement.header ||
        calendarTapDetails.targetElement == CalendarElement.viewHeader ||
        calendarTapDetails.targetElement == CalendarElement.resourceHeader) {
      return;
    }
    //_selectedAppointment = null;

    /// Navigates Calendar to day view, when we tap on month cells in mobile.
    if (//!model.isWebFullView &&
        _calendarController.view == CalendarView.month) {
      _calendarController.view = CalendarView.day;
    } else {
      if (calendarTapDetails.appointments != null &&
          calendarTapDetails.targetElement == CalendarElement.appointment) {
        final dynamic appointment = calendarTapDetails.appointments![0];
        if (appointment is Appointment) {
          //_selectedAppointment = appointment;
        }
      }

      final DateTime selectedDate = calendarTapDetails.date!;
      final CalendarElement targetElement = calendarTapDetails.targetElement;

      /// To open the appointment editor for web,
      /// when the screen width is greater than 767.
      final bool isAppointmentTapped =
          calendarTapDetails.targetElement == CalendarElement.appointment;
      showDialog<Widget>(
        context: context,
        builder: (BuildContext context) {
          final List<Appointment> appointment = <Appointment>[];
          Appointment? newAppointment;

          /// Creates a new appointment, which is displayed on the tapped
          /// Calendar element, when the editor is opened.
          if (_selectedAppointment == null) {
            _isAllDay =
                calendarTapDetails.targetElement ==
                CalendarElement.allDayPanel;
              _selectedColorIndex = 0;
              _subject = '';
              final DateTime date = calendarTapDetails.date!;
              newAppointment = Appointment(
                startTime: date,
                endTime: date.add(const Duration(hours: 1)),
                resourceIds: <Object>[calendarTapDetails.resource!.id],
                color: _colorCollection[_selectedColorIndex],
                isAllDay: _isAllDay,
                subject: _subject == '' ? '(No title)' : _subject,
              );
              appointment.add(newAppointment);
              _events.appointments!.add(appointment[0]);
              SchedulerBinding.instance.addPostFrameCallback((
                Duration duration,
              ) {
                _events.notifyListeners(
                  CalendarDataSourceAction.add,
                  appointment,
                );
              });
              _selectedAppointment = newAppointment;
            }
            return PopScope(
              onPopInvokedWithResult: (bool value, Object? result) async {
                if (newAppointment != null) {
                  /// To remove the created appointment when the pop-up closed
                  /// without saving the appointment.
                  final int appointmentIndex = _events.appointments!.indexOf(
                    newAppointment,
                  );
                  if (appointmentIndex <= _events.appointments!.length - 1 &&
                      appointmentIndex >= 0) {
                    _events.appointments!.removeAt(
                      _events.appointments!.indexOf(newAppointment),
                    );
                    _events.notifyListeners(
                      CalendarDataSourceAction.remove,
                      <Appointment>[newAppointment],
                    );
                  }
                }
              },
              child: Center(
                child: SizedBox(
                  width: isAppointmentTapped ? 400 : 500,
                  height: isAppointmentTapped
                      ? (250)
                      : 450,
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: isAppointmentTapped ? displayAppointmentDetails(
                      context,
                      targetElement,
                      selectedDate,
                      _selectedAppointment!,
                      _colorCollection,
                      _colorNames,
                      _events,
                      _timeZoneCollection,
                      _visibleDates,
                    )
                    : PopUpAppointmentEditor(
                      newAppointment,
                      appointment,
                      _events,
                      _colorCollection,
                      _colorNames,
                      _selectedAppointment!,
                      _timeZoneCollection,
                      _visibleDates,
                    ),
                  ),
                ),
              ),
            );
        },
      );
    }
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
            timeRegionBuilder: _getSpecialRegionWidget,
            specialRegions: _specialTimeRegions,
            dataSource: _events,
            onViewChanged: _onViewChanged,
            onTap: _onCalendarTapped,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  /// Creates the required resource details as list.
  Future<void> _addResourceDetails() async {
    Response response = await API.getRequest(ApiPath.maskine);
    _maskiner = Maskine.getMaskineFromJson(response.body);

    for (Maskine maskine in _maskiner) {
      if (maskine.navn != null) {
        _nameCollection.add(maskine.navn!);
      }
    }
  }

  /// Creates the required appointment details as a list.
  void _addAppointmentDetails() {
    _subjectCollection.add('General Meeting');
    _subjectCollection.add('Plan Execution');

    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
  }

  /// Method that creates the resource collection for the Calendar, with the
  /// required information.
  void _addResources() {
    final Random random = Random();
    for (int i = 0; i < _maskiner.length; i++) {
      _employeeCollection.add(
        CalendarResource(
          displayName: _maskiner[i].navn ?? 'UNKNOWN',
          id: _maskiner[i].id ?? '0',
          color: Color.fromRGBO(
            random.nextInt(255),
            random.nextInt(255),
            random.nextInt(255),
            1,
          ),
          image: null,
        ),
      );
    }
  }

  /// Method that creates the collection the time region for Calendar, with
  /// required information.
  void _addSpecialRegions() {
    final DateTime date = DateTime.now();
    final Random random = Random();
    for (int i = 0; i < _employeeCollection.length; i++) {
      _specialTimeRegions.add(
        TimeRegion(
          startTime: DateTime(date.year, date.month, date.day, 12),
          endTime: DateTime(date.year, date.month, date.day, 13),
          text: 'Lunch',
          color: Colors.grey.withValues(alpha: 0.2),
          resourceIds: <Object>[_employeeCollection[i].id],
          recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
        ),
      );
      final DateTime startDate = DateTime(
        date.year,
        date.month,
        date.day,
        17 + random.nextInt(7),
      );
      _specialTimeRegions.add(
        TimeRegion(
          startTime: startDate,
          endTime: startDate.add(const Duration(hours: 1)),
          text: 'Not Available',
          color: Colors.grey.withValues(alpha: 0.2),
          enablePointerInteraction: false,
          resourceIds: <Object>[_employeeCollection[i].id],
        ),
      );
    }
  }

  /// Method that creates the collection the data source for Calendar, with
  /// required information.
  void _addAppointments() async {
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


  /*void _addAppointments() {
    final Random random = Random();
    for (int i = 0; i < _employeeCollection.length; i++) {
      final List<Object> employeeIds = <Object>[_employeeCollection[i].id];
      if (i == _employeeCollection.length - 1) {
        int index = random.nextInt(1);
        index = index == i ? index + 1 : index;
        final Object employeeId = _employeeCollection[index].id;
        if (employeeId is String) {
          employeeIds.add(employeeId);
        }
      }
      for (int k = 0; k < 365; k++) {
        if (employeeIds.length > 1 && k.isEven) {
          continue;
        }
        for (int j = 0; j < 2; j++) {
          final DateTime date = DateTime.now().add(Duration(days: k + j));
          int startHour = 9 + random.nextInt(6);
          startHour = startHour >= 13 && startHour <= 14
              ? startHour + 1
              : startHour;
          final DateTime shiftStartTime = DateTime(
            date.year,
            date.month,
            date.day,
            startHour,
          );
          _shiftCollection.add(
            Appointment(
              startTime: shiftStartTime,
              endTime: shiftStartTime.add(const Duration(hours: 1)),
              subject: _subjectCollection[random.nextInt(1)],
              color: _colorCollection[random.nextInt(1)],
              startTimeZone: '',
              endTimeZone: '',
              resourceIds: employeeIds,
            ),
          );
        }
      }
    }
  }*/

  Widget _getSpecialRegionWidget(
    BuildContext context,
    TimeRegionDetails details,
  ) {
    if (details.region.text == 'Lunch') {
      return Container(
        color: details.region.color,
        alignment: Alignment.center,
        child: Icon(
          Icons.restaurant_menu,
          color: Colors.grey.withValues(alpha: 0.5),
        ),
      );
    } else if (details.region.text == 'Not Available') {
      return Container(
        color: details.region.color,
        alignment: Alignment.center,
        child: Icon(Icons.block, color: Colors.grey.withValues(alpha: 0.5)),
      );
    }
    return Container(color: details.region.color);
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
