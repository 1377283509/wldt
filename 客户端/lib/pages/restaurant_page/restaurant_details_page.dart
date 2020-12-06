import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wldt/providers/restaurant_provider.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/details_comment.dart';
import 'package:wldt/widgets/details_description.dart';
import 'package:wldt/widgets/details_position.dart';
import 'package:wldt/widgets/images_list.dart';
import 'package:wldt/widgets/tag_widget.dart';

class RestaurantDetailsPage extends StatelessWidget {
  final int id;
  RestaurantDetailsPage(this.id);
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, RestaurantProvider>(
      builder: (_, themeState, restaurantState, __) {
        return FutureBuilder(
            future: restaurantState.getRestaurantById(id),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done?Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: restaurantState.curRestaurant.isCollect
                        ? Colors.grey
                        : Colors.red,
                    child: Icon(
                      restaurantState.curRestaurant.isCollect
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        RestaurantDetailsBar(
                          img: restaurantState.curImages.first,
                          isLike: restaurantState.curRestaurant.isCollect,
                        ),
                        RestaurantDetailsTitle(
                            restaurantState.curRestaurant.name,
                            restaurantState.curRestaurant.score,
                            restaurantState.curRestaurant.commentNumber,
                            restaurantState.curRestaurant.averageConsumption,
                            restaurantState.curTags),
                        restaurantState.curRestaurant.description == "null"
                            ? Container()
                            : DetailsDescription(
                          content:
                          restaurantState.curRestaurant.description,
                        ),
                        DetailsPosition(restaurantState.curRestaurant.position),
                        RestaurantFoodListWidget(restaurantState.curFood),
                        // 开放日期
                        restaurantState.curRestaurant.openTime == "" &&
                            restaurantState.curRestaurant.openDay == ""
                            ? SizedBox(
                          height: 0,
                        )
                            : DetailsDescription(
                            title: "开放时间",
                            isExpanded: true,
                            content: restaurantState.curRestaurant.openDay +
                                '${restaurantState.curRestaurant.openDay == "" || restaurantState.curRestaurant.openTime == "" ? "" : "\n"}' +
                                restaurantState.curRestaurant.openTime),
                        restaurantState.curRestaurant.phone == "null"?SizedBox(height: 0,):DetailsDescription(
                          title: "联系方式",
                          content: restaurantState.curRestaurant.phone,
                        ),
                        restaurantState.curImages.length == 0?SizedBox(height: 0,):ImageListWidget(restaurantState.curImages),
                        DetailsComment(restaurantState.curComments,
                            restaurantState.curRestaurant.commentNumber),
                        SizedBox(
                          height: 8.0,
                        )
                      ],
                    ),
                  )):Scaffold(
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

class RestaurantFoodListWidget extends StatelessWidget {
  final List<String> contents;
  RestaurantFoodListWidget(this.contents);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // title
            Container(
              padding: EdgeInsets.only(left: 8.0),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: Colors.orange,
                          width: 4.0,
                          style: BorderStyle.solid))),
              alignment: Alignment.centerLeft,
              child: Text(
                "推荐菜品",
                style: TextStyle(
                    fontSize: ThemeConfig.nomalFontSize,
                    fontWeight: FontWeight.bold,
                    decorationStyle: TextDecorationStyle.double,
                    decorationThickness: 2.0,
                    decorationColor: Colors.redAccent,
                    letterSpacing: 3.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Wrap(
                children: contents
                    .map((e) => Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Container(
                            padding: EdgeInsets.only(left: 6.0,right: 6.0,top: 2.0,bottom: 2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(color: Colors.grey)
                            ),
                            child: Text(e),
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        ));
  }
}

class RestaurantDetailsTitle extends StatelessWidget {
  final String name;
  final String score;
  final int commentNumber;
  final List<String> tags;
  final int averageConsumption;

  RestaurantDetailsTitle(this.name, this.score, this.commentNumber,
      this.averageConsumption, this.tags);

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: ThemeConfig.maximalFontSize),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        score.toString() + "分",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: ThemeConfig.smallFontSize),
                      ),
                      Text(
                        commentNumber.toString() + "条评论",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: ThemeConfig.smallFontSize),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: tags.map((v) => TagWidget(v)).toList(),
                  ),
                ),
                Text(
                  "人均￥$averageConsumption",
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantDetailsBar extends StatelessWidget {
  final String img;
  final bool isLike;
  final Function function;
  RestaurantDetailsBar({this.img, this.isLike, this.function});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 240,
      decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(img), fit: BoxFit.cover)),
      child: SafeArea(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                // TODO:分享
              },
              icon: Icon(
                Icons.share,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
