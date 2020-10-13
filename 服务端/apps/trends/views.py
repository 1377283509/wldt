from django.views import View
from utils.json_response.json_func import to_json_data
from .models import Trends,TrendsImage,TrendsComment,TrendsCommentImage


class GetAllTrends(View):
    def get(self,request):
        trends = Trends.objects.all()
        dataList = []
        for trend in trends:
            # 获取配图列表
            imageList = []
            images = TrendsImage.objects.filter(trends=trend).all()
            for image in images:
                imageList.append(image.url)
            # 获取评论列表
            comments = TrendsComment.objects.filter(trends=trend).order_by("date").all()
            # 添加进list
            dataList.append({
                "id":trend.id,
                "userName":trend.user.name,
                "likeCounts":trend.likeCounts,
                "userImage":trend.user.imgUrl,
                "content":trend.content,
                "pubDate":trend.pubDate.strftime("%Y.%m.%d %H:%M"),
                "tag":trend.tag.name,
                "images":imageList,
                "commentsCount":comments.count()
            })
        return to_json_data(errno=0, errmsg="OK", data=dataList)


class GetTrendsDetailsById(View):
    def get(self,request):
        trend_id = request.GET["id"]
        try:
            trend = Trends.objects.get(id=trend_id)
            # 获取配图列表
            imageList = []
            images = TrendsImage.objects.filter(trends=trend).all()
            for image in images:
                imageList.append(image.url)
            # 获取评论列表
            commentList = []
            comments = TrendsComment.objects.filter(trends=trend).order_by("date").all()
            for comment in comments:
                imgs = TrendsCommentImage.objects.filter(comment=comment).all()
                imgList = []
                for img in imgs:
                    imgList.append(img.url)
                commentList.append({
                    "userName": comment.user.name,
                    "userImage": comment.user.imgUrl,
                    "content": comment.content,
                    "pubDate": comment.date.strftime("%Y.%m.%d %H:%M"),
                    "images": imgList,
                    "likeCounts": comment.likeCounts
                })
            data={
                "likeCounts":trend.likeCounts,
                "userName": trend.user.name,
                "userImage": trend.user.imgUrl,
                "content": trend.content,
                "pubDate": trend.pubDate.strftime("%Y.%m.%d %H:%M"),
                "tag": trend.tag.name,
                "images": imageList,
                "comments": commentList
            }
            return to_json_data(errno=1, errmsg="None Data",data=data)
        except Exception as e:
            return to_json_data(errno=1,errmsg="None Data")
