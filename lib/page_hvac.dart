import 'package:flutter/material.dart';
import 'package:flutter_homescreen/layout_size_helper.dart';
import 'package:numberpicker/numberpicker.dart';

// The page for heating, ventilation, and air conditioning.
class HVACPage extends StatefulWidget {
  const HVACPage({Key? key}) : super(key: key);

  @override
  State<HVACPage> createState() => _HVACPageState();
}

String leftChairOn = 'images/HMI_HVAC_Left_Chair_ON.png';
String leftChairOff = 'images/HMI_HVAC_Left_Chair_OFF.png';
String rightChairOn = 'images/HMI_HVAC_Right_Chair_ON.png';
String rightChairOff = 'images/HMI_HVAC_Right_Chair_OFF.png';
String circulationActive = 'images/HMI_HVAC_Circulation_Active.png';
String circulationInactive = 'images/HMI_HVAC_Circulation_Inactive.png';

class _HVACPageState extends State<HVACPage> {
// Get from API
  bool leftChairSelected = true;
  bool rightChairSelected = true;
  bool acSelected = true;
  bool autoSelected = false;
  bool circulationSelected = false;
  double fanSpeed = 20;

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);

    Widget fanSpeedControl = Container(
      padding: EdgeInsets.symmetric(
        vertical: sizeHelper.defaultPadding,
        horizontal: 3.0 * sizeHelper.defaultPadding,
      ),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: HVACFanSpeed(
                fanSpeed: fanSpeed,
                onUpdateFanSpeed: (double newFanSpeed) {
                  setState(() {
                    fanSpeed = newFanSpeed;
                  });
                },
              )),
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
            icon: Image.asset(leftChairSelected ? leftChairOn : leftChairOff,
                width: sizeHelper.largeIconSize,
                height: sizeHelper.largeIconSize,
                fit: BoxFit.contain),
            onPressed: () {
              setState(() {
                leftChairSelected = !leftChairSelected;
              });
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
          IconButton(
            iconSize: sizeHelper.largeIconSize,
            icon: Image.asset(rightChairSelected ? rightChairOn : rightChairOff,
                width: sizeHelper.largeIconSize,
                height: sizeHelper.largeIconSize,
                fit: BoxFit.contain),
            onPressed: () {
              setState(() {
                rightChairSelected = !rightChairSelected;
              });
            },
          ),
          SizedBox(height: sizeHelper.defaultPadding),
          _TemperatureSelector(),
        ],
      ),
    );

    Widget centerView = Container(
      padding: EdgeInsets.all(sizeHelper.defaultPadding),
      child: Column(
        children: [
          _HVACToggleButton(
              label: 'A/C',
              isSelected: acSelected,
              onPressed: () {
                setState(() {
                  acSelected = !acSelected;
                });
              }),
          _HVACToggleButton(
              label: 'Auto',
              isSelected: autoSelected,
              onPressed: () {
                setState(() {
                  autoSelected = !autoSelected;
                });
              }),
          _HVACToggleButton(
              child: Image.asset(
                  circulationSelected ? circulationActive : circulationInactive,
                  width: sizeHelper.defaultIconSize,
                  height: sizeHelper.defaultIconSize,
                  fit: BoxFit.contain),
              isSelected: circulationSelected,
              onPressed: () {
                setState(() {
                  circulationSelected = !circulationSelected;
                });
              }),
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

// The temperature selector.
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

/// The fan speed control.
class HVACFanSpeed extends StatelessWidget {
  final double fanSpeed;
  final Null Function(double) onUpdateFanSpeed;

  const HVACFanSpeed(
      {Key? key, required this.fanSpeed, required this.onUpdateFanSpeed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbColor: Colors.greenAccent.shade700,
        activeTrackColor: Colors.greenAccent.shade700,
        inactiveTrackColor: Colors.blueGrey.shade200,
      ),
      child: Slider(
        value: fanSpeed,
        min: 0,
        max: 300,
        label: fanSpeed.round().toString(),
        onChanged: (double value) {
          onUpdateFanSpeed(value);
        },
      ),
    );
  }
}

// Each one of the toggle buttons in the UI.
class _HVACToggleButton extends StatelessWidget {
  final String? label;
  final Widget? child;
  final bool isSelected;
  final Null Function() onPressed;

  _HVACToggleButton(
      {Key? key,
      this.label,
      this.child,
      required this.isSelected,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);
    TextStyle buttonTextStyle = DefaultTextStyle.of(context).style.copyWith(
          fontSize: sizeHelper.baseFontSize,
          fontWeight: FontWeight.bold,
        );
    TextStyle unselectedButtonTextStyle = buttonTextStyle.copyWith(
      color: Colors.grey,
      fontWeight: FontWeight.normal,
    );

    return Container(
      width: sizeHelper.defaultButtonWidth,
      height: sizeHelper.defaultButtonHeight,
      margin: EdgeInsets.all(sizeHelper.defaultPadding),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(sizeHelper.defaultButtonHeight / 4.0),
          ),
          side: BorderSide(
            width: sizeHelper.defaultBorder,
            color: isSelected ? Colors.green : Colors.grey,
            style: BorderStyle.solid,
          ),
        ),
        child: child ??
            Text(
              label ?? '',
              style: isSelected ? buttonTextStyle : unselectedButtonTextStyle,
            ),
      ),
    );
  }
}
