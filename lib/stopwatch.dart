import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter/widgets.dart';

class Stopwatch extends StatefulWidget {
  const Stopwatch({super.key});

  @override
  State<Stopwatch> createState() => _StopwatchState();
}

bool isTicking = false;

class _StopwatchState extends State<Stopwatch> {
  int milliseconds = 0;
  late Timer timer;
  final laps = <int>[];
  @override
  // void initState() {
  //   super.initState();
  //   timer = Timer.periodic(Duration(seconds: 1), _onTick);
  // }

  void _onTick(Timer timer) {
    if (mounted) {
      setState(() {
        milliseconds += 100;
      });
    }
  }

  void _lap() {
    setState(() {
      laps.add(milliseconds);
      milliseconds = 0;
    });
  }

  String _secondsText(int milliseconds) {
    final seconds = milliseconds / 1000;
    return '$seconds seconds';
  }

  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers, unused_element
    // String _secondsText(int milliseconds) {
    //   final seconds = milliseconds / 1000;
    //   return '$seconds seconds';
    // }

    void _startTimer() {
      timer = Timer.periodic(const Duration(milliseconds: 100), _onTick);
      setState(() {
        laps.clear();
        milliseconds = 0;
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
    Widget _buildLapDisplay() {
      return ListView(
        children: [
          for (int milliseconds in laps)
            ListTile(
              title: Text(_secondsText(milliseconds)),
            )
        ],
      );
    }

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
        children: [
          Expanded(child: _buildCounter(context, _startTimer, _stopTimer)),
          Expanded(child: _buildLapDisplay()),
        ],
      ),
    );
  }

  Widget _buildCounter(
      BuildContext context, void _startTimer(), void _stopTimer()) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Lap ${laps.length + 1}',
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
          Text(
            _secondsText(milliseconds),
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Colors.white),
          ),
          _buildControls(_startTimer, _stopTimer)
        ],
      ),
    );
  }

  Widget _buildControls(void _startTimer(), void _stopTimer()) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: isTicking ? null : _startTimer,
          child: const Text('Start'),
        ),
        const SizedBox(width: 20),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: isTicking ? _lap : null,
          child: const Text('Lap'),
        ),
        const SizedBox(width: 20),
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white)),
          onPressed: isTicking ? _stopTimer : null,
          child: const Text('Stop'),
        ),
      ],
    );
  }
}
