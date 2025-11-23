// lib/screens/async_demo.dart
import 'package:flutter/material.dart';

class AsyncDemoScreen extends StatefulWidget {
  @override
  _AsyncDemoScreenState createState() => _AsyncDemoScreenState();
}

class _AsyncDemoScreenState extends State<AsyncDemoScreen> {
  String _status = '';

  Future<void> _loadUser() async {
    setState(() => _status = 'Loading user...');
    await Future.delayed(Duration(seconds: 3));
    setState(() => _status = 'User loaded successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_status.isEmpty ? 'Press the button' : _status),
          SizedBox(height: 12),
          ElevatedButton(onPressed: _loadUser, child: Text('Start Loading')),
        ],
      ),
    );
  }
}
