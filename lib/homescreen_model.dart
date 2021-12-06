import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum SwitchId {
  hvacLeftSeat,
  hvacRigthSeat,
  hvacAc,
  hvacAuto,
  hvacCirculation,
  hvacFan,
  hvacAirDown,
  hvacAirUp,
  hvacFront,
  hvacRear,
}

enum TemperatureId { leftSeat, rightSeat }

class HomescreenModel extends ChangeNotifier {
  // HVAC page

  // fan speed
  double _fanSpeed = 20;

  double get fanSpeed => _fanSpeed;

  set fanSpeed(double newhvacFanSpeed) {
    _fanSpeed = newhvacFanSpeed;
    notifyListeners();
  }

  // switch buttons
  HashMap _switches = new HashMap<SwitchId, bool>();

  bool getSwitchState(SwitchId id) => _switches[id] ?? false;

  void setSwitchState(SwitchId id, bool newValue) {
    _switches[id] = newValue;
    notifyListeners();
  }

  void flipSwitch(SwitchId id) {
    _switches[id] = !_switches[id];
    notifyListeners();
  }

  // temperatures
  HashMap _temperatures = new HashMap<TemperatureId, int>();

  int getTemperature(TemperatureId id) => _temperatures[id] ?? 22;

  void setTemperature(TemperatureId id, int newTemp) {
    _temperatures[id] = newTemp;
    notifyListeners();
  }

  HomescreenModel() {
    // initialize the values
    for (var id in SwitchId.values) {
      _switches[id] = false;
    }
    for (var id in TemperatureId.values) {
      _temperatures[id] = 22;
    }
  }
}
