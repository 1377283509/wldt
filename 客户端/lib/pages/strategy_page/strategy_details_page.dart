import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wldt/pages/food_page/food_details_page.dart';
import 'package:wldt/pages/travel_note_page/travel_note_details_page.dart';
import 'package:wldt/providers/strategy_page_provider.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/widgets/details_position.dart';
import 'package:wldt/widgets/images_list.dart';

class StrategyDetailsPage extends StatefulWidget {
  final int id;
  StrategyDetailsPage(this.id);
  @override
  _StrategyDetailsPageState createState() => _StrategyDetailsPageState();
}

class _StrategyDetailsPageState extends State<StrategyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, StrategyProvider>(
      builder: (_, themeState, pageState, __) {
        return FutureBuilder(
            future: pageState.getStrategyById(widget.id),
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
                          pageState.strategy.title,
                        ),
                        TagsWidget(pageState.tags),
                        SizedBox(
                          height: 4.0,
                        ),
                        InfoBar(
                          userName: pageState.strategy.userName,
                          userImage: pageState.strategy.userImage,
                          pubDate: pageState.strategy.pubDate,
                        ),
                        DetailsPosition(pageState.strategy.address),
                        ContentWidget(pageState.strategy.content),
                        ImageListWidget(pageState.images),
                        GiveLikeWidget(false, pageState.strategy.likeCounts),
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





