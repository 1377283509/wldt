import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/diary_model.dart';
import 'package:wldt/res/global_config.dart';

class DiaryDetailsPage extends StatefulWidget {
  final Diary diary;
  const DiaryDetailsPage(this.diary, {Key key}) : super(key: key);
  @override
  _DiaryDetailsPageState createState() => _DiaryDetailsPageState();
}

class _DiaryDetailsPageState extends State<DiaryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        brightness: Brightness.light,
        title: Text("${widget.diary.likeCount} 人赞了",style: TextStyle(fontSize: ThemeConfig.nomalFontSize),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // 图片
            CachedNetworkImage(
              imageUrl: widget.diary.image,
              imageBuilder: (context, imageProvider) => Container(
                  width: screenWidth,
                  height: 1.1 * screenWidth,
                  padding: EdgeInsets.only(left: 8, bottom: 12),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover))),
              placeholder: (context, url) => Container(
                width: screenWidth,
                height: 1.1 * screenWidth,
                alignment: Alignment.center,
                child: CupertinoActivityIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            // 内容
            Container(
              width: screenWidth,
              padding: EdgeInsets.only(
                  top: 54,
                  bottom: 124,
                  left: 0.18 * screenWidth,
                  right: 0.18 * screenWidth),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.diary.content,
                textAlign: TextAlign.left,
                softWrap: true,
                style: TextStyle(color: Colors.black87, letterSpacing: 1),
              ),
            ),
            // 时间
            Container(
              width: screenWidth,
              margin: EdgeInsets.only(bottom: 12.0),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    "${widget.diary.userName}",
                    style: TextStyle(
                      color: Colors.black26,
                    ),
                  ),
                  SizedBox(
                    height: 4.0,
                  ),
                  Text(
                    "—\t${widget.diary.pubDate}\t—",
                    style: TextStyle(
                      color: Colors.black26,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
