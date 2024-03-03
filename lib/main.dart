import 'package:flutter/material.dart';
import './stopwatch.dart';

void main() => runApp(const StopWatchApp());

class StopWatchApp extends StatelessWidget {
  const StopWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Stopwatch(),
    );
  }
}
