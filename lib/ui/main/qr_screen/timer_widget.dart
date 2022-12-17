import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerWidget extends StatefulWidget {
  final Timestamp timestamp;

  const TimerWidget({Key? key, required this.timestamp}) : super(key: key);

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    super.initState();
    int min = DateTime.now().millisecondsSinceEpoch - widget.timestamp.millisecondsSinceEpoch;
    _stopWatchTimer.setPresetTime(mSec: min);

    _stopWatchTimer.onStartTimer();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _stopWatchTimer.minuteTime,
      initialData: _stopWatchTimer.minuteTime.value,
      builder: (context, snap) {
        final value = snap.data;
        return Text(
          "Total time: $value min",
        );
      },
    );
  }
}
