import 'package:dio/dio.dart';

class Http {
  static const String baseUrl = "服务器IP:端口";
  static BaseOptions options = BaseOptions(
      connectTimeout: 5000, receiveTimeout: 5000, sendTimeout: 5000);
}

// 美食 相关 Url
class FoodUrl {
  static const String baseUrl = Http.baseUrl + "food/";
  static const String getFoodList = baseUrl + "get_all_foods/";
  static const String getFoodDetails = baseUrl + "get_food_by_id";
}

// 餐厅 相关 Url
class RestaurantUrl {
  static const String baseUrl = Http.baseUrl + "restaurant/";
  static const String getRestaurantList = baseUrl + "get_all_restaurants/";
  static const String getRestaurantDetails = baseUrl + "get_restaurant_by_id/";
}

// 景点 相关 Url
class TouristUrl {
  static const baseUrl = Http.baseUrl + "tourist_spot/";
  static const getTouristList = baseUrl + "get_all_tourist_attraction";
  static const getTouristAttraction =
      baseUrl + "get_tourist_attraction_details";
  static const getTouristSpot = baseUrl + "get_tourist_spot_details";
}

// 用户 相关 Url
class UserUrl {
  static const baseUrl = Http.baseUrl + "user/";
  static const login = baseUrl + "login/";
  static const register = baseUrl + "register/";
}

// 小记 相关 Url
class DiaryUrl{
  static const baseUrl = Http.baseUrl + "diary/";
  static const getAllDiary = baseUrl + "get_all_diary/";
  static const publicDiary = baseUrl + "public_diary/";
}

// 文化 相关 Url
class CultureUrl{
  static const baseUrl = Http.baseUrl + "culture/";
  static const getAllCulture = baseUrl + "get_all_culture";
}

// 游记 相关 Url
class TravelNoteUrl{
  static const baseUrl = Http.baseUrl + "travel_note/";
  static const getAllTravelNote = baseUrl + "get_all_travel_notes";
  static const getTravelNoteById = baseUrl + "get_travel_note_by_id";
}

// 攻略 相关 Url
class StrategyUrl{
  static const baseUrl = Http.baseUrl + "strategy/";
  static const getAllStrategy = baseUrl + "get_all_strategy";
  static const getStrategyById = baseUrl + "get_strategy_by_id";
}

// 动态 相关 Url
class TrendsUrl{
  static const baseUrl = Http.baseUrl + "trends/";
  static const getAllTrends = baseUrl + "get_all_trends";
  static const getTrendById = baseUrl + "get_trends_by_id";
}

// 求助 相关 Url
class SeekHelpUrl{
  static const baseUrl = Http.baseUrl + "seek_help/";
  static const getAllHelp = baseUrl + "get_all_help";
  static const getTravelHelpById = baseUrl + "get_help_by_id";
}