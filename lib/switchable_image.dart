import 'package:flutter/material.dart';

// https://api.flutter.dev/flutter/dart-ui/ColorFilter/ColorFilter.matrix.html
const ColorFilter _identity = ColorFilter.matrix(<double>[
  1, 0, 0, 0, // identity matrix
  0, 0, 1, 0,
  0, 0, 0, 0,
  1, 0, 0, 0,
  0, 0, 1, 0,
]);

const ColorFilter _greyscale = ColorFilter.matrix(<double>[
  0.2126, 0.7152, 0.0722, 0, 0, // greyscale filter
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0, 0, 0, 1, 0,
]);

// This class is used to implement enabled/disabled icons with only one image:
// when the widget is disabled (value==false) the image is displayed in
// greyscale and at 50% opacity.
class SwitchableImage extends StatelessWidget {
  final bool value;
  final String imageAssetId;
  final double width, height;

  const SwitchableImage({
    Key? key,
    required this.value,
    required this.imageAssetId,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Opacity(
        opacity: value ? 1.0 : 0.5,
        child: ColorFiltered(
          colorFilter: value ? _identity : _greyscale,
          child: Image.asset(
            imageAssetId,
            width: width,
            height: height,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
