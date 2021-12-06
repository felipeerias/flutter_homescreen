import 'package:flutter/material.dart';

// A 3D demo.
class Demo3dPage extends StatelessWidget {
  Demo3dPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.grey.shade800, Colors.grey.shade900])),
      child: Texture(
        textureId: 1,
      ),
    );
  }
}
