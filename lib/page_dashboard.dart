import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var iconSize = screenHeight / 8;

    return Container(
      color: Colors.indigo.shade50,
      constraints: BoxConstraints.expand(),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '0 kpm',
            style: Theme.of(context).textTheme.headline4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Left front tire',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Left rear tire',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
              Icon(
                Icons.drive_eta,
                size: iconSize,
                color: Colors.indigo.shade800,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Right front tire',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    'Right rear tire',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _RPMWidget(),
              Text(
                'Fuel',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ignore: unused_element
class _RPMWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.fastfood),
        Container(
          height: 20,
          width: 70,
          child: LinearProgressIndicator(
            value: 0.75,
            semanticsLabel: 'Linear progress indicator',
          ),
        ),
      ],
    );
  }
}
