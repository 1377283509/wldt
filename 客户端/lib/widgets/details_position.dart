
import 'package:flutter/material.dart';
import 'package:wldt/res/global_config.dart';

class DetailsPosition extends StatelessWidget{
  final String pos;
  DetailsPosition(this.pos);

//  launchURL(String pos) async {
//    String url = 'androidamap://keywordNavi?sourceApplication=softname&keyword=$pos&style=2';
//    if (await canLaunch(url)) {
//      await launch(url);
//    } else {
//      throw 'Could not launch $url';
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0,),
      margin: EdgeInsets.only(top: 4.0,bottom: 4.0,left: 8.0,right: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: Colors.grey,
                  size: ThemeConfig.smallIconSize,
                ),
                SizedBox(width: 4.0,),
                Container(
                  width: 280,
                  child: Text(pos,maxLines: 2,softWrap: true,textAlign: TextAlign.left,),
                ),
              ],
            ),
          ),
          IconButton(icon: Icon(Icons.chevron_right), onPressed: (){
//            launchURL(this.pos);

          })
        ],
      ),
    );
  }
}
