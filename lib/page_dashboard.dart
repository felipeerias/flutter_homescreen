import 'package:flutter/material.dart';
import 'package:flutter_homescreen/layout_size_helper.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

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
            '0 kpm',
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
                    Text(
                      'Left front tire',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      height: sizeHelper.largeIconSize,
                    ),
                    Text(
                      'Left rear tire',
                      style: Theme.of(context).textTheme.headline4,
                    ),
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
                    Text(
                      'Right front tire',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      height: sizeHelper.largeIconSize,
                    ),
                    Text(
                      'Right rear tire',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _RPMWidget(),
              _FuelWidget(),
            ],
          )
        ],
      ),
    );
  }
}

class _RPMWidget extends StatelessWidget {
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
              value: 0.75,
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
            value: 0.75,
            semanticsLabel: 'RPM indicator',
          ),
        )
      ],
    );
  }
}
