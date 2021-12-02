import 'package:flutter/material.dart';
import 'package:flutter_homescreen/page_dashboard.dart';
import 'package:flutter_homescreen/page_home.dart';
import 'package:flutter_homescreen/page_hvac.dart';
import 'package:flutter_homescreen/page_media.dart';
import 'package:flutter_homescreen/widget_clock.dart';

enum PageIndex { home, dashboard, hvac, media, demo3d }

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

  Widget _childForIndex(int selectedIndex) {
    switch (PageIndex.values[selectedIndex]) {
      case PageIndex.home:
        return HomePage(
            key: ValueKey(selectedIndex),
            onSetNavigationIndex: setNavigationIndex);
      case PageIndex.dashboard:
        return DashboardPage(key: ValueKey(selectedIndex));
      case PageIndex.hvac:
        return HVACPage(key: ValueKey(selectedIndex));
      case PageIndex.media:
        return MediaPage(key: ValueKey(selectedIndex));
      case PageIndex.demo3d:
        return Text('3D demo');
      default:
        return Text('Undefined');
    }
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

  Widget _buildLayout(BuildContext context, BoxConstraints constraints) {
    // size the icons so they cover the left edge of the screen
    var iconSize = constraints.maxHeight / (PageIndex.values.length + 2);
    var railSize = constraints.maxHeight / (PageIndex.values.length + 1);

    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                  Colors.blueGrey.shade800,
                  Colors.blueGrey.shade900
                ])),
            child: Stack(
              children: [
                NavigationRail(
                  backgroundColor: Colors.transparent,
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
                    color: Colors.orangeAccent.shade100,
                  ),
                  unselectedIconTheme: IconTheme.of(context).copyWith(
                    size: iconSize,
                    color: Colors.blueGrey.shade400,
                  ),
                  labelType: NavigationRailLabelType.none,
                  destinations: <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.house),
                      selectedIcon: Icon(Icons.house),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.drive_eta),
                      selectedIcon: Icon(Icons.drive_eta),
                      label: Text('Dashboard'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.thermostat),
                      selectedIcon: Icon(Icons.thermostat),
                      label: Text('HVAC'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.music_note),
                      selectedIcon: Icon(Icons.music_note),
                      label: Text('Media'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.view_in_ar),
                      selectedIcon: Icon(Icons.view_in_ar),
                      label: Text('3D example'),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  // This is the info widget with time, date, etc.
                  child: ClockWiddget(
                    size: railSize,
                    textColor: Colors.blueGrey.shade100,
                  ),
                )
              ],
            ),
          ),
          VerticalDivider(
            thickness: 1,
            width: 1,
            color: Colors.grey.shade900,
          ),
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
}
