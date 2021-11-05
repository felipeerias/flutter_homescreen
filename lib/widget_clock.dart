import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockWiddget extends StatefulWidget {
  final double size;

  const ClockWiddget({Key? key, required this.size}) : super(key: key);

  @override
  _ClockWiddgetState createState() => _ClockWiddgetState();
}

class _ClockWiddgetState extends State<ClockWiddget> {
  late Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    _now = DateTime.now();
    _timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        setState(() {
          _now = DateTime.now();
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              DateFormat('EEEE').format(_now),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          const Divider(thickness: 1),
          FittedBox(
            fit: BoxFit.contain,
            child: Text(
              DateFormat.jm().format(_now),
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      alignment: Alignment.center,
    );
  }
}
