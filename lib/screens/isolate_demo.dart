// lib/screens/isolate_demo.dart
import 'dart:async';
import 'dart:isolate';
import 'dart:math';
import 'package:flutter/material.dart';

class IsolateDemoScreen extends StatefulWidget {
  @override
  _IsolateDemoScreenState createState() => _IsolateDemoScreenState();
}

class FactorialRequest {
  final SendPort port;
  final int n;
  FactorialRequest(this.port, this.n);
}

class _IsolateDemoScreenState extends State<IsolateDemoScreen> {
  String _status = 'Idle';
  String _result = '';
  double _progress = 0.0;
  bool _running = false;
  Isolate? _worker;
  ReceivePort? _receivePort;

  Future<void> _startFactorial(int n) async {
    if (_running) return;
    if (n > 10000) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Warning'),
          content: Text('Computing factorial of $n may take a very long time and consume huge memory. Continue?'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancel')),
            TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Continue')),
          ],
        ),
      );
      if (ok != true) return;
    }

    setState(() {
      _running = true;
      _status = 'Starting...';
      _progress = 0.0;
      _result = '';
    });

    _receivePort = ReceivePort();
    _worker = await Isolate.spawn(_factorialIsolateEntry, FactorialRequest(_receivePort!.sendPort, n));

    _receivePort!.listen((message) {
      if (message is double) {
        setState(() {
          _progress = message;
          _status = 'Progress: ${(_progress * 100).toStringAsFixed(1)}%';
        });
      } else if (message is String && message.startsWith('RESULT:')) {
        setState(() {
          _result = message.substring(7);
          _status = 'Completed';
          _running = false;
        });
        _receivePort!.close();
        _worker?.kill(priority: Isolate.immediate);
        _worker = null;
      } else if (message is String && message.startsWith('ERROR:')) {
        setState(() {
          _status = 'Error: ${message.substring(6)}';
          _running = false;
        });
        _receivePort!.close();
        _worker?.kill(priority: Isolate.immediate);
        _worker = null;
      }
    });
  }

  static void _factorialIsolateEntry(FactorialRequest req) {
    final send = req.port;
    final n = req.n;
    try {
      BigInt result = BigInt.one;
      final chunk = max(1, n ~/ 100);
      for (int i = 1; i <= n; i++) {
        result *= BigInt.from(i);
        if (i % chunk == 0) {
          double prog = i / n;
          send.send(prog);
        }
      }
      send.send(1.0);
      send.send('RESULT:${result.toString()}');
    } catch (e) {
      send.send('ERROR:${e.toString()}');
    }
  }

  @override
  void dispose() {
    _receivePort?.close();
    _worker?.kill(priority: Isolate.beforeNextEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nController = TextEditingController();
    nController.text = '500';
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            'Factorial with Isolate (use caution). Default n=500. For testing use n=100..500.',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: nController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'n (compute n!)'),
                ),
              ),
              SizedBox(width: 8),
              ElevatedButton(
                  onPressed: () {
                    final n = int.tryParse(nController.text.trim()) ?? 500;
                    _startFactorial(n);
                  },
                  child: Text('Start')),
            ],
          ),
          SizedBox(height: 12),
          LinearProgressIndicator(value: _running ? _progress : null),
          SizedBox(height: 8),
          Text(_status),
          SizedBox(height: 12),
          Expanded(
            child: SingleChildScrollView(
              child: SelectableText(_result.isEmpty ? 'Result will appear here (may be huge).' : _result),
            ),
          ),
        ],
      ),
    );
  }
}
