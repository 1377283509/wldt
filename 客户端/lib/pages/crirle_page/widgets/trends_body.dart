import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:wldt/pages/image_page/image_page.dart';
import 'package:wldt/pages/trends_page/trend_details.dart';
import 'package:wldt/providers/trends_provider.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/cached_image_widget.dart';

class TrendBody extends StatelessWidget {
  RefreshController _controller = RefreshController(
    initialRefresh: true,
  );
  @override
  Widget build(BuildContext context) {
    return Consumer<TrendsProvider>(
      builder: (_, pageState, __) {
        return Theme(
          data: ThemeData(
              primaryColor: Color.fromRGBO(200, 48, 16, 1),
              backgroundColor: Colors.white),
          child: SmartRefresher(
              controller: _controller,
              onRefresh: () async {
                bool res = await pageState.getAllData();
                if (!res) {
                  Toast.show("加载失败", context);
                }
                _controller.refreshCompleted();
              },
              child: SafeArea(
                  child: SingleChildScrollView(
                      child: Column(
                children: pageState.trendList
                    .map((e) => TrendCard(
                          userImage: e.userImage,
                          userName: e.userName,
                          tag: e.tag,
                          commentCounts: e.commentCounts,
                          content: e.content,
                          images: e.images,
                          likeCounts: e.likeCounts,
                          publicTime: e.publicTime,
                          id: e.id,
                        ))
                    .toList(),
              )))),
        );
      },
    );
  }
}

class TrendCard extends StatelessWidget {
  final int id;
  final String userName;
  final String userImage;
  final int likeCounts;
  final String content;
  final List<String> images;
  final int commentCounts;
  final String tag;
  final String publicTime;
  TrendCard(
      {this.id,
      this.images,
      this.userImage,
      this.likeCounts,
      this.commentCounts,
      this.userName,
      this.content,
      this.tag,
      this.publicTime});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          if (id != null) {
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => TrendDetailsPage(id)));
          }
        },
        child: Card(
          elevation: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                leading: Container(
                  width: 38,
                  height: 38,
                  child: CachedImageWidget(
                    width: 38,
                    height: 38,
                    borderRadius: BorderRadius.circular(50),
                    url: userImage,
                  ),
                ),
                title: Text(
                  userName,
                  style: TextStyle(fontSize: 14.0),
                ),
                subtitle: Text(
                  publicTime,
                  style: TextStyle(color: Colors.black45, fontSize: 12.0),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 6.0, left: 16.0, right: 16.0),
                child: Text(
                  "${content}",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: images
                      .map((e) => Container(
                          width: 110,
                          height: 80,
                          margin: EdgeInsets.only(right: 4.0, bottom: 2),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => ImagePage(
                                      images: images,
                                      index: images.indexOf(e))));
                            },
                            child: CachedImageWidget(
                              url: e,
                              width: 110,
                              height: 80,
                            ),
                          )))
                      .toList(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 8.0, top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    tag == null
                        ? Container(
                            width: 5,
                          )
                        : Container(
                      padding: EdgeInsets.only(left: 6,right: 6,top: 0,bottom: 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.orange),
                            child: Text(
                              tag,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10
                              ),
                            ),
                          ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        likeCounts == null
                            ? Container()
                            : Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.thumb_up,
                                      size: 16,
                                      color: Colors.black38,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "$likeCounts",
                                      style: TextStyle(
                                          color: Colors.black38, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                        SizedBox(
                          width: 8,
                        ),
                        commentCounts == null
                            ? Container()
                            : Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.message,
                                      size: 16,
                                      color: Colors.black38,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "$commentCounts",
                                      style: TextStyle(
                                          color: Colors.black38, fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
