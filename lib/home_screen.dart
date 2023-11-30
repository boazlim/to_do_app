import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

List<Note> list = [];

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}
class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: const Color.fromARGB(255, 51, 153, 255),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Color.fromARGB(255,250,250,250),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade600,
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(4,4)
                  )
                ] 
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title: ${list[index].getTitle()}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Content: ${list[index].getContentPreview()}'),
                  const SizedBox(height: 8),
                  Text('Date Created: ${list[index].getDateCreated()}'),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const NewNoteWidget();
            },
          );
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}



class NewNoteWidget extends StatefulWidget {
  const NewNoteWidget({super.key});

  @override
  _NewNoteWidgetState createState() => _NewNoteWidgetState();
}

class _NewNoteWidgetState extends State<NewNoteWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  // final TextEditingController startTimeController = TextEditingController(text: '9');
  // final TextEditingController endTimeController = TextEditingController(text: '10');

  TimeOfDay _startTimeOfDay = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTimeOfDay = const TimeOfDay(hour: 10, minute: 0);

  void _showStartTimePicker() {
    showTimePicker(
      context: context,
      initialTime: _startTimeOfDay
    ).then ((value) {
      setState(() {
        _startTimeOfDay = value!;
      });
    });
  }

  void _showEndTimePicker() {
    showTimePicker(
      context: context,
      initialTime: _startTimeOfDay
    ).then ((value) {
      setState(() {
        _endTimeOfDay = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New Note'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: contentController,
            decoration: const InputDecoration(labelText: 'Content'),
          ),
          TextField(
            controller: dateController,
            decoration: const InputDecoration(labelText: 'Date Created'),
          ),
          // TextField(
          //   controller: startTimeController,
          //   decoration: const InputDecoration(labelText: 'Start Time'),
          // ),
          MaterialButton(
            onPressed: _showStartTimePicker,
            child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(_startTimeOfDay.format(context).toString(),
              style: const TextStyle(color: Colors.grey, fontSize: 20)),
            )
          ),
          // TextField(
          //   controller: endTimeController,
          //   decoration: const InputDecoration(labelText: 'End Time'),
          // ),
          MaterialButton(
            onPressed: _showEndTimePicker,
            child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(_endTimeOfDay.format(context).toString(),
              style: const TextStyle(color: Colors.grey, fontSize: 20)),
            )
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              String title = titleController.text;
              String content = contentController.text;
              String dateCreated = dateController.text;
              // String startTime = startTimeController.text;
              // String endTime = endTimeController.text;
              // Note newNote = Note(title, content, dateCreated, startTime, endTime);
              Note newNote = Note(title, content, dateCreated, _startTimeOfDay, _endTimeOfDay); // add onto class
              setState(() {
                list.add(newNote);
              });
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
class Note {
  // String title, content, dateCreated, startTime, endTime;
  String title, content, dateCreated;
  TimeOfDay start, end;

  final DateTime today = DateTime.now();

  // Note(this.title, this.content, this.dateCreated, this.startTime, this.endTime); //updated this
  Note(this.title, this.content, this.dateCreated, this.start, this.end); //updated this

  String getTitle() => title;

  String getContentPreview() => content;

  String getDateCreated() => dateCreated;

  Appointment getAppointment() => Appointment(
    startTime: DateTime(today.year, today.month, today.day, start.hour, start.minute),
    endTime: DateTime(today.year, today.month, today.day, end.hour, end.minute),
    subject: title,
    color: Colors.blue);

  // meetings.add(Appointment(
  //   startTime: startTime,
  //   endTime: endTime,
  //   subject: 'Conference',
  //   color: Colors.blue));
}