// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/contacts_list.dart';
import 'screens/grid_demo.dart';
import 'screens/shared_prefs.dart';
import 'screens/async_demo.dart';
import 'screens/isolate_demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab Exercises',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  final List<Widget> _screens = [
    ContactsListScreen(),
    GridDemoScreen(),
    SharedPrefsScreen(),
    AsyncDemoScreen(),
    IsolateDemoScreen(),
  ];

  final List<String> _titles = [
    'ListView Contacts',
    'GridView Demo',
    'Shared Preferences',
    'Async Demo',
    'Isolate Demo',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
      ),

      body: _screens[_index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),

        backgroundColor: Colors.black87,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_on), label: 'Grid'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Prefs'),
          BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Async'),
          BottomNavigationBarItem(icon: Icon(Icons.memory), label: 'Isolate'),
        ],
      ),
    );
  }
}
