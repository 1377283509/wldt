// 美食列表
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/restaurant_model.dart';
import 'package:wldt/pages/restaurant_page/restaurant_details_page.dart';

class RestaurantList extends StatelessWidget {
  final List<SimpleRestaurant> restaurantList;
  const RestaurantList({this.restaurantList, key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.only(left: 8.0, right: 0.0),
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: restaurantList.map((e) => RestaurantImage(e)).toList(),
          ),
        ));
  }
}

class RestaurantImage extends StatelessWidget {
  final SimpleRestaurant simpleRestaurant;
  const RestaurantImage(this.simpleRestaurant, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => RestaurantDetailsPage(simpleRestaurant.id)));
      },
      child: Container(
          width: 240,
          height: 180,
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(right: 8.0),
          padding: EdgeInsets.only(left: 8.0, bottom: 6.0, right: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                  image: NetworkImage(
                    simpleRestaurant.imgUrl,
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              simpleRestaurant.tag == null?Container():Container(
                margin: EdgeInsets.only(top: 8.0),
                padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.orange,
                ),
                child: Text(
                  "${simpleRestaurant.tag}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black26,
                ),
                child: Text(
                  "# ${simpleRestaurant.name}",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )),
    );
  }
}
