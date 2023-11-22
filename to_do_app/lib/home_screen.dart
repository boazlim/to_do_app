import 'package:flutter/material.dart';

List<Note> list = [Note('Homework','Finish App Development Homework','3/5/2023')];

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
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              String title = titleController.text;
              String content = contentController.text;
              String dateCreated = dateController.text;
              Note newNote = Note(title, content, dateCreated);
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
  String title, content, dateCreated;

  Note(this.title, this.content, this.dateCreated);

  String getTitle() => title;

  String getContentPreview() => content;

  String getDateCreated() => dateCreated;
}