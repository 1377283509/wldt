import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wldt/models/restaurant_model.dart';
import 'package:wldt/pages/restaurant_page/restaurant_details_page.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/res/global_config.dart';

class RestaurantCard extends StatelessWidget {
  final SimpleRestaurant restaurant;
  final isBorder;
  RestaurantCard(this.restaurant, {this.isBorder = false});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeState, __) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => RestaurantDetailsPage(restaurant.id)));
          },
          child: AspectRatio(
            aspectRatio: 3.2,
            child: Container(
              padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 4.0,bottom: 4.0),
              margin: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0,bottom: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: isBorder ? null : BorderRadius.circular(12),
                border: isBorder
                    ? Border(
                        top: BorderSide(color: Colors.grey[300], width: 1.0))
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // 图片
                  Container(
                    height: 100.0,
                    width: 110.0,
                    child: Image(
                      image: NetworkImage(restaurant.imgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                  // 右侧信息
                  Container(
                    width: .56 * MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                restaurant.name,
                                style: TextStyle(
                                    fontSize: ThemeConfig.larggerFontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "${restaurant.score}分",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: ThemeConfig.smallFontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                "${restaurant.commentNumber}条评论",
                                style: TextStyle(
                                    fontSize: ThemeConfig.smallFontSize,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),

                        // 标签
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.grey,
                                        size: ThemeConfig.smallIconSize,
                                      ),
                                      Container(
                                        width: 140,
                                        child: Text(
                                          "${restaurant.position}",
                                          style: TextStyle(
                                              fontSize:
                                              ThemeConfig.smallFontSize),
                                          maxLines: 2,
                                          softWrap: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  child: Text(
                                "人均￥${restaurant.averageConsumption}",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
