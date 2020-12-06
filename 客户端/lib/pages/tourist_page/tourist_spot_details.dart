import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wldt/pages/food_page/food_details_page.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/providers/tourist_spot_provider.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/details_description.dart';
import 'package:wldt/widgets/details_position.dart';
import 'package:wldt/widgets/images_list.dart';
import 'package:wldt/widgets/tag_widget.dart';

// 景点详情页
class TouristSpotDetailsPage extends StatelessWidget {
  final int id;
  TouristSpotDetailsPage(this.id);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, TouristSpotProvider>(
      builder: (_, themeState, tsState, __) {
        return FutureBuilder(
            future: tsState.getTouristSpot(id),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? Scaffold(
                      body: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DetailsBar(
                            img: tsState.curTouristSImages.first,
                            isLike: false,
                            // TODO:喜欢操作
                          ),

                          // 头部基本信息
                          TouristDetailsTitle(tsState.curTouristS.name,
                              tsState.curTouristSTags),
                          // 简介
                          tsState.curTouristS.description == null
                              ? Container()
                              : DetailsDescription(
                                  content: tsState.curTouristS.description,
                                  isExpanded: true,
                                ),

                          // 位置信息
                          DetailsPosition(tsState.curTouristS.position),
                          DetailsDescription(
                            title: "开放时间",
                            content: tsState.curTouristS.openDate ??
                                "" + "\n${tsState.curTouristS.openTime ?? ""}",
                            isExpanded: true,
                          ),
                          tsState.curTouristS.history == ""
                              ? SizedBox(
                                  height: 0,
                                )
                              : DetailsDescription(
                                  title: "建造历史",
                                  content: tsState.curTouristS.history),
                          tsState.curTouristS.feature == ""
                              ? SizedBox(
                                  height: 0,
                                )
                              : DetailsDescription(
                                  title: "景点特色",
                                  content: tsState.curTouristS.feature,
                                ),
                          tsState.curTouristS.artistCharm == ""
                              ? SizedBox(
                                  height: 0,
                                )
                              : DetailsDescription(
                                  title: "艺术魅力",
                                  content: tsState.curTouristS.artistCharm,
                                ),
                          // 配图
                          ImageListWidget(tsState.curTouristSImages),
                          SizedBox(
                            height: 8.0,
                          )
                        ],
                      ),
                    ))
                  : Scaffold(
                      body: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: CupertinoActivityIndicator(),
                      ),
                    );
            });
      },
    );
  }
}

class TouristDetailsTitle extends StatelessWidget {
  final String name;
  final String score;
  final int commentNumber;
  final List<String> tags;
  final int averageConsumption;
  TouristDetailsTitle(this.name, this.tags,
      {this.score, this.commentNumber, this.averageConsumption});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0, top: 8.0),
      margin: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 4.0, top: 8.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              name,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ThemeConfig.maximalFontSize),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: tags.map((v) => TagWidget(v)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
