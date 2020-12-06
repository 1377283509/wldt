class Restaurant {
  int id;
  String name; // 餐厅名
  String score; // 评分
  int commentNumber; // 评论数
  String position; // 位置
  int averageConsumption; // 平均消费
  String description; // 简介
  String phone; // 联系方式
  String openDay; // 开放日
  String openTime; // 开放时间段
  bool isCollect; // 是否收藏

  Restaurant({
    this.id,
    this.name,
    this.score,
    this.commentNumber,
    this.position,
    this.averageConsumption,
    this.description,
    this.openDay,
    this.openTime,
    this.phone,
    this.isCollect,
  });
  Restaurant.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        score = json["score"],
        commentNumber = json["commentNumber"],
        position = json["position"],
        averageConsumption = json["averageConsumption"],
        description = json["description"],
        openDay = json["openDate"],
        openTime = json["openTime"],
        isCollect = json["isCollect"],
        phone = json["phone"];
}

class SimpleRestaurant {
  int id;
  String name;
  String score;
  int commentNumber;
  String tag;
  String imgUrl;
  String position;
  int averageConsumption;
  SimpleRestaurant(this.name, this.score, this.commentNumber, this.tag,
      this.averageConsumption, this.position, this.imgUrl, this.id);

  SimpleRestaurant.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        score = json["score"],
        commentNumber = json["commentNumber"],
        tag = json["tag"],
        imgUrl = json["imgUrl"],
        position = json["position"],
        averageConsumption = json["averageConsumption"];
}
