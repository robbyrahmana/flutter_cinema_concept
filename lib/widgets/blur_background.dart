import 'dart:ui';

import 'package:cinema_concept/widgets/custom_hero.dart';
import 'package:flutter/material.dart';

class BlurBackground extends StatelessWidget {
  BlurBackground({this.assets});
  final String assets;

  @override
  Widget build(BuildContext context) {
    return CustomHero(
      tag: 'blur.background',
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage(assets), fit: BoxFit.cover),
        ),
        child: Stack(
          children: <Widget>[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
              ),
            ),
            Container(
              color: Colors.white54,
            )
          ],
        ),
      ),
    );
  }
}
