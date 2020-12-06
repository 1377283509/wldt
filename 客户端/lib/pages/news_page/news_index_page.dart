import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:wldt/models/news_model.dart';
import 'package:wldt/pages/food_page/wdigets/food_card_widget.dart';
import 'package:wldt/pages/news_page/news_details_page.dart';
import 'package:wldt/pages/search_page/search_page.dart';
import 'package:wldt/providers/food_provider.dart';
import 'package:wldt/providers/news_provider.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wldt/widgets/cached_image_widget.dart';
import 'package:wldt/widgets/images_list.dart';

// 资讯首页

class NewsIndexPage extends StatefulWidget {
  @override
  State<NewsIndexPage> createState() => NewsIndexPageState();
}

class NewsIndexPageState extends State<NewsIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (_, themeState, __) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => SearchPage()));
                  }),
              IconButton(icon: Icon(Icons.sort), onPressed: null),
            ],
            title: Text(
              "最新资讯",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            centerTitle: true,
          ),
          body: NewsPageBody(),
        ),
      );
    });
  }
}

class NewsPageBody extends StatelessWidget {
  RefreshController _controller = new RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (_, pageState, __) {
        return Theme(
            data: ThemeData(
              primaryColor: Color.fromRGBO(200, 48, 16, 1),
            ),
            child: SmartRefresher(
                controller: _controller,
                onRefresh: () async {
                  bool res = await pageState.getAllData();
                  if (!res) {
                    Toast.show("出错了", context);
                  }
                  _controller.refreshCompleted();
                },
                child: ListView(
                    padding: EdgeInsets.only(bottom: 8.0),
                    children:
                        pageState.newsList.map((v) => NewsCard(v)).toList())));
      },
    );
  }
}

class NewsCard extends StatelessWidget {
  final SimpleNews news;
  NewsCard(this.news);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => NewsDetailsPage(news.id)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 8, right: 8, top: 6),
        padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                news.title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            news.desc == "" || news.desc == null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: 4),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      news.desc,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.5,
                        color: Colors.black45,
                        fontSize: 13
                      ),
                    ),
                  ),
            Container(
              margin: EdgeInsets.only(top: 6.0),
              child: Row(
                mainAxisAlignment: news.images.length == 3
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.start,
                children: news.images
                    .map((e) => CachedImageWidget(
                          url: e,
                          width: 110,
                          height: 80,
                        ))
                    .toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      news.pubDate,
                      style: TextStyle(color: Colors.black38, fontSize: 11.0),
                    ),
                  ),
                  Container(
                    child: Text("来源：${news.source}",
                        style:
                            TextStyle(color: Colors.black38, fontSize: 11.0)),
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
