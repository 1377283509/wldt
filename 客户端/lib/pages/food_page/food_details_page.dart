import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wldt/models/restaurant_model.dart';
import 'package:wldt/pages/food_page/wdigets/restaurant_card.dart';
import 'package:wldt/providers/food_provider.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/widgets/details_description.dart';
import 'package:wldt/widgets/details_title.dart';
import 'package:wldt/widgets/images_list.dart';


// 美食详情页


class FoodDetailsPage extends StatelessWidget {
  final int id;
  FoodDetailsPage(this.id);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, FoodProvider>(
      builder: (_, themeState, foodState, __) {
        return FutureBuilder(
            future: foodState.getFoodById(id),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done?Scaffold(
                  body: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        DetailsBar(
                          img: foodState.images[0],
                          isLike: foodState.curFood.islike,
                        ),
                        DetailsTitle(
                          foodState.curFood.name,
                          foodState.curFood.likeCounts,
                          tag: foodState.curFood.tag,
                        ),
                        DetailsDescription(
                          content: foodState.curFood.description,
                          isExpanded: true,
                        ),
                        DetailsDescription(
                          title: "传说",
                          content: foodState.curFood.story,
                        ),
                        DetailsDescription(
                          title: "特点",
                          content: foodState.curFood.feature,
                        ),
                        DetailsDescription(
                          title: "做法",
                          content: foodState.curFood.practice,
                        ),
                        DetailsDescription(
                          title: "营养价值",
                          content: foodState.curFood.value,
                        ),
                        ImageListWidget(foodState.images),
                        foodState.restaurants.length==0?Container():RecommendRestaurant(foodState.restaurants),
                        SizedBox(height: 8.0,),
                      ],
                    ),
                  )):Scaffold(
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

class RecommendRestaurant extends StatelessWidget {
  final List<SimpleRestaurant> restaurants;
  RecommendRestaurant(this.restaurants);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12.0)),
        margin: EdgeInsets.only(left: 8.0,right: 8.0),
        padding: EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              margin: EdgeInsets.only(left: 20.0, right: 8.0, top: 18.0),
              decoration: BoxDecoration(
                // border: Border(left: BorderSide(color: Colors.orange,width: 4.0),right: BorderSide(color: Colors.orange,width: 4.0)),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                "推荐餐厅",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.dotted,
                    decorationThickness: 8.0,
                    decorationColor: Colors.orange,
                    letterSpacing: 3.0),
              ),
            ),
            SizedBox(height: 18.0,),
            Column(
              children: restaurants.map((e) => RestaurantCard(e,isBorder: true,)).toList(),
            ),
          ],
        ));
  }
}

class DetailsBar extends StatelessWidget {
  final String img;
  final bool isLike;
  final Function function;
  DetailsBar({this.img, this.isLike, this.function});
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
