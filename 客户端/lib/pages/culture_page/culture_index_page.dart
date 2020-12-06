import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:wldt/models/culture_model.dart';
import 'package:wldt/pages/culture_page/culture_details_page.dart';
import 'package:wldt/pages/search_page/search_page.dart';
import 'package:wldt/providers/culture_provider.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 文化首页

class CultureIndexPage extends StatefulWidget {
  @override
  State<CultureIndexPage> createState() => CultureIndexPageState();
}

class CultureIndexPageState extends State<CultureIndexPage> {
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
              "大同文化",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            centerTitle: true,
          ),
          body: CulturePageBody(),
        ),
      );
    });
  }
}

class CulturePageBody extends StatelessWidget {
  RefreshController _controller = new RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return Consumer<CultureProvider>(
      builder: (_, pageState, __) {
        return Theme(
            data: ThemeData(
              primaryColor: Color.fromRGBO(200, 48, 16, 1),
            ),
            child: SmartRefresher(
                controller: _controller,
                onRefresh: () async {
                  bool res = await pageState.getAllCulture();
                  if (!res) {
                    Toast.show("出错了", context);
                  }
                  _controller.refreshCompleted();
                },
                child: ListView(
                    padding: EdgeInsets.only(bottom: 8.0),
                    children: pageState.cultureList
                        .map((v) => CultureCard(v))
                        .toList())));
      },
    );
  }
}

class CultureCard extends StatelessWidget {
  final Culture culture;
  CultureCard(this.culture);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => CultureDetailsPage(culture.title,culture.url)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 12, right: 12, top: 8.0),
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: culture.image,
              imageBuilder: (context, imageProvider) => Container(
                width: 0.98 * screenWidth,
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover)),
              ),
              placeholder: (context, url) => Container(
                width: 0.98 * screenWidth,
                height: 180,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  color: Colors.grey[300],
                ),
                child: CupertinoActivityIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Container(
              width: 0.98 * screenWidth,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 12, bottom: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 0.8 * screenWidth,
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text(
                      "${culture.title}",
                      style: TextStyle(
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  Container(
                    width: 0.12 * screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 16.0,
                        ),
                        Text("${culture.likeCounts}",style: TextStyle(
                          fontSize: 12.0,color: Colors.black45
                        ),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
