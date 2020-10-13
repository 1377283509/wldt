from django.http import HttpResponse
from django.views import View
from .models import TouristAttraction, TouristAttractionImage, TouristAttractionTag, TouristAttractionComment, \
    TouristSpot, TouristSpotImage,TouristSpotTag
from utils.json_response.json_func import to_json_data,Code,error_map
from django.core import serializers

# 获取所有景区
class GetAllTouristAttraction(View):
    def get(self,request):
        t_a_list = []
        tourist_attractions = TouristAttraction.objects.all()
        for t in tourist_attractions:
            image = t.touristattractionimage_set.values("url").first()
            tag = t.touristattractiontag_set.values("tag").first()
            if tag == None:
                tag = None
            else:
                tag = tag["tag"]
            t_a_list.append({
                "id":t.id,
                "name":t.name,
                "position":t.position,
                "tag":tag,
                "averageConsumption":t.averageConsumption,
                "score":t.commentCount.score,
                "commentNumber":t.commentCount.commentNumber,
                "image":image["url"],
            })
        return to_json_data(errno=Code.OK,errmsg=error_map[Code.OK],data=t_a_list)


# 通过id获取景区详情
class GetTouristAttractionDetails(View):
    def get(self,request):
        id = request.GET["id"]
        # 当前景区
        t_a = TouristAttraction.objects.get(id=id)
        # TODO:用户收藏状态

        t_a_info = {
            "id":t_a.id,
            "name":t_a.name,
            "position":t_a.position,
            "averageConsumption":t_a.averageConsumption,
            "description":t_a.description,
            "openDate":t_a.openDate.open_date,
            "openTime":t_a.openDate.open_time,
            "ticketInfo":t_a.ticketInfo,
            "useTime":t_a.useTime,
            "bestTime":t_a.bestTimes,
            "tips":t_a.bestTimes,
            "busInfo":t_a.busInfo,
            "score":t_a.commentCount.score,
            "commentNumber":t_a.commentCount.commentNumber,
            "positiveCommentNumber":t_a.commentCount.positiveCommentNumber,
            "negativeCommentNumber":t_a.commentCount.negativeCommentNumber,
            "isLike":False,
        }
        # 景区配图
        t_a_images = TouristAttractionImage.objects.filter(touristAttraction=t_a)
        image_list = []
        for i in t_a_images:
            image_list.append(i.url)
        # 评论
        t_a_comments = TouristAttractionComment.objects.filter(touristAttraction=t_a)
        if len(t_a_comments) > 2:
            t_a_comments = t_a_comments[0:2]
        comment_list = []
        for i in t_a_comments:
            imgs = []
            for j in i.touristattractioncommentimage_set.values("url"):
                imgs.append(j["url"])
            comment_list.append(
                {
                    "id": i.id,
                    "user_id":i.user_id,
                    "user_name":i.user.name,
                    "user_img":i.user.imgUrl,
                    "content":i.content,
                    "imgs":imgs,
                    "stars":i.stars,
                    "isGood":i.manner,
                    "isQuality":i.isQuality,
                    "publicTime":i.public_time.strftime("%Y.%m.%d")
                }
            )
        t_a_tags = TouristAttractionTag.objects.filter(touristAttraction=t_a)
        tag_list = []
        for i in t_a_tags:
            tag_list.append(i.tag)
        # 景点
        t_a_spots = TouristSpot.objects.filter(touristAttraction=t_a)
        tourist_spot_list = []
        for i in t_a_spots:
            img = i.touristspotimage_set.values("url").first()
            if not img:
                img = None
            else:
                img = img["url"]
            tourist_spot_list.append(
                {
                    "id":i.id,
                    "name":i.name,
                    "image":img
                }
            )
        data = {
            "tourist_attraction":t_a_info,
            "images":image_list,
            "comments":comment_list,
            "tourist_spot":tourist_spot_list,
            "tourist_tag":tag_list
        }

        return to_json_data(errno=Code.OK,errmsg=error_map[Code.OK],data=data)


# 通过id获取景点
class GetTouristSpotDetails(View):
    def get(self,request):
        id = request.GET["id"]
        print(id)
        # 当前景区
        t_s = TouristSpot.objects.get(id=id)
        t_s_info = {
            "id":t_s.id,
            "name":t_s.name,
            "position":t_s.position,
            "description":t_s.description,
            "openDate":t_s.openDate.open_date,
            "openTime":t_s.openDate.open_time,
            "history":t_s.history,
            "artistCharm":t_s.artistCharm,
            "feature":t_s.feature
        }
        # 景点配图
        t_s_images = TouristSpotImage.objects.filter(touristSpot=t_s)
        image_list = []
        for i in t_s_images:
            image_list.append(i.url)


        t_s_tags = TouristSpotTag.objects.filter(touristSpot=t_s)
        tag_list = []
        for i in t_s_tags:
            tag_list.append(i.tag)

        data = {
            "tourist_spot":t_s_info,
            "images":image_list,
            "tourist_tag":tag_list
        }

        return to_json_data(errno=Code.OK,errmsg=error_map[Code.OK],data=data)