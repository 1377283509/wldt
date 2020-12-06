
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:wldt/models/diary_model.dart';
import 'package:wldt/pages/diary_page/diary_details_page.dart';
import 'package:wldt/pages/diary_page/diary_list_page.dart';
import 'package:wldt/pages/diary_page/public_diary_page.dart';
import 'package:wldt/providers/diary_providers.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/widgets/cached_image_widget.dart';

class DiaryIndexPage extends StatefulWidget {
  @override
  _DiaryIndexPageState createState() => _DiaryIndexPageState();
}

class _DiaryIndexPageState extends State<DiaryIndexPage> {
  RefreshController _controller = RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("小记",
            style: TextStyle(
                fontSize: 26.0, fontWeight: FontWeight.bold, letterSpacing: 2)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.wifi,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (context) => DiaryListPage()));
            },
          ),
          IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => PublicDiaryPage()));
              }),
        ],
      ),
      body: Consumer2<ThemeProvider, DiaryProvider>(
        builder: (_, themeState, pageState, __) {
          return Theme(
            data: ThemeData(
                primaryColor: Color.fromRGBO(200, 48, 16, 1),
                backgroundColor: Colors.white),
            child: SmartRefresher(
                controller: _controller,
                onRefresh: () async {
                  pageState.getUsersDiary();

                  _controller.refreshCompleted();
                },
                child: MyDiaryList()),
          );
        },
      ),
    );
  }
}

class MyDiaryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryProvider>(
      builder: (_, pageState, __) {
        return SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              child: Column(),
            ),
            Container(
              margin: EdgeInsets.only(top: 12.0),
              padding: EdgeInsets.only(bottom: 12.0),
              child: Wrap(
                children:
                    pageState.myDiaryList.map((f) => WideDiaryCard(f)).toList(),
              ),
            ),
          ],
        ));
      },
    );
  }
}

class WideDiaryCard extends StatelessWidget {
  final Diary diary;
  WideDiaryCard(this.diary);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => DiaryDetailsPage(diary)));
      },
      child: Container(
        margin: EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: <Widget>[
            CachedImageWidget(
              width: 0.98 * screenWidth,
              height: 180,
              borderRadius: BorderRadius.circular(12),
              url: diary.image,
            ),
            Container(
              width: 0.98 * screenWidth,
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 12, bottom: 12),
              child: Text(
                "-\t${diary.pubDate}\t-",
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
