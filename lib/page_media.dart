import 'package:flutter/material.dart';

class MediaPage extends StatelessWidget {

  const MediaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurple.shade50,
      constraints: BoxConstraints.expand(),
      alignment: Alignment.center,
      child: Text(
        'Media',
        style: Theme.of(context).textTheme.headline1,
        ),
    );
  }
}
