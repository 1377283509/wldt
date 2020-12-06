import 'package:flutter/material.dart';

class DetailsBar extends StatelessWidget {
  final String img;
  final bool isLike;
  final Function function;
  DetailsBar({this.img, this.isLike, this.function});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 240,
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
      child: SafeArea(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                // TODO:分享
              },
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}