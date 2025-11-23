// lib/screens/shared_prefs.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsScreen extends StatefulWidget {
  @override
  _SharedPrefsScreenState createState() => _SharedPrefsScreenState();
}

class _SharedPrefsScreenState extends State<SharedPrefsScreen> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  String _display = 'No saved data yet.';
  String _timestamp = '';

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameCtrl.text.trim());
    if (_ageCtrl.text.trim().isNotEmpty) {
      await prefs.setInt('age', int.tryParse(_ageCtrl.text.trim()) ?? 0);
    } else {
      await prefs.remove('age');
    }
    await prefs.setString('email', _emailCtrl.text.trim());
    final now = DateTime.now().toIso8601String();
    await prefs.setString('saved_at', now);
    setState(() {
      _display = 'Saved.';
      _timestamp = now;
    });
  }

  Future<void> _show() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    if (name == null || name.isEmpty) {
      setState(() => _display = 'No name saved.');
      return;
    }
    final age = prefs.getInt('age');
    final email = prefs.getString('email');
    final savedAt = prefs.getString('saved_at') ?? '';
    setState(() {
      _display = 'Name: $name\nAge: ${age ?? '-'}\nEmail: ${email ?? '-'}';
      _timestamp = savedAt;
    });
  }

  Future<void> _clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('age');
    await prefs.remove('email');
    await prefs.remove('saved_at');
    setState(() {
      _display = 'Cleared saved data.';
      _timestamp = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          TextField(controller: _nameCtrl, decoration: InputDecoration(labelText: 'Name')),
          SizedBox(height: 8),
          TextField(controller: _ageCtrl, decoration: InputDecoration(labelText: 'Age'), keyboardType: TextInputType.number),
          SizedBox(height: 8),
          TextField(controller: _emailCtrl, decoration: InputDecoration(labelText: 'Email'), keyboardType: TextInputType.emailAddress),
          SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton(onPressed: _save, child: Text('Save Name')),
              SizedBox(width: 8),
              ElevatedButton(onPressed: _show, child: Text('Show Name')),
              SizedBox(width: 8),
              OutlinedButton(onPressed: _clear, child: Text('Clear')),
            ],
          ),
          SizedBox(height: 12),
          Align(alignment: Alignment.centerLeft, child: Text('Result:')),
          SizedBox(height: 6),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
            child: Text(_display),
          ),
          if (_timestamp.isNotEmpty) ...[
            SizedBox(height: 8),
            Text('Last saved: $_timestamp', style: TextStyle(fontStyle: FontStyle.italic)),
          ],
        ],
      ),
    );
  }
}
