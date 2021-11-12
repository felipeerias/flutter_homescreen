import 'package:flutter/material.dart';

class HVACPage extends StatelessWidget {

  const HVACPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lime.shade50,
      constraints: BoxConstraints.expand(),
      alignment: Alignment.center,
      child: Text(
        'HVAC',
        style: Theme.of(context).textTheme.headline1,
        ),
    );
  }
}
