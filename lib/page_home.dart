import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Function(int index) onSetNavigationIndex;

  const HomePage({Key? key, required this.onSetNavigationIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double spacing = MediaQuery.of(context).size.width / 32;
    final double runSpacing = spacing / 2;
    return Container(
        color: Colors.lightBlue.shade50,
        constraints: BoxConstraints.expand(),
        alignment: Alignment.center,
        child: Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: <Widget>[
        createItem(context, Icons.drive_eta, 1),
        createItem(context, Icons.thermostat, 2),
        createItem(context, Icons.music_note, 3)
      ],
    ));
  }

  Widget createItem(BuildContext context, IconData icon, int tabPosition) {
    final double size = MediaQuery.of(context).size.width / 6;
    final double padding = size / 4;
    final double border = padding / 4;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(padding),
          primary: Colors.lightBlue.shade400,
            side: BorderSide(width: border, color: Colors.lightBlue.shade400)
        ),
        onPressed: () {
          onSetNavigationIndex(tabPosition);
        },
        child: Icon(
          icon,
          color: Colors.lightBlue.shade800,
          size: size / 2,
        ),
      ),
    );
  }
}
