import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      constraints: BoxConstraints.expand(),
      alignment: Alignment.center,
      child: Text(
        'Dashboard',
        style: Theme.of(context).textTheme.headline1,
        ),
    );
  }
}
