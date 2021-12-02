import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_homescreen/layout_size_helper.dart';

// The Dashboard page.
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
          double now = DateTime.now().millisecondsSinceEpoch / 2000;
          speed = 50 + 40 * sin(now);
          rpm = 0.5 + sin(now) / 3.0;
          fuel = 0.6 + cos(now) / 4.0;
        });
      },
    );
    // Animate the values for the demo.
    // Eventually, we will get the state of the car from the API.
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: sizeHelper.largeIconSize * 1,
                width: sizeHelper.largeIconSize * 2,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).primaryColorLight,
                      width: sizeHelper.defaultBorder,
                    ),
                    borderRadius: BorderRadius.all(
                        Radius.circular(sizeHelper.largeIconSize / 2.0))),
                child: Center(
                  child: Text(
                    '${speed.floor()} kpm',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
              ),
              _RPMWidget(rpm),
              _FuelWidget(fuel),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _TireWidget('Left front tire', 21, CrossAxisAlignment.end),
                  _TireWidget('Left rear tire', 23, CrossAxisAlignment.end),
                ],
              ),
              Image.asset(
                'images/HMI_Dashboard_Car_720.png',
                width: 2.0 * sizeHelper.largeIconSize,
                fit: BoxFit.contain,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _TireWidget('Right front tire', 21, CrossAxisAlignment.start),
                  _TireWidget('Right rear tire', 23, CrossAxisAlignment.start),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// The RPM indicator.
class _RPMWidget extends StatelessWidget {
  final double rpm;

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
          height: sizeHelper.largeIconSize * 1.5,
          width: sizeHelper.largeIconSize * 1.5,
          child: RotatedBox(
            quarterTurns: 2,
            child: CircularProgressIndicator(
              value: rpm,
              color: HSLColor.fromColor(Colors.redAccent)
                  .withSaturation(rpm)
                  .toColor(),
              strokeWidth: sizeHelper.largeIconSize / 2.0,
              semanticsLabel: 'RPM indicator',
            ),
          ),
        )
      ],
    );
  }
}

// The fuel indicator.
class _FuelWidget extends StatelessWidget {
  final double fuel;

  _FuelWidget(this.fuel);

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);
    return Row(
      children: [
        Container(
          height: sizeHelper.largeIconSize / 4.0,
          width: sizeHelper.largeIconSize / 2.0,
          child: Center(
            child: Text(
              'Fuel',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ),
        Container(
          height: sizeHelper.largeIconSize / 4.0,
          width: sizeHelper.largeIconSize * 1.5,
          margin: EdgeInsets.fromLTRB(
              0, sizeHelper.largePadding, 0, sizeHelper.largePadding),
          child: LinearProgressIndicator(
            value: fuel,
            color: HSLColor.fromColor(Colors.blueAccent)
                .withSaturation(fuel)
                .toColor(),
            semanticsLabel: 'RPM indicator',
          ),
        )
      ],
    );
  }
}

// The small indicator for the state of each tire.
class _TireWidget extends StatelessWidget {
  final String label;
  final int value;
  final CrossAxisAlignment crossAlign;

  _TireWidget(this.label, this.value, this.crossAlign);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAlign,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headline6,
        ),
        Text(
          '$value PSI',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}
