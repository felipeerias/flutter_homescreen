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

class _HomescreenState extends State<Homescreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  int _previousIndex = 0;

  setNavigationIndex(int index) {
    setState(() {
      _previousIndex = _selectedIndex;
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var iconSize = screenHeight / 6;
    var railSize = screenHeight / 5;

    return Scaffold(
      body: Row(
        children: <Widget>[
          Stack(
            children: [
              NavigationRail(
                backgroundColor: Colors.black12,
                selectedIndex: _selectedIndex,
                groupAlignment: -1.0,
                minWidth: railSize,
                // leading widget?
                // leading: Icon(Icons.house_outlined, size: iconSize),
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
                child: ClockWiddget(size: railSize),
              )
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // This is the main content.
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              reverseDuration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              transitionBuilder: (Widget child, Animation<double> animation) {
                if (child.key != ValueKey(_selectedIndex)) {
                  return FadeTransition(
                    opacity:
                        Tween<double>(begin: 1.0, end: 1.0).animate(animation),
                    child: child,
                  );
                }
                Offset beginOffset = new Offset(
                    0.0, (_selectedIndex > _previousIndex ? 1.0 : -1.0));
                return SlideTransition(
                  position: Tween<Offset>(begin: beginOffset, end: Offset.zero)
                      .animate(animation),
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Interval(0.5, 1.0),
                      ),
                    ),
                    child: child,
                  ),
                );
              },
              child: _childForIndex(_selectedIndex),
            ),
          )
        ],
      ),
    );
  }

  Widget _childForIndex(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return HomePage(
            key: ValueKey(selectedIndex),
            onSetNavigationIndex: setNavigationIndex);
      case 1:
        return DashboardPage(key: ValueKey(selectedIndex));
      case 2:
        return HVACPage(key: ValueKey(selectedIndex));
      case 3:
        return MediaPage(key: ValueKey(selectedIndex));
      default:
        return Text('Undefined');
    }
  }
}
