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
      body: SfCalendar(
        view: CalendarView.week,
        firstDayOfWeek: 7,
        dataSource: MeetingDataSource(appointments),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddAppointmentPressed,
        tooltip: 'Add Appointment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onAddAppointmentPressed() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddAppointmentDialog(onAdd: (Appointment newAppointment) {
          setState(() {
            appointments.add(newAppointment);
          });
        });
      },
    );
  }
}  // floating action button here

class AddAppointmentDialog extends StatefulWidget {
  final Function(Appointment) onAdd;

  AddAppointmentDialog({Key? key, required this.onAdd}) : super(key: key);

  @override
  _AddAppointmentDialogState createState() => _AddAppointmentDialogState();
}

class _AddAppointmentDialogState extends State<AddAppointmentDialog> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _subjectController,
              decoration: const InputDecoration(hintText: 'Subject'),
            ),
            TextField(
              controller: _startTimeController,
              decoration: const InputDecoration(hintText: 'Start Time (HH:MM)'),
              keyboardType: TextInputType.datetime,
            ),
            TextField(
              controller: _endTimeController,
              decoration: const InputDecoration(hintText: 'End Time (HH:MM)'),
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final DateTime now = DateTime.now();
                final DateTime startTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  int.parse(_startTimeController.text.split(':')[0]),
                  int.parse(_startTimeController.text.split(':')[1]),
                );
                final DateTime endTime = DateTime(
                  now.year,
                  now.month,
                  now.day,
                  int.parse(_endTimeController.text.split(':')[0]),
                  int.parse(_endTimeController.text.split(':')[1]),
                );
                
                final Appointment newAppointment = Appointment(
                  startTime: startTime,
                  endTime: endTime,
                  subject: _subjectController.text,
                  color: Colors.blue,
                );

                widget.onAdd(newAppointment);
                Navigator.pop(context);
              },
              child: const Text('Add Appointment'),
            ),
          ],
        ),
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
