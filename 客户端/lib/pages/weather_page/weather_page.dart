import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/providers/weather_provider.dart';

// 天气详情页

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, WeatherProvider>(
      builder: (_,themeState,weatherState,__){
        return FutureBuilder(
          builder: (context,s){
              return Scaffold(
          appBar: AppBar(
            title: Text("大同天气"),
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: (){},
              )
            ],
          ),
          body: _Body(),
        );
          },
        );
      },
    );
  }
}

class _Body extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _ToDayWeather(),
          ],
        ),
      ),
    );
    
  }
}

class _ToDayWeather extends StatelessWidget {
  const _ToDayWeather({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("今日天气"),
    );
  }
}