import 'package:flutter/material.dart';
import 'package:flutter_homescreen/homescreen_model.dart';
import 'package:flutter_homescreen/layout_size_helper.dart';
import 'package:flutter_homescreen/switchable_image.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

// image assets
const String LEFT_SEAT = 'images/HMI_HVAC_Left_Chair_ON.png';
const String RIGHT_SEAT = 'images/HMI_HVAC_Right_Chair_ON.png';
const String CIRCULATION = 'images/HMI_HVAC_Circulation_Active.png';
const String AIRDOWN = 'images/HMI_HVAC_AirDown_Active.png';
const String AIRUP = 'images/HMI_HVAC_AirUp_Active.png';
const String FRONT = 'images/HMI_HVAC_Front_Active.png';
const String REAR = 'images/HMI_HVAC_Rear_Active.png';

// The page for heating, ventilation, and air conditioning.
class HVACPage extends StatelessWidget {
  HVACPage({Key? key}) : super(key: key);

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
            flex: 3,
            child: HVACFanSpeed(),
          ),
          Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Image.asset('images/HMI_HVAC_Fan_Icon.png',
                  width: sizeHelper.defaultIconSize,
                  height: sizeHelper.defaultIconSize,
                  fit: BoxFit.contain)),
              ),
        ],

        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
      ),
    );

    Widget centerView = Container(
      padding: EdgeInsets.all(sizeHelper.defaultPadding),
      child: Column(
        children: [
          _HVACToggleButton(
            label: 'A/C',
            switchId: SwitchId.hvacAc,
          ),
          _HVACToggleButton(
            label: 'Auto',
            switchId: SwitchId.hvacAuto,
          ),
          _HVACToggleButton(
            imageAssetId: CIRCULATION,
            switchId: SwitchId.hvacCirculation,
          ),
        ],
      ),
    );

    Widget actions =
        Consumer<HomescreenModel>(builder: (context, model, child) {
      return Column(
        children: [
          _ActionButton(switchId: SwitchId.hvacAirDown, imageAssetId: AIRDOWN),
          SizedBox(height: sizeHelper.defaultPadding),
          _ActionButton(switchId: SwitchId.hvacAirUp, imageAssetId: AIRUP),
          SizedBox(height: sizeHelper.defaultPadding),
          _ActionButton(switchId: SwitchId.hvacFront, imageAssetId: FRONT),
          SizedBox(height: sizeHelper.defaultPadding),
          _ActionButton(switchId: SwitchId.hvacRear, imageAssetId: REAR),
        ],
      );
    });

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
              Expanded(
                  flex: 1,
                  child: _SeatButton(
                    switchId: SwitchId.hvacLeftSeat,
                    temperatureId: TemperatureId.leftSeat,
                    imageAssetId: LEFT_SEAT,
                  )),
              Expanded(flex: 1, child: centerView),
              Expanded(
                  flex: 1,
                  child: _SeatButton(
                    switchId: SwitchId.hvacRigthSeat,
                    temperatureId: TemperatureId.rightSeat,
                    imageAssetId: RIGHT_SEAT,
                  )),
              Expanded(flex: 1, child: actions)
            ])
          ],
        ));
  }
}

// The temperature selector.
class _TemperatureSelector extends StatelessWidget {
  final TemperatureId temperatureId;

  _TemperatureSelector({Key? key, required this.temperatureId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);
    return Consumer<HomescreenModel>(
      builder: (context, model, child) {
        return NumberPicker(
          value: model.getTemperature(temperatureId),
          minValue: 18,
          maxValue: 25,
          onChanged: (value) => model.setTemperature(temperatureId, value),
          textStyle: DefaultTextStyle.of(context).style.copyWith(
                color: Colors.teal.shade200,
                fontSize: sizeHelper.baseFontSize,
              ),
          selectedTextStyle: DefaultTextStyle.of(context).style.copyWith(
                fontSize: sizeHelper.baseFontSize * 1.5,
              ),
          itemHeight: sizeHelper.baseFontSize * 3,
          itemWidth: sizeHelper.baseFontSize * 6,
        );
      },
    );
  }
}

