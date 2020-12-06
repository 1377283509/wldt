class UserModel {
  String name;
  String phone;
  String gender;
  String birth;
  String address;
  String introduce;
  String imgUrl;
  String trendNum;
  String fansNum;
  String focusNum;

  UserModel();

  @override
  String toString() {
  return this.name;
   }

  UserModel.fromJson(Map json)
      : name = json["name"],
        phone = json["phone"],
        gender = json["gender"]?"男":"女",
        birth = json["birth"],
        address = json["address"],
        introduce = json["introduce"],
        imgUrl = json["imgUrl"],
        fansNum = json["fansNum"].toString(),
        focusNum = json["focusNum"].toString(),
        trendNum = json["trendNum"].toString();

  Map toMap() {
    return {
      "name": this.name,
      "phone": this.phone,
      "gender": this.gender,
      "birth": this.birth,
      "address": this.address,
      "introduce": this.introduce,
      "imgUrl": this.imgUrl,
      "fansNum": this.fansNum,
      "focusNum": this.focusNum,
      "trendNum": this.trendNum
    };
  }
}
