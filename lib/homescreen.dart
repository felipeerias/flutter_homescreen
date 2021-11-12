import 'package:flutter/material.dart';
import 'package:flutter_homescreen/page_dashboard.dart';
import 'package:flutter_homescreen/page_home.dart';
import 'package:flutter_homescreen/page_hvac.dart';
import 'package:flutter_homescreen/page_media.dart';
import 'package:flutter_homescreen/widget_clock.dart';

class Homescreen extends StatefulWidget {
  Homescreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;

  setNavigationIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var iconSize = screenHeight / 5;

    return Scaffold(
      body: Row(
        children: <Widget>[
          Stack(
            children: [
              NavigationRail(
                backgroundColor: Colors.black12,
                selectedIndex: _selectedIndex,
                groupAlignment: -1.0,
                minWidth: iconSize,
                // leading widget?
                // trailing widget does not expand to bottom
                onDestinationSelected: (int index) {
                  setNavigationIndex(index);
                },
                selectedIconTheme: IconTheme.of(context).copyWith(
                  size: iconSize,
                  color: Theme.of(context).accentColor,
                ),
                unselectedIconTheme: IconTheme.of(context).copyWith(
                  size: iconSize,
                  color: Theme.of(context).unselectedWidgetColor,
                ),
                labelType: NavigationRailLabelType.none,
                destinations: <NavigationRailDestination>[
                  NavigationRailDestination(
                    icon: Icon(Icons.house_outlined),
                    selectedIcon: Icon(Icons.house),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.drive_eta_outlined),
                    selectedIcon: Icon(Icons.drive_eta),
                    label: Text('Dashboard'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.thermostat_outlined),
                    selectedIcon: Icon(Icons.thermostat),
                    label: Text('HVAC'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.music_note_outlined),
                    selectedIcon: Icon(Icons.music_note),
                    label: Text('Media'),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                // This is the info widget with time, date, etc.
                child: ClockWiddget(size: iconSize),
              )
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: Center(child: _childForIndex(_selectedIndex)),
          )
        ],
      ),
    );
  }

  Widget _childForIndex(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return HomePage(onSetNavigationIndex: setNavigationIndex);
      case 1:
        return DashboardPage();
      case 2:
        return HVACPage();
      case 3:
        return MediaPage();
      default:
        return Text('Undefined');
    }
  }
}

/*
ElevatedButton(
                child: const Text('Open app'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondRoute()),
                  );
                },
              ),

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

*/