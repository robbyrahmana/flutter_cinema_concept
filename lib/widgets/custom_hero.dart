import 'package:flutter/material.dart';

class CustomHero extends StatelessWidget {
  CustomHero({@required this.tag, @required this.child});

  final String tag;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Hero(
      transitionOnUserGestures: true,
      tag: tag,
      child:
          Material(color: Colors.transparent, child: Container(child: child)),
    );
  }
}
