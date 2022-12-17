import 'package:customer/core/model/park_history_model.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class CalculatorWidget extends StatefulWidget {
  final ParkHistory parkHistory;

  const CalculatorWidget({Key? key, required this.parkHistory}) : super(key: key);

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    super.initState();
    int min = DateTime.now().millisecondsSinceEpoch - widget.parkHistory.requestTime.millisecondsSinceEpoch;
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Total time: $value min",
            ),
            Text(
              "Total price ≈ ${(widget.parkHistory.startPrice + ((widget.parkHistory.hourlyPrice/60) * value!)).toStringAsFixed(2)} ₺",
            ),
          ],
        );
      },
    );
  }
}
