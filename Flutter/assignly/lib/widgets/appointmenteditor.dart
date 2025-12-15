import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';


/// Render the widget of appointment editor Calendar.
class CalendarAppointmentEditor extends StatefulWidget {
  /// Creates the appointment editor.
  const CalendarAppointmentEditor({super.key});

  @override
  _CalendarAppointmentEditorState createState() =>
      _CalendarAppointmentEditorState();
}

class _CalendarAppointmentEditorState<T extends StatefulWidget> extends State<T> {
  _CalendarAppointmentEditorState();

  late List<String> _subjectCollection;
  late List<Appointment> _appointments;
  late List<Color> _colorCollection;
  late List<String> _colorNames;
  late List<String> _timeZoneCollection;
  late _DataSource _events;

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.workWeek,
    CalendarView.month,
    CalendarView.schedule,
  ];

  final ScrollController controller = ScrollController();
  final CalendarController calendarController = CalendarController();
  CalendarView _view = CalendarView.month;

  @override
  void initState() {
    calendarController.view = _view;
    _appointments = _getAppointmentDetails();
    _events = _DataSource(_appointments);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget calendar = _getAppointmentEditorCalendar(
        calendarController,
        _events,
        _onViewChanged,
        //scheduleViewBuilder,
      );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(child: calendar),
    );
  }

  /// The method called whenever the Calendar view navigated to previous/next
  /// view or switched to different Calendar view.
  void _onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
      setState(() {
        _view = calendarController.view!;

        /// Update the current view when the Calendar view changed to
        /// month view or from month view.
      });
    });
  }

  /// Creates the required appointment details as a list, and created the data
  /// source for Calendar with required information.
  List<Appointment> _getAppointmentDetails() {
    final List<Appointment> appointmentCollection = <Appointment>[];
    _subjectCollection = <String>[];
    _subjectCollection.add('General Meeting');
    _subjectCollection.add('Plan Execution');

    _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));

    _colorNames = <String>[];
    _colorNames.add('Green');
    _colorNames.add('Purple');

    _timeZoneCollection = <String>[];
    _timeZoneCollection.add('Default Time');
    _timeZoneCollection.add('AUS Central Standard Time');

    final DateTime today = DateTime.now();
    final Random random = Random();
    for (int month = -1; month < 2; month++) {
      for (int day = -5; day < 5; day++) {
        for (int hour = 9; hour < 18; hour += 5) {
          appointmentCollection.add(
            Appointment(
              startTime: today
                  .add(Duration(days: (month * 30) + day))
                  .add(Duration(hours: hour)),
              endTime: today
                  .add(Duration(days: (month * 30) + day))
                  .add(Duration(hours: hour + 2)),
              color: _colorCollection[random.nextInt(2)],
              startTimeZone: '',
              endTimeZone: '',
              notes: '',
              subject: _subjectCollection[random.nextInt(2)],
            ),
          );
        }
      }
    }
    return appointmentCollection;
  }

  /// Returns the Calendar based on the properties passed.
  SfCalendar _getAppointmentEditorCalendar([
    CalendarController? calendarController,
    CalendarDataSource? calendarDataSource,
    dynamic calendarTapCallback,
    ViewChangedCallback? viewChangedCallback,
    dynamic scheduleViewBuilder,
  ]) {
    return SfCalendar(
      controller: calendarController,
      allowedViews: _allowedViews,
      showDatePickerButton: true,
      scheduleViewMonthHeaderBuilder: scheduleViewBuilder,
      dataSource: calendarDataSource,
      onTap: calendarTapCallback,
      onViewChanged: viewChangedCallback,
      initialDisplayDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
      ),
      timeSlotViewSettings: const TimeSlotViewSettings(
        minimumAppointmentDuration: Duration(minutes: 60),
      ),
    );
  }
}

/// An object to set the appointment collection data source to collection, and
/// allows to add, remove or reset the appointment collection.
class _DataSource extends CalendarDataSource {
  _DataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}
