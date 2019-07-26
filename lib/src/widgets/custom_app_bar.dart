import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final VoidCallback onBackPress;
  final VoidCallback onMenuPress;
  final String title;

  CustomAppBar(
      {@required this.onBackPress,
      @required this.onMenuPress,
      @required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(onPressed: onBackPress, icon: Icon(Icons.arrow_back)),
            Text(title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            IconButton(onPressed: onMenuPress, icon: Icon(Icons.menu))
          ],
        ),
      ),
    );
  }
}
