import 'package:flutter/material.dart';
import 'package:flutter_homescreen/layout_size_helper.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({Key? key}) : super(key: key);

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
    var sizeHelper = LayoutSizeHelper(context);
    return Container(
        color: Colors.deepPurple.shade50,
        child: Center(
            child: Container(
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
              _createMediaButton(
                    Icons.skip_previous,
                    sizeHelper.defaultIconSize,
                    () {},
                  ),
                  _createMediaButton(
                    Icons.play_arrow,
                    sizeHelper.defaultIconSize,
                    () {},
                  ),
                  _createMediaButton(
                    Icons.skip_next,
                    sizeHelper.defaultIconSize,
                    () {},
                  ),
            ],
          )
        ],
      ),
    )));
  }
}
