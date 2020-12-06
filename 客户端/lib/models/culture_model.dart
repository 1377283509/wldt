class Culture{
  String id;
  int likeCounts;
  String title;
  String url;
  String image;
  String type;

  Culture.fromJson(Map<String, dynamic> json)
    : id = json["id"].toString(),
      likeCounts = json["likeCounts"],
      title = json["title"],
      url = json["url"],
      image = json["image"],
      type = json["type"];
}