import 'package:wldt/models/restaurant_model.dart';

class Food {
  int id;
  String name;
  String description;
  String story;
  String feature;
  String practice;
  String value;
  bool islike;
  int likeCounts;
  String tag;
  Food(
      this.id,
      this.name,
      this.description,
      this.feature,
      this.practice,
      this.story,
      this.value,
      this.islike,
      this.likeCounts,
      this.tag);

  @override
  String toString(){
    return "$id-$name-$tag-";
  }

  Food.fromJson(Map<String, dynamic> json)
      :id = json["id"],
        name = json["name"],
        description = json["description"],
        feature = json["feature"],
        practice = json["practice"],
        story = json["story"],
        value = json["value"],
        likeCounts = json["likeCounts"],
        tag = json["tag"],
        islike = json["islike"];
}

class SimpleFood {
  int id;
  String name;
  String description;
  int restaurant_counts;
  String image;

  SimpleFood(
      this.id, this.name, this.restaurant_counts, this.image, this.description);

  SimpleFood.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = json["id"],
        description = json["description"],
        image = json["image"],
        restaurant_counts = json["restaurant_counts"];
}
