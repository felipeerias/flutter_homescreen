import 'package:flutter/material.dart';

class LayoutSizeHelper {
  Size _size;
  double _ratio;

  LayoutSizeHelper(context)
      : _size = MediaQuery.of(context).size,
        _ratio = MediaQuery.of(context).devicePixelRatio;

  update(context) {
    _size = MediaQuery.of(context).size;
    _ratio = MediaQuery.of(context).devicePixelRatio;
  }

  get defaultIconSize {
    if (_size.height <= 480 || _size.width <= 600) {
      return 64.0 * _ratio;
    } else if (_size.height <= 900 || _size.width <= 840) {
      return 96.0 * _ratio;
    } else {
      return 128.0 * _ratio;
    }
  }

  get defaultButtonHeight {
    return defaultIconSize;
  }

  get defaultButtonWidth {
    return defaultButtonHeight * 3.0;
  }

  get defaultPadding {
    return defaultIconSize / 8.0;
  }

  get defaultBorder {
    return defaultIconSize / 16;
  }

  get baseFontSize {
    return (defaultIconSize / 3.0).floor().toDouble();
  }

  get largeIconSize {
    return 1.5 * defaultIconSize;
  }

  get largePadding {
    return largeIconSize / 4.0;
  }
}
