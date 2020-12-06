// 用户名校验
bool phoneNumCheck(String username) {
  final RegExp userNameFxp =
      RegExp(r"^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\d{8}$");
  return userNameFxp.hasMatch(username);
}

// 密码校验
bool passwordCheck(String password){
  final RegExp passwordFxp = RegExp(r'^[\u4E00-\u9FA5A-Za-z0-9_]+$');
  return passwordFxp.hasMatch(password);
}

//邮箱校验
bool emailCheck(String emial){
  final RegExp emialExp = RegExp(r'^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$');
  return emialExp.hasMatch(emial);
}

