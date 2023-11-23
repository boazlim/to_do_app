import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}
class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 6,
        dataSource: MeetingDataSource(getAppointments()),
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

  meetings.add(Appointment(
    startTime: startTime,
    endTime: endTime,
    subject: 'Conference',
    color: Colors.blue));

  return meetings;
}

class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}