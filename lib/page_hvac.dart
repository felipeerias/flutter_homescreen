import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class HVACPageContainer extends StatelessWidget {
  const HVACPageContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      alignment: Alignment.center,
      child: const HVACPage(title: 'AGL - Flutter HVAC'),
    );
  }
}

class _TemperatureSelector extends StatefulWidget {
final double referenceFontSize = 24;

  _TemperatureSelector({Key? key, referenceFontSize}) : super(key: key);

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
          textStyle: DefaultTextStyle.of(context).style.copyWith(
                color: Colors.teal.shade200,
                fontSize: widget.referenceFontSize,
              ),
          selectedTextStyle: DefaultTextStyle.of(context).style.copyWith(
                color: Colors.white,
                fontSize: widget.referenceFontSize * 1.5,
              ),
          itemHeight: widget.referenceFontSize * 3,
          itemWidth: widget.referenceFontSize * 6,
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

class HVACPage extends StatefulWidget {
  const HVACPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HVACPage> createState() => _HVACPageState();
}

String chairOn = 'images/HMI_HVAC_Left_Chair_ON.png';
String chairOff = 'images/HMI_HVAC_Right_Chair_ON.png';
bool selected = true; // Get from API

class _HVACPageState extends State<HVACPage> {
  final double fanSpeed = 20;

  Widget _buildLayout(BuildContext context, BoxConstraints constraints) {
    // describe the layout in terms of fractions of the container size
    double mainDimension = max(constraints.maxWidth, constraints.maxHeight);
    double minDimension = min(constraints.maxWidth, constraints.maxHeight);
    double iconSize = mainDimension / 12.0;
    double largeIconSize = mainDimension / 8.0;
    double spacingSize = minDimension / 48.0;
    double buttonWidth = constraints.maxWidth / 6.0;
    double buttonHeight = constraints.maxHeight / 6.0;
    double defaultFontSize = constraints.maxHeight / 24.0;
    TextStyle buttonTextStyle = DefaultTextStyle.of(context).style.copyWith(
          color: Colors.white,
          fontSize: defaultFontSize,
        );

    Widget fanSpeedControl = Container(
      padding: EdgeInsets.symmetric(
        vertical: spacingSize,
        horizontal: 3 * spacingSize,
      ),
      child: Row(
        children: [
          Expanded(flex: 4, child: const HVACFanSpeed()),
          SizedBox(width: spacingSize),
          Expanded(
              flex: 1,
              child: Image.asset('images/HMI_HVAC_Fan_Icon.png',
                  width: iconSize, height: iconSize, fit: BoxFit.contain)),
        ],
      ),
    );

    Widget rightSeat = Container(
      padding: EdgeInsets.all(spacingSize),
      child: Column(
        children: [
          IconButton(
            iconSize: largeIconSize,
            icon: Image.asset(selected ? chairOn : chairOff,
                width: largeIconSize,
                height: largeIconSize,
                fit: BoxFit.contain),
            onPressed: () {
              selected = !selected;
            },
          ),
          SizedBox(height: spacingSize),
          _TemperatureSelector(
            referenceFontSize: defaultFontSize,
          ),
        ],
      ),
    );

    Widget leftSeat = Container(
      padding: EdgeInsets.all(spacingSize),
      child: Column(
        children: [
          Image.asset('images/HMI_HVAC_Right_Chair_ON.png',
              width: largeIconSize, height: largeIconSize, fit: BoxFit.contain),
          SizedBox(height: spacingSize),
          _TemperatureSelector(
            referenceFontSize: defaultFontSize,
          ),
        ],
      ),
    );

    Widget centerView = Container(
      padding: EdgeInsets.all(spacingSize),
      child: Column(
        children: [
          Container(
            width: buttonWidth,
            height: buttonHeight,
            margin: EdgeInsets.all(spacingSize),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(20)),
            child: OutlinedButton(
              onPressed: () {
                // Respond to button press
              },
              child: Text("A / C", style: buttonTextStyle),
            ),
          ),
          Container(
            width: buttonWidth,
            height: buttonHeight,
            margin: EdgeInsets.all(spacingSize),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(20)),
            child: OutlinedButton(
              onPressed: () {
                // Respond to button press
              },
              child: Text("Auto", style: buttonTextStyle),
            ),
          ),
          Container(
            width: buttonWidth,
            height: buttonHeight,
            margin: EdgeInsets.all(spacingSize),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(20)),
            child: OutlinedButton(
                onPressed: () {
                  // Respond to button press
                },
                child: Image.asset('images/HMI_HVAC_Circulation_Inactive.png',
                    width: iconSize, height: iconSize, fit: BoxFit.contain)),
          ),
        ],
      ),
    );
    Widget actions = Container(
      padding: EdgeInsets.all(spacingSize),
      child: Column(
        children: [
          Image.asset('images/HMI_HVAC_AirDown_Inactive.png',
              width: iconSize, height: iconSize, fit: BoxFit.contain),
          SizedBox(height: spacingSize),
          Image.asset('images/HMI_HVAC_AirUp_Inactive.png',
              width: iconSize, height: iconSize, fit: BoxFit.contain),
          SizedBox(height: spacingSize),
          Image.asset('images/HMI_HVAC_Front_Inactive.png',
              width: iconSize, height: iconSize, fit: BoxFit.contain),
          SizedBox(height: spacingSize),
          Image.asset('images/HMI_HVAC_Rear_Active.png',
              width: iconSize, height: iconSize, fit: BoxFit.contain),
        ],
        
      ),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        fanSpeedControl,
        Row(children: [
          Expanded(flex: 1, child: rightSeat),
          Expanded(flex: 1, child: centerView),
          Expanded(flex: 1, child: leftSeat),
          Expanded(flex: 1, child: actions)
        ])
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.teal.shade900])),
        child: Center(
            child: LayoutBuilder(
          builder: _buildLayout,
        )));
  }
}
