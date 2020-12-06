import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wldt/pages/culture_page/culture_index_page.dart';
import 'package:wldt/pages/food_page/food_index_page.dart';
import 'package:wldt/pages/news_page/news_index_page.dart';
import 'package:wldt/pages/restaurant_page/restaurant_index_page.dart';
import 'package:wldt/pages/tourist_page/tourist_index_page.dart';
import 'package:wldt/providers/comments_provider.dart';
import 'package:wldt/providers/culture_provider.dart';
import 'package:wldt/providers/datong_provider.dart';
import 'package:wldt/providers/diary_providers.dart';
import 'package:wldt/providers/food_provider.dart';
import 'package:wldt/providers/news_provider.dart';
import 'package:wldt/providers/restaurant_provider.dart';
import 'package:wldt/providers/seek_help_provider.dart';
import 'package:wldt/providers/strategy_page_provider.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/providers/tourist_attraction_provider.dart';
import 'package:wldt/providers/tourist_spot_provider.dart';
import 'package:wldt/providers/travel_note_provider.dart';
import 'package:wldt/providers/trends_provider.dart';
import 'package:wldt/providers/user_provider.dart';
import 'package:wldt/providers/weather_provider.dart';
import 'pages/index_page/index.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>WeatherProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>FoodProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>RestaurantProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>CommentsProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>TouristAttractionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>TouristSpotProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>CultureProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>DaTongProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>DiaryProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>SeekHelpProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>StrategyProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>TravelNoteProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>TrendsProvider(),
          ),
          ChangeNotifierProvider(
            create: (context)=>NewsProvider(),
          ),

        ],
        child: Consumer<ThemeProvider>(builder: (_, themeState, __) {
          return MaterialApp(
            title: '文旅大同',
            debugShowCheckedModeBanner: false,
            theme: themeState.isDark?themeState.darkTheme:themeState.lightTheme,
            home: IndexPage(),
            routes: {
              "meishi":(BuildContext context)=>new FoodIndexPage(),
              "jingdian":(BuildContext context)=>new TouristIndexPage(),
              "wenhua":(BuildContext context)=> new CultureIndexPage(),
              "canting":(BuildContext context) => new RestaurantIndexPage(),
              "zixun":(BuildContext context) => new NewsIndexPage()
            },
          );
        }));
  }
}
