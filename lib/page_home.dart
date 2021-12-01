import 'package:flutter/material.dart';
import 'package:flutter_homescreen/layout_size_helper.dart';

class HomePage extends StatelessWidget {
  final Function(int index) onSetNavigationIndex;

  const HomePage({Key? key, required this.onSetNavigationIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeHelper = LayoutSizeHelper(context);
    return Container(
        color: Colors.lightBlue.shade50,
        constraints: BoxConstraints.expand(),
        alignment: Alignment.center,
        child: Wrap(
          spacing: themeHelper.largePadding,
          runSpacing: themeHelper.largePadding,
          children: <Widget>[
            createItem(themeHelper, Icons.drive_eta, 1),
            createItem(themeHelper, Icons.thermostat, 2),
            createItem(themeHelper, Icons.music_note, 3)
          ],
        ));
  }

  Widget createItem(
      LayoutSizeHelper themeHelper, IconData icon, int tabPosition) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(themeHelper.largePadding),
          primary: Colors.lightBlue.shade400,
          side: BorderSide(
              width: themeHelper.defaultBorder,
              color: Colors.lightBlue.shade400),
        ),
        onPressed: () {
          onSetNavigationIndex(tabPosition);
        },
        child: Icon(
          icon,
          color: Colors.lightBlue.shade800,
          size: themeHelper.largeIconSize,
        ),
      ),
    );
  }
}
