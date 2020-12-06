import 'package:flutter/material.dart';
import 'package:wldt/res/global_config.dart';

class TagWidget extends StatelessWidget {
  final String text;
  final Color bgColor;
  TagWidget(this.text, {this.bgColor = Colors.orange});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 6.0),
          padding: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
          decoration: BoxDecoration(
            color: this.bgColor,
            borderRadius: BorderRadius.circular(50),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.0,
            ),
          ),
        )
      ],
    );
  }
}
