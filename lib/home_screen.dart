import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

List<Note> list = [Note('Homework','Finish App Development Homework','3/5/2023', '13', '14')];

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  _ToDoScreenState createState() => _ToDoScreenState();
}
class _ToDoScreenState extends State<ToDoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 249, 180),
      appBar: AppBar(
        title: const Text('Notes'),
        backgroundColor: const Color.fromARGB(255, 142, 93, 28),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: const Color.fromARGB(255, 185, 183, 169), // Set your desired color
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
  final TextEditingController startTimeController = TextEditingController(text: '9');
  final TextEditingController endTimeController = TextEditingController(text: '10');

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
          TextField(
            controller: startTimeController,
            decoration: const InputDecoration(labelText: 'Start Time'),
          ),
          TextField(
            controller: endTimeController,
            decoration: const InputDecoration(labelText: 'End Time'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              String title = titleController.text;
              String content = contentController.text;
              String dateCreated = dateController.text;
              String startTime = startTimeController.text;
              String endTime = endTimeController.text;
              Note newNote = Note(title, content, dateCreated, startTime, endTime);
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
  String title, content, dateCreated, startTime, endTime;
  final DateTime today = DateTime.now();


  Note(this.title, this.content, this.dateCreated, this.startTime, this.endTime); //updated this

  String getTitle() => title;

  String getContentPreview() => content;

  String getDateCreated() => dateCreated;

  Appointment getAppointment() => Appointment(
    startTime: DateTime(today.year, today.month, today.day, int.parse(startTime),0,0),
    endTime: DateTime(today.year, today.month, today.day, int.parse(endTime),0,0),
    subject: title,
    color: Colors.blue);

  // meetings.add(Appointment(
  //   startTime: startTime,
  //   endTime: endTime,
  //   subject: 'Conference',
  //   color: Colors.blue));
}