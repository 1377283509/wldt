// 内容title
import 'package:flutter/material.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/tag_widget.dart';

class TouristDetailsTitle extends StatelessWidget {
  final String name;
  final String score;
  final int commentNumber;
  final List<String> tags;
  TouristDetailsTitle(this.name, this.tags,
      {this.score, this.commentNumber,});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0, top: 8.0),
      margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // 标题、标签
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // 标题
                Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ThemeConfig.maximalFontSize),
                ),
                // 标签
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: tags.map((v) => TagWidget(v)).toList(),
                  ),
                ),
              ],
            ),
          ),
          score == null
              ? SizedBox(
                  width: 0,
                  height: 0,
                )
              : Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        score + "分",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: ThemeConfig.smallFontSize),
                      ),
                      SizedBox(height: 4.0,),
                      Text(
                        commentNumber.toString() + "条评论",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: ThemeConfig.smallFontSize),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
