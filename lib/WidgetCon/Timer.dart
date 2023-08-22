
import 'dart:async';

import 'package:flutter/material.dart';

import '../Logic/SudokuCard.dart';
import '../Statics/StaticThings.dart';

class TimerText extends StatefulWidget {

  final String  gameTime;
  const TimerText({Key? key, required this.gameTime}) : super(key: key);

  @override
  State<TimerText> createState() => _TimerTextState();
}

class _TimerTextState extends State<TimerText> {
  late Timer _timer;
  Duration _duration = const Duration(minutes: 0, seconds: 0);
  late String _formattedTime;

  @override
  void initState() {
    super.initState();
    List<String> parts = widget.gameTime.split(':');
    _duration = Duration(minutes: int.parse(parts[0]), seconds: int.parse(parts[1]));
    _formattedTime = _formatDuration(_duration);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _duration += const Duration(seconds: 1);
        _formattedTime = _formatDuration(_duration);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    CardInfo.sudokuCardList[StaticThings.currentGameInd!].timer = _formattedTime;
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
        _formattedTime,
        style: const TextStyle(fontSize: 25)
    );
  }
}
