import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class HVACPage extends StatelessWidget {

  const HVACPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      alignment: Alignment.center,
      child: const MainPage(title: 'AGL - Flutter HVAC'),
    );
  }
}

class _TemperatureSelector extends StatefulWidget {
  @override
  _TemperatureSelectorState createState() => _TemperatureSelectorState();
}

class _TemperatureSelectorState extends State<_TemperatureSelector> {
  int _currentValue = 22; // INIT FROM AGLJS wrapper

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NumberPicker(
          value: _currentValue,
          minValue: 18,
          maxValue: 25,
          onChanged: (value) => setState(() => _currentValue = value),
        ),
      ],
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class HVACFanSpeed extends StatefulWidget {
  const HVACFanSpeed({Key? key}) : super(key: key);
  @override
  State<HVACFanSpeed> createState() => _HVACFanSpeedState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _HVACFanSpeedState extends State<HVACFanSpeed> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentSliderValue,
      min: 0,
      max: 300,
      label: _currentSliderValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _currentSliderValue = value;
        });
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MainPage> createState() => _MyHomePageState();
}

String chairOn = 'images/HMI_HVAC_Left_Chair_ON.png';
String chairOff = 'images/HMI_HVAC_Right_Chair_ON.png';
bool selected = true; // Get from API

class _MyHomePageState extends State<MainPage> {
  final double fanSpeed = 20;

  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(flex: 2, child: const HVACFanSpeed()),
        Image.asset('images/HMI_HVAC_Fan_Icon.png',
            width: 100, height: 100, fit: BoxFit.cover),
      ],
    ),
  );

  Widget rightSeat = Container(
    padding: const EdgeInsets.all(32),
    child: Column(
      children: [
        IconButton(
          iconSize: 100.0,
          icon: Image.asset(selected ? chairOn : chairOff,
              width: 100, height: 100, fit: BoxFit.cover),
          onPressed: () {
            selected = !selected;
          },
        ),
        _TemperatureSelector(),
      ],
    ),
  );

  Widget leftSeat = Container(
    padding: const EdgeInsets.all(32),
    child: Column(
      children: [
        Image.asset('images/HMI_HVAC_Right_Chair_ON.png',
            width: 100, height: 100, fit: BoxFit.cover),
        _TemperatureSelector()
      ],
    ),
  );

  Widget centerView = Container(
    padding: const EdgeInsets.all(32),
    child: Column(
      children: [
        Container(
          width: 140,
          height: 100,
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(20)),
          child: OutlinedButton(
            onPressed: () {
              // Respond to button press
            },
            child: Text("A / C"),
          ),
        ),
        Container(
          width: 140,
          height: 100,
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(20)),
          child: OutlinedButton(
            onPressed: () {
              // Respond to button press
            },
            child: Text("Auto"),
          ),
        ),
        Container(
          width: 140,
          height: 100,
          margin: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(20)),
          child: OutlinedButton(
              onPressed: () {
                // Respond to button press
              },
              child: Image.asset('images/HMI_HVAC_Circulation_Inactive.png',
                  width: 100, height: 100, fit: BoxFit.cover)),
        ),
      ],
    ),
  );
  Widget actions = Container(
    padding: const EdgeInsets.all(32),
    child: Column(
      children: [
        Image.asset('images/HMI_HVAC_AirDown_Inactive.png',
            width: 100, height: 100, fit: BoxFit.cover),
        Image.asset('images/HMI_HVAC_AirUp_Inactive.png',
            width: 100, height: 100, fit: BoxFit.cover),
        Image.asset('images/HMI_HVAC_Front_Inactive.png',
            width: 100, height: 100, fit: BoxFit.cover),
        Image.asset('images/HMI_HVAC_Rear_Active.png',
            width: 100, height: 100, fit: BoxFit.cover),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.teal.shade900])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              titleSection,
              Row(children: [
                Expanded(flex: 2, child: rightSeat),
                Expanded(flex: 2, child: centerView),
                Expanded(flex: 2, child: leftSeat),
                Expanded(flex: 2, child: actions)
              ])
            ],
          ),
        ));
  }
}
