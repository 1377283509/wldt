import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wldt/pages/food_page/food_details_page.dart';
import 'package:wldt/pages/tourist_page/widgets/tourist_details_title.dart';
import 'package:wldt/pages/tourist_page/widgets/tourist_spots_card.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/providers/tourist_attraction_provider.dart';
import 'package:wldt/widgets/details_comment.dart';
import 'package:wldt/widgets/details_description.dart';
import 'package:wldt/widgets/details_position.dart';
import 'package:wldt/widgets/images_list.dart';

// 景区详情页
class TouristAttractionDetailsPage extends StatelessWidget {
  final int id;
  TouristAttractionDetailsPage(this.id);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, TouristAttractionProvider>(
      builder: (_, themeState, tsState, __) {
        return FutureBuilder(
            future: tsState.getTouristAttraction(id),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? Scaffold(
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.red,
                        child: Icon(Icons.favorite_border),
                      ),
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.endFloat,
                      body: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DetailsBar(
                              img: tsState.curTouristAImages.first,
                              isLike: false,
                              // TODO:喜欢操作
                            ),

                            // 头部基本信息
                            TouristDetailsTitle(
                              tsState.curTouristA.name,
                              tsState.curTouristATags,
                              score: tsState.curTouristA.score,
                              commentNumber: tsState.curTouristA.commentNumber,
                            ),
                            // 简介
                            tsState.curTouristA.description == "null"
                                ? Container()
                                : DetailsDescription(
                                    content: tsState.curTouristA.description,
                                  ),

                            // 位置信息
                            DetailsPosition(tsState.curTouristA.position),

                            tsState.curTouristA.ticketInfo == ""
                                ? SizedBox(
                                    height: 0,
                                  )
                                : DetailsDescription(
                                    title: "门票信息",
                                    content: tsState.curTouristA.ticketInfo,
                                    isExpanded: true,
                                  ),
                            // 开放日期
                            tsState.curTouristA.openTime == "null" &&
                                    tsState.curTouristA.openDate == "null"
                                ? SizedBox(
                                    height: 0,
                                  )
                                : DetailsDescription(
                                    title: "开放时间",
                                    isExpanded: true,
                                    content: tsState.curTouristA.openDate +
                                        '${tsState.curTouristA.openDate == "" || tsState.curTouristA.openTime == "" ? "" : "\n"}' +
                                        tsState.curTouristA.openTime),
                            tsState.curTouristA.useTime == "null"
                                ? SizedBox(
                                    height: 0,
                                  )
                                : DetailsDescription(
                                    title: "用时参考",
                                    content: tsState.curTouristA.useTime,
                                  ),
                            tsState.curTouristA.busInfo == "null"
                                ? SizedBox(
                                    height: 0,
                                  )
                                : DetailsDescription(
                                    title: "交通信息",
                                    content: tsState.curTouristA.busInfo,
                                  ),
                            tsState.curTouristA.bestTime == ""
                                ? SizedBox(
                                    height: 0,
                                  )
                                : DetailsDescription(
                                    title: "旅游时节",
                                    content: tsState.curTouristA.bestTime,
                                  ),
                            tsState.curTouristA.tips == "null"
                                ? SizedBox(
                                    height: 0,
                                  )
                                : DetailsDescription(
                                    title: "游玩贴士",
                                    content: tsState.curTouristA.tips,
                                  ),

                            // 景点列表
                            tsState.curTouristSList.length == 0
                                ? SizedBox(
                                    height: 0,
                                  )
                                : TouristSpotsCard(tsState.curTouristSList),

                            // 配图
                            ImageListWidget(tsState.curTouristAImages),

                            DetailsComment(tsState.curTouristComments,
                                tsState.curTouristComments.length),

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
