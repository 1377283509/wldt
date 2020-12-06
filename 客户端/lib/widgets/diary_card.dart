import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/diary_model.dart';
import 'package:wldt/pages/diary_page/diary_details_page.dart';
import 'package:wldt/widgets/cached_image_widget.dart';

// 小记卡片
class DiaryCard extends StatelessWidget {
  final Diary card;
  const DiaryCard(this.card, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context) => DiaryDetailsPage(card),
        ));
      },
      child: Container(
          width: 0.46 * screenWidth,
          margin: EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // 图片
                SquareImageWidget(card.image),
                Container(
                  width: 0.46 * screenWidth,
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0),
                  child: Text(
                    card.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // 内容
                Container(
                  width: 0.46 * screenWidth,
                  height: 54,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        card.userName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      Text(
                        card.pubDate,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ])),
    );
  }
}

// 顶部图片Widget
class SquareImageWidget extends StatelessWidget {
  final String url;
  SquareImageWidget(this.url, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return CachedImageWidget(
      url: url,
      width: .46 * screenWidth,
      height: .46 * screenWidth,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6), topRight: Radius.circular(6)),
    );
  }
}
