import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wldt/models/comment_model.dart';
import 'package:wldt/pages/crirle_page/widgets/travel_note_body.dart';
import 'package:wldt/pages/crirle_page/widgets/trends_body.dart';
import 'package:wldt/pages/food_page/food_details_page.dart';
import 'package:wldt/pages/image_page/image_page.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/providers/trends_provider.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/cached_image_widget.dart';

class TrendDetailsPage extends StatefulWidget {
  final int id;
  TrendDetailsPage(this.id);
  @override
  _TrendDetailsPageState createState() => _TrendDetailsPageState();
}

class _TrendDetailsPageState extends State<TrendDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, TrendsProvider>(
      builder: (_, themeState, pageState, __) {
        return FutureBuilder(
            future: pageState.getTrendById(widget.id),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? Scaffold(
                      appBar: AppBar(
                        elevation: 0,
                        title: Text(
                          "详情",
                          style:
                              TextStyle(fontSize: ThemeConfig.larggerFontSize),
                        ),
                      ),
                      body: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            TrendCard(
                              userImage: pageState.trend.userImg,
                              userName: pageState.trend.userName,
                              likeCounts: pageState.trend.likeCounts,
                              content: pageState.trend.content,
                              commentCounts: pageState.trend.comments.length,
                              publicTime: pageState.trend.publicTime,
                              images: pageState.trend.images,
                              tag: pageState.trend.tag,
                            ),
                            Container(
                              padding:
                                  EdgeInsets.only(left: 12, top: 6, bottom: 6),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "评\t论(${pageState.trend.comments.length})",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: ThemeConfig.larggerFontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            CommentsList(pageState.trend.comments),
                          ],
                        ),
                      ))
                  : Scaffold(
                      body: Container(
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: CupertinoActivityIndicator(),
                      ),
                    );
            });
      },
    );
  }
}

class CommentsList extends StatelessWidget {
  final List<TrendComment> list;
  CommentsList(this.list);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: list
              .map((e) => TrendCard(
                    userImage: e.userImage,
                    publicTime: e.publicTime,
                    userName: e.userName,
                    content: e.content,
                    images: e.images,
                    likeCounts: e.likeCounts,
                  ))
              .toList(),
        ),
      ),
    );
  }
}
