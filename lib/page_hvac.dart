import 'package:flutter/material.dart';
import 'package:flutter_homescreen/layout_size_helper.dart';
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
  _TemperatureSelector({Key? key}) : super(key: key);

  @override
  _TemperatureSelectorState createState() => _TemperatureSelectorState();
}

class _TemperatureSelectorState extends State<_TemperatureSelector> {
  int _currentValue = 22; // INIT FROM AGLJS wrapper

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);
    return Column(
      children: <Widget>[
        NumberPicker(
          value: _currentValue,
          minValue: 18,
          maxValue: 25,
          onChanged: (value) => setState(() => _currentValue = value),
          textStyle: DefaultTextStyle.of(context).style.copyWith(
                color: Colors.teal.shade200,
                fontSize: sizeHelper.baseFontSize,
              ),
          selectedTextStyle: DefaultTextStyle.of(context).style.copyWith(
                fontSize: sizeHelper.baseFontSize * 1.5,
              ),
          itemHeight: sizeHelper.baseFontSize * 3,
          itemWidth: sizeHelper.baseFontSize * 6,
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
    return SliderTheme(
      data: SliderThemeData(
        thumbColor: Colors.greenAccent.shade700,
        activeTrackColor: Colors.greenAccent.shade700,
        inactiveTrackColor: Colors.blueGrey.shade200,
      ),
      child: Slider(
        value: _currentSliderValue,
        min: 0,
        max: 300,
        label: _currentSliderValue.round().toString(),
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      ),
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

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);
    TextStyle buttonTextStyle = DefaultTextStyle.of(context).style.copyWith(
          fontSize: sizeHelper.baseFontSize,
        );

    Widget fanSpeedControl = Container(
      padding: EdgeInsets.symmetric(
        vertical: sizeHelper.defaultPadding,
        horizontal: 3.0 * sizeHelper.defaultPadding,
      ),
      child: Row(
        children: [
          Expanded(flex: 4, child: const HVACFanSpeed()),
          SizedBox(width: sizeHelper.defaultPadding),
          Expanded(
              flex: 1,
              child: Image.asset('images/HMI_HVAC_Fan_Icon.png',
                  width: sizeHelper.defaultIconSize,
                  height: sizeHelper.defaultIconSize,
                  fit: BoxFit.contain)),
        ],
      ),
    );

    Widget rightSeat = Container(
      padding: EdgeInsets.all(sizeHelper.defaultPadding),
      child: Column(
        children: [
          IconButton(
            iconSize: sizeHelper.largeIconSize,
            icon: Image.asset(selected ? chairOn : chairOff,
                width: sizeHelper.largeIconSize,
                height: sizeHelper.largeIconSize,
                fit: BoxFit.contain),
            onPressed: () {
              selected = !selected;
            },
          ),
          SizedBox(height: sizeHelper.defaultPadding),
          _TemperatureSelector(),
        ],
      ),
    );

    Widget leftSeat = Container(
      padding: EdgeInsets.all(sizeHelper.defaultPadding),
      child: Column(
        children: [
          Image.asset('images/HMI_HVAC_Right_Chair_ON.png',
              width: sizeHelper.largeIconSize,
              height: sizeHelper.largeIconSize,
              fit: BoxFit.contain),
          SizedBox(height: sizeHelper.defaultPadding),
          _TemperatureSelector(),
        ],
      ),
    );

    Widget centerView = Container(
      padding: EdgeInsets.all(sizeHelper.defaultPadding),
      child: Column(
        children: [
          Container(
            width: sizeHelper.defaultButtonWidth,
            height: sizeHelper.defaultButtonHeight,
            margin: EdgeInsets.all(sizeHelper.defaultPadding),
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
            width: sizeHelper.defaultButtonWidth,
            height: sizeHelper.defaultButtonHeight,
            margin: EdgeInsets.all(sizeHelper.defaultPadding),
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
            width: sizeHelper.defaultButtonWidth,
            height: sizeHelper.defaultButtonHeight,
            margin: EdgeInsets.all(sizeHelper.defaultPadding),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(20)),
            child: OutlinedButton(
                onPressed: () {
                  // Respond to button press
                },
                child: Image.asset('images/HMI_HVAC_Circulation_Inactive.png',
                    width: sizeHelper.defaultIconSize,
                    height: sizeHelper.defaultIconSize,
                    fit: BoxFit.contain)),
          ),
        ],
      ),
    );
    Widget actions = Container(
      padding: EdgeInsets.all(sizeHelper.defaultPadding),
      child: Column(
        children: [
          Image.asset('images/HMI_HVAC_AirDown_Inactive.png',
              width: sizeHelper.defaultIconSize,
              height: sizeHelper.defaultIconSize,
              fit: BoxFit.contain),
          SizedBox(height: sizeHelper.defaultPadding),
          Image.asset('images/HMI_HVAC_AirUp_Inactive.png',
              width: sizeHelper.defaultIconSize,
              height: sizeHelper.defaultIconSize,
              fit: BoxFit.contain),
          SizedBox(height: sizeHelper.defaultPadding),
          Image.asset('images/HMI_HVAC_Front_Inactive.png',
              width: sizeHelper.defaultIconSize,
              height: sizeHelper.defaultIconSize,
              fit: BoxFit.contain),
          SizedBox(height: sizeHelper.defaultPadding),
          Image.asset('images/HMI_HVAC_Rear_Active.png',
              width: sizeHelper.defaultIconSize,
              height: sizeHelper.defaultIconSize,
              fit: BoxFit.contain),
        ],
      ),
    );

    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blueGrey.shade900, Colors.grey.shade900])),
        child: Column(
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
        ));
  }
}
