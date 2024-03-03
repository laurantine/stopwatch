import 'package:flutter/material.dart';

import 'dart:async';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

class _StopwatchState extends State<Stopwatch> {
  int seconds = 0;
  late Timer timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer timer) {
    if (mounted) {
      setState(() {
        ++seconds;
      });
    }
  }

  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    String _secondsText() => seconds == 1 ? 'second' : 'seconds';
    @override
    // ignore: unused_element
    void dispose() {
      timer.cancel();
      super.dispose();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('StopWatch'),
      ),
      body: Center(
        child: Text(
          '$seconds ${_secondsText()}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
