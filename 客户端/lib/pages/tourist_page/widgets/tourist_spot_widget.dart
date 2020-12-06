import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/tourist_spot_model.dart';
import 'package:wldt/res/global_config.dart';

import '../tourist_spot_details.dart';

class TouristSpotWidget extends StatelessWidget {
  final SimpleTouristSpot touristSpot;

  TouristSpotWidget(this.touristSpot);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(CupertinoPageRoute(
          builder: (context)=>TouristSpotDetailsPage(touristSpot.id),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            touristSpot.image == null
                ? Container(
                width: 100,
                height: 100,
                alignment: Alignment.center,
                color: Colors.grey[200],
                child: Text("暂无图片"))
                : Container(
                width: 100,
                height: 100,
                child: Image.network(
                  touristSpot.image,
                  fit: BoxFit.cover,
                )),
            Container(
              margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
              child: Text(
                touristSpot.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: ThemeConfig.smallFontSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
