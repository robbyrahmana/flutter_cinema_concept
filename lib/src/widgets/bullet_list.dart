import 'package:flutter/material.dart';

class BulletList extends StatelessWidget {
  final int length;
  final int activeIndex;

  BulletList({this.length, this.activeIndex});

  @override
  Widget build(BuildContext context) {
    List<Widget> _listBullet = [];

    for (int i = 0; i < length; i++) {
      _listBullet.add(Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          Icons.fiber_manual_record,
          size: 8,
          color: activeIndex == i ? Colors.blueGrey : Colors.black,
        ),
      ));
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _listBullet,
    );
  }
}
