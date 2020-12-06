// 美食列表
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/food_model.dart';
import 'package:wldt/pages/food_page/food_details_page.dart';

class FoodList extends StatelessWidget {
  final List<SimpleFood> foodList;
  const FoodList({this.foodList, key}) : super(key: key);
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
            children: foodList.map((e) => FoodImage(e)).toList(),
          ),
        ));
  }
}

class FoodImage extends StatelessWidget {
  final SimpleFood food;
  const FoodImage(this.food, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) => FoodDetailsPage(food.id)));
      },
      child: Container(
          width: 200,
          height: 160,
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(right: 8.0),
          padding: EdgeInsets.only(left: 8.0, bottom: 8.0, right: 8.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                  image: NetworkImage(
                    food.image,
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black26,
                ),
                child: Text(
                  "# ${food.name}",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2.0),
                padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black26,
                ),
                child: Text(
                  "${food.description}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
    );
  }
}
