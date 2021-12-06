import 'package:flutter/material.dart';
import 'package:flutter_homescreen/homescreen.dart';
import 'package:flutter_homescreen/layout_size_helper.dart';

// The Home page.
class HomePage extends StatelessWidget {
  final Function(int index) onSetNavigationIndex;

  const HomePage({Key? key, required this.onSetNavigationIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blueGrey.shade800, Colors.grey.shade900])),
        constraints: BoxConstraints.expand(),
        alignment: Alignment.center,
        child: Wrap(
          spacing: sizeHelper.largePadding,
          runSpacing: sizeHelper.largePadding,
          children: <Widget>[
            _HomePageEntry(
              label: "DASHBOARD",
              icon: Icons.drive_eta,
              onPressed: () {
                onSetNavigationIndex(PageIndex.dashboard.index);
              },
            ),
            _HomePageEntry(
              label: "HVAC",
              icon: Icons.thermostat,
              onPressed: () {
                onSetNavigationIndex(PageIndex.hvac.index);
              },
            ),
            _HomePageEntry(
              label: "MEDIA",
              icon: Icons.music_note,
              onPressed: () {
                onSetNavigationIndex(PageIndex.media.index);
              },
            ),
            _HomePageEntry(
              label: "DEMO 3D",
              icon: Icons.view_in_ar,
              onPressed: () {
                onSetNavigationIndex(PageIndex.demo3d.index);
              },
            ),
          ],
        ));
  }
}

// Each one of the items on the Home page.
class _HomePageEntry extends StatelessWidget {
  final String label;
  final IconData icon;
  final Null Function() onPressed;

  const _HomePageEntry(
      {Key? key,
      required this.label,
      required this.icon,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            OutlinedButton(
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(sizeHelper.largePadding),
                side: BorderSide(
                    width: sizeHelper.defaultBorder,
                    color: Colors.lightBlue.shade100),
              ),
              onPressed: onPressed,
              child: Icon(
                icon,
                color: Colors.lightBlue.shade50,
                size: sizeHelper.largeIconSize,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(sizeHelper.defaultPadding),
              child: Text(
                label,
                style: DefaultTextStyle.of(context).style.copyWith(
                      fontSize: sizeHelper.baseFontSize,
                      color: Colors.lightBlue.shade100,
                    ),
              ),
            ),
          ],
        ));
  }
}
