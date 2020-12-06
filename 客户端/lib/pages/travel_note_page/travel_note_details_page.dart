import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wldt/pages/food_page/food_details_page.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/providers/travel_note_provider.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/cached_image_widget.dart';
import 'package:wldt/widgets/details_position.dart';
import 'package:wldt/widgets/images_list.dart';

class TravelNoteDetailsPage extends StatefulWidget {
  final int id;
  TravelNoteDetailsPage(this.id);
  @override
  _TravelNoteDetailsPageState createState() => _TravelNoteDetailsPageState();
}

class _TravelNoteDetailsPageState extends State<TravelNoteDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer2<ThemeProvider, TravelNoteProvider>(
      builder: (_, themeState, pageState, __) {
        return FutureBuilder(
            future: pageState.getTravelNoteById(widget.id),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? Scaffold(
                      body: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          DetailsBar(
                            img: pageState.images[0],
                            isLike: true,
                          ),
                          TravelNoteTitle(
                            pageState.note.title,
                          ),
                          TagsWidget(pageState.tags),
                          SizedBox(
                            height: 4.0,
                          ),
                          InfoBar(
                            userName: pageState.note.userName,
                            userImage: pageState.note.userImage,
                            pubDate: pageState.note.pubDate,
                          ),
                          DetailsPosition(pageState.note.address),
                          ContentWidget(pageState.note.content),
                          ImageListWidget(pageState.images),
                          GiveLikeWidget(false, pageState.note.likeCounts),
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

class InfoBar extends StatelessWidget {
  final String userName;
  final String userImage;
  final String pubDate;
  InfoBar({this.userName, this.userImage, this.pubDate});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(left: 8, right: 8, bottom: 4,top: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        dense: true,
        leading: CachedImageWidget(
          width: 30,
          height: 30,
          url: userImage,
          borderRadius: BorderRadius.circular(50),
        ),
        title: Text(userName),
        trailing: Text(pubDate,style: TextStyle(color: Colors.grey,fontSize: 12),),
      ),
    );
  }
}

class GiveLikeWidget extends StatelessWidget {
  final bool isLike;
  final int likeCounts;
  GiveLikeWidget(this.isLike, this.likeCounts);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 120,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                icon: Icon(
                  isLike ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {},
              )),
          SizedBox(
            height: 4.0,
          ),
          Text(
            "$likeCounts 人喜欢",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          )
        ],
      ),
    );
  }
}

class ContentWidget extends StatelessWidget {
  final String content;
  ContentWidget(this.content);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 8, right: 8, top: 4),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      width: screenWidth,
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Text(
        content,
        style: TextStyle(
          height: 2,
          fontSize: ThemeConfig.nomalFontSize,
        ),
        softWrap: true,
        textAlign: TextAlign.justify,
      ),
    );
  }
}

class TagsWidget extends StatelessWidget {
  final List<String> list;
  TagsWidget(this.list);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 16, right: 8, top: 4.0),
      width: screenWidth,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Wrap(
        children: list
            .map((e) => Container(
                  padding: EdgeInsets.fromLTRB(8, 1, 8, 2),
                  margin: EdgeInsets.only(right: 6.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.orange),
                  child: Text(
                    e,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 11),
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class TravelNoteTitle extends StatelessWidget {
  final String title;
  TravelNoteTitle(this.title);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      padding: EdgeInsets.only(left: 16, right: 16, top: 8.0, bottom: 8.0),
      child: Text(
        "#\t\t${title}",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
