import 'package:flutter/material.dart';
import 'package:to_do_app/calendar_screen.dart';
import 'package:to_do_app/home_screen.dart';

List<Note> list = [Note('Homework','Finish App Development Homework','3/5/2023', '13', '14')];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: const Color.fromARGB(255, 97, 97, 97),
      ),
      initialRoute: '/todo',
      routes: {
        '/todo' : (context) => const ToDoScreen(),
        '/Calendar': (context) => const CalendarScreen(),
      },
      home: const MainScreen(), // Using a home property to define the main screen
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const CalendarScreen(),
    const ToDoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'To-Do',
          ),
        ],
      ),
    );
  }
}
