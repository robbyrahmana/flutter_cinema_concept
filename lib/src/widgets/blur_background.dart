import 'package:flutter/material.dart';
import 'dart:ui';

class BlurBackground extends StatelessWidget {
  final String asset;

  BlurBackground({@required this.asset});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage(asset),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: <Widget>[
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
          Container(color: Colors.white54)
        ],
      ),
    );
  }
}
