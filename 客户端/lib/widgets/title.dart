import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final String routeName;
  const TitleWidget({this.title,this.routeName,Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16,right:20,top: 4.0,bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
          InkWell(
            onTap:(){
              Navigator.of(context).pushNamed(routeName);
            },
            child:Text("更多",style: TextStyle(fontSize: 14,color: Colors.grey),)
          )
        ],
      ),
    );
  }
}