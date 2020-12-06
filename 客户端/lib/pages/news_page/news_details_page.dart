import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wldt/providers/news_provider.dart';
import 'package:wldt/providers/theme_provider.dart';

// 资讯详情页
class NewsDetailsPage extends StatelessWidget {
  final String id;
  NewsDetailsPage(this.id);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, NewsProvider>(
      builder: (_, themeState, pageState, __) {
        return FutureBuilder(
            future: pageState.getNewsDetail(id),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(elevation: 0,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: (){},
                  ),
                ],),
                      body: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TitleBar(
                            title: pageState.news.title,
                            pubDate: pageState.news.pubDate,
                            source: pageState.news.source,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 12,right: 12),
                            padding: EdgeInsets.only(bottom: 12.0),
                            child: Column(
                              children: pageState.news.content,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(left: 12,right: 12, bottom: 18.0,top: 6),
                            child: InkWell(
                              onTap: () async {
                                String url = pageState.news.link;
                                if (await canLaunch(url)) {
                                await launch(url);
                                } else {
                                  Toast.show("链接无效，无法跳转", context);
                                }
                              },
                              child: Text("跳转原文",style: TextStyle(color: Colors.blue[800],fontSize: 15),),
                            ),
                          ),
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

class TitleBar extends StatelessWidget {
  final String title;
  final String source;
  final String pubDate;
  TitleBar({this.title, this.pubDate, this.source});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 12.0, right: 12.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 6.0),
              alignment: Alignment.centerLeft,
              child: Text(title,style: TextStyle(color: Colors.black,fontSize: 24.0,fontWeight: FontWeight.bold),),
            ),
            Container(
              margin: EdgeInsets.only(top: 4,bottom: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(source,style: TextStyle(color: Colors.black38,fontSize: 13.0),),

                  Text(pubDate,style: TextStyle(color: Colors.black38,fontSize: 13.0),),

                ],
              ),
            ),
          ],
        ));
  }
}
