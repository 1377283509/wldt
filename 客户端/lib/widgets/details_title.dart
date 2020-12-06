import 'package:flutter/material.dart';
import 'package:wldt/res/global_config.dart';

class DetailsTitle extends StatelessWidget {
  final String title;
  final int likeCounts;
  final String tag;
  DetailsTitle(this.title, this.likeCounts, {this.tag});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 标题
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              tag == null
                  ? Container()
                  : Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.only(top: 1, bottom: 2, left: 6, right: 6),
                      decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        tag,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white),
                      ),
                    ),
            ],
          )),

          // 喜欢数量
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.favorite,
                  size: ThemeConfig.smallIconSize,
                  color: Colors.red,
                ),
                SizedBox(width: 4.0,),
                Text(likeCounts == null ? "0" : likeCounts.toString(),style: TextStyle(
                  color: Colors.grey
                ),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
