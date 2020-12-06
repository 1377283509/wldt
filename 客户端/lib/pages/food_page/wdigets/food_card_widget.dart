import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wldt/models/food_model.dart';
import 'package:wldt/pages/food_page/food_details_page.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/tag_widget.dart';

class FoodCard extends StatelessWidget {
  final SimpleFood food;
  FoodCard(this.food);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeState, __) {
        return InkWell(
          onTap: (){
            Navigator.of(context).push(CupertinoPageRoute(builder: (BuildContext context)=>new FoodDetailsPage(food.id)),);
          },
          child:  AspectRatio(
            aspectRatio: 3.5,
            child: Container(
              padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 4.0,bottom: 4.0),
              margin: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0,bottom: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: .28 * MediaQuery.of(context).size.width,
                    width: .28 * MediaQuery.of(context).size.width,
                    child: Image(
                      image: NetworkImage(food.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: .6 * MediaQuery.of(context).size.width,
                    height: .3 * MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          food.name,
                          style: TextStyle(
                              fontSize: ThemeConfig.larggerFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          food.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Icon(
                                  Icons.restaurant,
                                  size: 16,
                                  color: Colors.orange,
                                ),
                              ),
                              SizedBox(width: 4.0,),
                              Container(
                                  child: Text(food.restaurant_counts.toString()+"家推荐餐厅",style: TextStyle(
                                    fontSize: ThemeConfig.smallFontSize,
                                    color: Colors.orange
                                  ),),
                              ),

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
