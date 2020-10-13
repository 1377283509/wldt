from django.shortcuts import render
from django.views import View
import json

from utils.json_response.json_func import to_json_data, Code
from .models import User


class Login(View):
    def post(self, request):
        data = json.loads(request.body)
        phone = data["phone"]
        password = data["password"]
        users = User.objects.filter(phone=phone).all()
        if len(users) == 0:
            return to_json_data(errno=1, errmsg="用户不存在")
        else:
            try:
                user = User.objects.get(phone=phone)
                if user.password != password:
                    return to_json_data(errno=1, errmsg="密码错误")
                data = {
                    "name": user.name,
                    "gender": user.gender,
                    "address": user.address,
                    "birth": user.birth,
                    "introduce": user.introduce,
                    "imgUrl": user.imgUrl,
                    "phone": user.phone,
                    "fansNum": 0,
                    "focusNum": 0,
                    "trendNum": 0
                }
                return to_json_data(errno=0, errmsg="登录成功", data=data)
            except Exception as e:
                print(e)
                return to_json_data(errno=1, errmsg="未知错误")


class Register(View):
    def post(self, request):
        data = json.loads(request.body)
        phone = data["phone"]
        password = data["password"]
        users = User.objects.filter(phone=phone).all()
        if len(users) > 0:
            return to_json_data(errno=1, errmsg="该手机已被注册")
        else:
            try:
                User.objects.create(name="用户{}".format(phone),phone=phone ,password=password, introduce="写一段个人介绍，让大家认识一下吧！",address="保密",birth="2000.01.01")
                user = User.objects.get(phone=phone)
                data = {
                    "name":user.name,
                    "gender":user.gender,
                    "address":user.address,
                    "birth":user.birth,
                    "introduce":user.introduce,
                    "imgUrl":user.imgUrl,
                    "phone":user.phone,
                    "fansNum":0,
                    "focusNum":0,
                    "trendNum":0
                }
                return to_json_data(errno=0, errmsg="注册成功",data=data)
            except Exception as e:
                print(e)
                return to_json_data(errno=1, errmsg="未知错误")
