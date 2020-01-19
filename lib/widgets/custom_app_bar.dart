import 'package:cinema_concept/widgets/custom_hero.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar(
      {@required this.title,
      @required this.onBackPress,
      @required this.onMenuPress});

  final String title;
  final VoidCallback onBackPress;
  final VoidCallback onMenuPress;

  @override
  Widget build(BuildContext context) {
    return CustomHero(
      tag: 'appbar',
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: onBackPress,
                icon: Icon(Icons.arrow_back),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              IconButton(
                onPressed: onMenuPress,
                icon: Icon(Icons.menu),
              )
            ],
          ),
        ),
      ),
    );
  }
}