/// The fan speed control.
class HVACFanSpeed extends StatelessWidget {
  const HVACFanSpeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        thumbColor: Colors.greenAccent.shade700,
        activeTrackColor: Colors.greenAccent.shade700,
        inactiveTrackColor: Colors.blueGrey.shade200,
      ),
      child: Consumer<HomescreenModel>(
        builder: (context, model, child) {
          return Slider(
            value: model.fanSpeed,
            min: 0,
            max: 300,
            label: model.fanSpeed.round().toString(),
            onChanged: (double newValue) {
              model.fanSpeed = newValue;
            },
          );
        },
      ),
    );
  }
}

// the button to enable A/C on each seat
class _SeatButton extends StatelessWidget {
  final SwitchId switchId;
  final TemperatureId temperatureId;
  final String imageAssetId;

  const _SeatButton({
    Key? key,
    required this.switchId,
    required this.temperatureId,
    required this.imageAssetId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);
    return Container(
      padding: EdgeInsets.all(sizeHelper.defaultPadding),
      child: Column(
        children: [
          Consumer<HomescreenModel>(
            builder: (context, model, child) {
              return IconButton(
                onPressed: () => model.flipSwitch(switchId),
                iconSize: sizeHelper.largeIconSize,
                icon: SwitchableImage(
                  value: model.getSwitchState(switchId),
                  imageAssetId: imageAssetId,
                  width: sizeHelper.largeIconSize,
                  height: sizeHelper.largeIconSize,
                ),
              );
            },
          ),
          SizedBox(height: sizeHelper.defaultPadding),
          _TemperatureSelector(temperatureId: temperatureId),
        ],
      ),
    );
  }
}

// Each one of the large toggle buttons in the UI.
class _HVACToggleButton extends StatelessWidget {
  final String? label;
  final String? imageAssetId;
  final SwitchId switchId;

  _HVACToggleButton(
      {Key? key, required this.switchId, this.label, this.imageAssetId})
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
      child: Consumer<HomescreenModel>(
        builder: (context, model, child) {
          return OutlinedButton(
            onPressed: () => model.flipSwitch(switchId),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(sizeHelper.defaultButtonHeight / 4.0),
              ),
              side: BorderSide(
                width: sizeHelper.defaultBorder,
                color:
                    model.getSwitchState(switchId) ? Colors.green : Colors.grey,
                style: BorderStyle.solid,
              ),
            ),
            child: (imageAssetId != null)
                ? SwitchableImage(
                    value: model.getSwitchState(switchId),
                    imageAssetId: imageAssetId ?? '',
                    width: sizeHelper.defaultIconSize,
                    height: sizeHelper.defaultIconSize,
                  )
                : Text(
                    label ?? '',
                    style: model.getSwitchState(switchId)
                        ? buttonTextStyle
                        : unselectedButtonTextStyle,
                  ),
          );
        },
      ),
    );
  }
}

// Each one of the small action buttons.
class _ActionButton extends StatelessWidget {
  final SwitchId switchId;
  final String imageAssetId;

  const _ActionButton(
      {Key? key, required this.switchId, required this.imageAssetId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizeHelper = LayoutSizeHelper(context);
    return Consumer<HomescreenModel>(
      builder: (context, model, child) {
        return IconButton(
          onPressed: () => model.flipSwitch(switchId),
          iconSize: sizeHelper.defaultIconSize,
          icon: SwitchableImage(
            value: model.getSwitchState(switchId),
            imageAssetId: imageAssetId,
            width: sizeHelper.defaultIconSize,
            height: sizeHelper.defaultIconSize,
          ),
        );
      },
    );
  }
}
