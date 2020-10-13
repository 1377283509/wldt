from django.views import View
from utils.json_response.json_func import to_json_data
from .models import Diary
import json
from user.models import User


class AddDiary(View):
    def post(self,request):
        phone = request.POST.get("phone")
        content = request.POST.get("content")
        image = request.FILES.get("image")
        user = User.objects.get(phone=phone)
        try:
            # Diary.objects.create(user=user, image=image, content=content)
            # diary = Diary.objects.get(user__phone=phone)
            diary = Diary(user=user, image=image, content=content)
            diary.save()
            res = {
                "id":diary.id,
                "content":diary.content,
                "image":"http://47.93.130.219:8000" + diary.image.url,
                "pubDate":diary.date.strftime("%Y/%m/%d"),
                "userName":diary.user.name,
                "userImage":diary.user.imgUrl
            }
            return to_json_data(errno=0, errmsg="OK", data=res)
        except Exception as e:
            print(e)
            to_json_data(errno=1, errmsg="发布失败")


class GetAllDiary(View):
    def get(self, request):
        try:
            phone = request.GET["phone"]
        except Exception as e:
            phone = None
        if phone:
            list = Diary.objects.filter(user__phone=phone).all()
        else:
            list = Diary.objects.all()
        dataList = []
        for i in list:
            dataList.append({
                "id":i.id,
                "content":i.content,
                "image":"http://47.93.130.219:8000"+i.image.url,
                "userName":i.user.name,
                "likeCount":i.likeCount,
                "userImage":i.user.imgUrl,
                "pubDate":i.date.strftime("%Y/%m/%d")
            })
        return to_json_data(errno=0,errmsg="OK",data=dataList)