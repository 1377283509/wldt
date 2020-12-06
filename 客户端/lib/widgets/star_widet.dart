import 'package:flutter/material.dart';
import 'package:wldt/res/global_config.dart';



class StarWidget extends StatelessWidget{

  final double score;
  StarWidget(this.score);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          score >= 1
              ? FullStar(true)
              : score > 0.5
              ? HalfStar()
              : FullStar(false),
          score >= 2
              ? FullStar(true)
              : score > 1.5
              ? HalfStar()
              : FullStar(false),
          score >= 3
              ? FullStar(true)
              : score> 2.5
              ? HalfStar()
              : FullStar(false),
          score >= 4
              ? FullStar(true)
              : score > 3.5
              ? HalfStar()
              : FullStar(false),
          score >= 5
              ? FullStar(true)
              : score> 4.5
              ? HalfStar()
              : FullStar(false),
        ],
      ),
    );
  }



}


class FullStar extends StatelessWidget{
  final bool isOK;
  FullStar(this.isOK);
  @override
  Widget build(BuildContext context) {
    return Icon(
      isOK?Icons.star:Icons.star_border,
      size: ThemeConfig.smallIconSize,
      color: isOK?Colors.orange[300]:Colors.grey,
    );
  }
}

class HalfStar extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.star_half,
      color: Colors.orange[300],
      size: ThemeConfig.smallIconSize,
    );
  }


}
