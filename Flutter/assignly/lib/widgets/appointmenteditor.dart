import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'package:syncfusion_flutter_calendar/calendar.dart';
// ignore: depend_on_referenced_packages
import 'package:syncfusion_flutter_core/core.dart';


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

/// Signature for callback which reports the picker value changed.
typedef PickerChanged =
    void Function(PickerChangedDetails pickerChangedDetails);

/// Details for the [PickerChanged].
class PickerChangedDetails {
  PickerChangedDetails({
    this.index = -1,
    this.resourceId,
  });

  final int index;
  final Object? resourceId;
}

/// An object to set the appointment collection data source to collection, and
/// allows to add, remove or reset the appointment collection.
class _DataSource extends CalendarDataSource {
  _DataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}

/// Formats the tapped appointment time text, to display on the pop-up view.
String _getAppointmentTimeText(Appointment selectedAppointment) {
  if (selectedAppointment.isAllDay) {
    if (isSameDate(
      selectedAppointment.startTime,
      selectedAppointment.endTime,
    )) {
      return DateFormat('EEEE, MMM dd').format(selectedAppointment.startTime);
    }
    return '${DateFormat('EEEE, MMM dd').format(selectedAppointment.startTime)} - ${DateFormat('EEEE, MMM dd').format(selectedAppointment.endTime)}';
  } else if (selectedAppointment.startTime.day !=
          selectedAppointment.endTime.day ||
      selectedAppointment.startTime.month !=
          selectedAppointment.endTime.month ||
      selectedAppointment.startTime.year != selectedAppointment.endTime.year) {
    String endFormat = 'EEEE, ';
    if (selectedAppointment.startTime.month !=
        selectedAppointment.endTime.month) {
      endFormat += 'MMM';
    }

    endFormat += ' dd hh:mm a';
    return '${DateFormat(
          'EEEE, MMM dd hh:mm a',
        ).format(selectedAppointment.startTime)} - ${DateFormat(endFormat).format(selectedAppointment.endTime)}';
  } else {
    return '${DateFormat(
          'EEEE, MMM dd hh:mm a',
        ).format(selectedAppointment.startTime)} - ${DateFormat('hh:mm a').format(selectedAppointment.endTime)}';
  }
}

/// Displays the tapped appointment details in a pop-up view.
Widget displayAppointmentDetails(
  BuildContext context,
  CalendarElement targetElement,
  DateTime selectedDate,
  Appointment selectedAppointment,
  List<Color> colorCollection,
  List<String> colorNames,
  CalendarDataSource events,
  List<String> timeZoneCollection,
  List<DateTime> visibleDates,
) {
  const Color defaultColor = Colors.black54;
  const Color defaultTextColor = Colors.black87;
  return ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[

      // TOP BAR WITH ACTION BUTTONS
      ListTile(
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            // EDIT BUTTON
            IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.edit, color: defaultColor),
              onPressed: () {
                // ADD EDITOR
                Navigator.pop(context);
              },
            ),

            // DELETE BUTTON
            IconButton(
              icon: const Icon(Icons.delete, color: defaultColor),
              splashRadius: 20,
              onPressed: () {
                // ADD DELETE CONFIRMATION
                Navigator.pop(context);
              },
            ),

            // CLOSE BUTTON
            IconButton(
              splashRadius: 20,
              icon: const Icon(Icons.close, color: defaultColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      
      // TITLE AND TIME TEXT
      ListTile(
        leading: Icon(Icons.lens, color: selectedAppointment.color, size: 20),
        title: Text(
          selectedAppointment.subject,
          style: const TextStyle( 
            fontSize: 20,
            color: defaultTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            _getAppointmentTimeText(selectedAppointment),
            style: const TextStyle(
              fontSize: 15,
              color: defaultTextColor,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),

      // MEDARBEJDERE
      ListTile(
          leading: const Icon(Icons.people, size: 20, color: defaultColor),
          title: DropdownButton<String>(
            value: selectedAppointment.resourceIds?.isNotEmpty == true
                ? selectedAppointment.resourceIds!.first.toString()
                : null,
            hint: const Text(
              'Select Medarbejder',
              style: TextStyle(fontSize: 15),
            ),
            items: events.resources?.map((resource) {
              return DropdownMenuItem<String>(
                value: resource.id.toString(),
                child: Text(
                  resource.displayName,
                  style: const TextStyle(fontSize: 15),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {},
          ),
        ),
    ],
  );
}
