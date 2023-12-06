import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'home_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> { //this is the functionality for the floating action button
  List<Appointment> appointments;

  _CalendarScreenState() : appointments = getAppointments();

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: const Color.fromARGB(255, 51, 153, 255),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        firstDayOfWeek: 7,
        dataSource: MeetingDataSource(appointments),
      ),
    );
  }
}  


List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = 
    DateTime(today.year, today.month, today.day, 9,0,0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
  for (Note note in list) {
    meetings.add(note.getAppointment());
  }
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
