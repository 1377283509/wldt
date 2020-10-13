from django.views import View
from utils.json_response.json_func import to_json_data
from .models import HelpInfo,HelpInfoImage,HelpComment,HelpCommnetImage


class GetAllHelp(View):
    def get(self,request):
        helps = HelpInfo.objects.all()
        dataList = []
        for help in helps:
            # 获取配图列表
            imageList = []
            images = HelpInfoImage.objects.filter(help=help).all()
            for image in images:
                imageList.append(image.url)
            # 获取评论数量
            comments = HelpComment.objects.filter(helpInfo=help).all()
            # 添加进list
            dataList.append({
                "id":help.id,
                "userName":help.user.name,
                "userImage":help.user.imgUrl,
                "content":help.content,
                "pubDate":help.pubDate.strftime("%Y.%m.%d %H:%M"),
                "tag":help.tag,
                "images":imageList,
                "commentsCount":comments.count()
            })
        return to_json_data(errno=0, errmsg="OK", data=dataList)


class GetHelpDetailsById(View):
    def get(self,request):
        help_id = request.GET["id"]
        try:
            help = HelpInfo.objects.get(id=help_id)
            # 获取配图列表
            imageList = []
            images = HelpInfoImage.objects.filter(help=help).all()
            for image in images:
                imageList.append(image.url)
            # 获取评论列表
            commentList = []
            comments = HelpComment.objects.filter(helpInfo=help).order_by("date").all()
            for comment in comments:
                imgs = HelpCommnetImage.objects.filter(helpComment=comment).all()
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
            data = {
                "userName": help.user.name,
                "userImage": help.user.imgUrl,
                "content": help.content,
                "pubDate": help.pubDate.strftime("%Y.%m.%d %H:%M"),
                "tag": help.tag,
                "images": imageList,
                "comments": commentList
            }
            return to_json_data(errno=1, errmsg="None Data",data=data)
        except Exception as e:
            print(e)
            return to_json_data(errno=1,errmsg="None Data")
