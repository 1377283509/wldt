import 'package:flutter/material.dart';
import 'package:wldt/models/tourist_spot_model.dart';
import 'package:wldt/pages/tourist_page/widgets/tourist_spot_widget.dart';
import 'package:wldt/res/global_config.dart';

class TouristSpotsCard extends StatelessWidget{
  final List<SimpleTouristSpot> touristSpots;
  TouristSpotsCard(this.touristSpots);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 标题
          Container(
            padding: EdgeInsets.only(left: 8.0),
            decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.orange,width: 4.0,style: BorderStyle.solid))
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "景区景点",
              style: TextStyle(
                  fontSize: ThemeConfig.nomalFontSize,
                  fontWeight: FontWeight.bold,
                  decorationStyle: TextDecorationStyle.double,
                  decorationThickness: 2.0,
                  decorationColor: Colors.redAccent,
                  letterSpacing: 3.0
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          // 景点

          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: touristSpots.map((e) => TouristSpotWidget(e)).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}