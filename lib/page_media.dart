import 'dart:math';

import 'package:flutter/material.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({Key? key}) : super(key: key);

  Widget _buildLayout(BuildContext context, BoxConstraints constraints) {
    // describe the layout in terms of fractions of the container size
    double mainDimension = max(constraints.maxWidth, constraints.maxHeight);
    //double minDimension = min(constraints.maxWidth, constraints.maxHeight);
    double iconSize = mainDimension / 12.0;

    return Container(
      color: Colors.blueGrey.shade900,
      constraints: BoxConstraints.expand(),
      alignment: Alignment.center,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                      colors: [
                    Colors.blueGrey.shade700,
                    Colors.blueGrey.shade400
                  ])),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _createMediaButton(Icons.skip_previous, iconSize, () {}),
              _createMediaButton(Icons.play_arrow, iconSize, () {}),
              _createMediaButton(Icons.skip_next, iconSize, () {}),
            ],
          )
        ],
      ),
    );
  }

  Widget _createMediaButton(
      IconData icon, double iconSize, Null Function() onPressed) {
    return Padding(
      padding: EdgeInsets.all(iconSize / 8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Icon(
          icon,
          color: Colors.blueGrey.shade700,
          size: iconSize,
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(iconSize / 8),
          primary: Colors.blueGrey.shade100,
          onPrimary: Colors.white,
        ),
      ), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.deepPurple.shade50,
        child: Center(
            child: LayoutBuilder(
          builder: _buildLayout,
        )));
  }
}
