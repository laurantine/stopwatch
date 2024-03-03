import 'package:flutter/material.dart';

import 'dart:async';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

bool isTicking = false;

class _StopwatchState extends State<Stopwatch> {
  int seconds = 0;
  late Timer timer;
  @override
  // void initState() {
  //   super.initState();
  //   timer = Timer.periodic(Duration(seconds: 1), _onTick);
  // }

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
    void _startTimer() {
      timer = Timer.periodic(const Duration(seconds: 1), _onTick);
      setState(() {
        seconds = 0;
        isTicking = true;
      });
    }

    void _stopTimer() {
      timer.cancel();
      setState(() {
        isTicking = false;
      });
    }

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$seconds ${_secondsText()}',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: isTicking ? null : _startTimer,
                child: const Text('Start'),
              ),
              const SizedBox(width: 20),
              TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white)),
                onPressed: isTicking ? _stopTimer : null,
                child: const Text('Stop'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
