import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_homescreen/layout_size_helper.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Timer _timer;

  double speed = 20;
  // between 0 and 1.0
  double rpm = 0.2;
  // between 0 and 1.0
  double fuel = 0.2;

  @override
  void initState() {
    _timer = new Timer.periodic(
      Duration(milliseconds: 10),
      (Timer timer) {
        setState(() {
          double now = DateTime.now().millisecondsSinceEpoch / 1000;
          speed = 50 + 40 * sin(now);
          rpm = 0.5 + sin(now) / 3.0;
          fuel = 0.6 + cos(now) / 4.0;
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
    var sizeHelper = LayoutSizeHelper(context);
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.teal.shade900, Colors.grey.shade900])),
      constraints: BoxConstraints.expand(),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${speed.floor()} kpm',
            style: Theme.of(context).textTheme.headline2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _TireWidget('Left front tire', 21, CrossAxisAlignment.end),
                    SizedBox(
                      height: sizeHelper.largeIconSize,
                    ),
                    _TireWidget('Left rear tire', 23, CrossAxisAlignment.end),
                  ],
                ),
              ),
              Image.asset(
                'images/HMI_Dashboard_Car_720.png',
                width: sizeHelper.largeIconSize,
                fit: BoxFit.contain,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TireWidget(
                        'Right front tire', 21, CrossAxisAlignment.start),
                    SizedBox(
                      height: sizeHelper.largeIconSize,
                    ),
                    _TireWidget(
                        'Right rear tire', 23, CrossAxisAlignment.start),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _RPMWidget(rpm),
              _FuelWidget(fuel),
            ],
          )
        ],
      ),
    );
  }
}

class _TireWidget extends StatelessWidget {
  String label;
  int value;
  CrossAxisAlignment crossAlign;

  _TireWidget(this.label, this.value, this.crossAlign);

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);
    return Column(crossAxisAlignment: crossAlign, children: [
      Text(
        label,
        style: Theme.of(context).textTheme.caption,
      ),
      Text(
        '$value PSI',
        style: Theme.of(context).textTheme.headline5,
      )
    ]);
  }
}

class _RPMWidget extends StatelessWidget {
  double rpm;

  _RPMWidget(this.rpm);

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          'RPM',
          style: Theme.of(context).textTheme.headline4,
        ),
        Container(
          height: sizeHelper.largeIconSize,
          width: sizeHelper.largeIconSize,
          child: RotatedBox(
            quarterTurns: 2,
            child: CircularProgressIndicator(
              value: rpm,
              strokeWidth: sizeHelper.largeIconSize / 4.0,
              semanticsLabel: 'RPM indicator',
            ),
          ),
        )
      ],
    );
  }
}

class _FuelWidget extends StatelessWidget {
  double fuel;

  _FuelWidget(this.fuel);

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);
    return Row(
      children: [
        Text(
          'Fuel',
          style: Theme.of(context).textTheme.headline4,
        ),
        Container(
          height: sizeHelper.largeIconSize / 4.0,
          width: sizeHelper.largeIconSize,
          margin: EdgeInsets.all(sizeHelper.largePadding),
          child: LinearProgressIndicator(
            value: fuel,
            semanticsLabel: 'RPM indicator',
          ),
        )
      ],
    );
  }
}
