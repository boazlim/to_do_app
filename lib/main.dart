import 'package:flutter/material.dart';
import 'package:to_do_app/calendar_screen.dart';
import 'package:to_do_app/home_screen.dart';


List<Note> list = [];

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const CalendarScreen(),
    const ToDoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: const Color.fromARGB(255, 97, 97, 97),
      ),
      // initialRoute: '/todo',
      routes: {
        '/todo' : (context) => const ToDoScreen(),
        '/Calendar': (context) => const CalendarScreen(),
      },
      home: Scaffold(
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
      )
    );
  }
}