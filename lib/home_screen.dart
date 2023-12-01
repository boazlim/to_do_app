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
        title: const Text('To Do List'),
        backgroundColor: const Color.fromARGB(255, 51, 153, 255),
      ),
      body: Center(
        child: Theme(
          data: ThemeData(canvasColor: Colors.transparent),
          child: ReorderableListView(
            padding: EdgeInsets.only(top: 15,left: 15, right: 15),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final Note item = list.removeAt(oldIndex);
                list.insert(newIndex, item);
              });
            },
            children: List.generate(
              list.length,
              (int index) {
                final Note currentItem = list[index];
                return Container(
                  key: ValueKey(index),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 250, 250, 250),
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: Offset(4, 4),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentItem.getTitle(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(currentItem.getContentPreview()),
                      const SizedBox(height: 8),
                      Text(currentItem.getDateCreated()),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return EditNoteWidget(
                                    currentItem,
                                    onNoteEdited: () {
                                      setState(() {}); // Trigger a rebuild when the note is edited
                                    },
                                  );
                                },
                              );
                            },
                            child: const Text('Edit'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                list.removeAt(index);
                              });
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
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
class EditNoteWidget extends StatefulWidget {
  final Note note;
  final VoidCallback onNoteEdited; // New callback

  const EditNoteWidget(this.note, {required this.onNoteEdited, Key? key})
      : super(key: key);

  @override
  _EditNoteWidgetState createState() => _EditNoteWidgetState();
}

class _EditNoteWidgetState extends State<EditNoteWidget> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.getTitle());
    contentController = TextEditingController(text: widget.note.getContentPreview());
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Note'),
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
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.note.setTitle(titleController.text);
            widget.note.setContent(contentController.text);
            widget.onNoteEdited(); // Trigger the callback
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
      ],
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
          MaterialButton(
            onPressed: _showStartTimePicker,
            child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(_startTimeOfDay.format(context).toString(),
              style: const TextStyle(color: Colors.grey, fontSize: 20)),
            )
          ),
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
  void setTitle(String s) {
    title = s;
  }
  String getContentPreview() => content;
  void setContent(String s) {
    content = s;
  }
  String getDateCreated() => dateCreated;

  Appointment getAppointment() => Appointment(
    startTime: DateTime(today.year, today.month, today.day, start.hour, start.minute),
    endTime: DateTime(today.year, today.month, today.day, end.hour, end.minute),
    subject: title,
    color: Colors.blue);
  }