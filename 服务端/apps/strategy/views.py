from django.views import View
from .models import Strategy, StrategyImage
from utils.json_response.json_func import to_json_data, Code, error_map


# 获取所有攻略
class GetAllStrategy(View):

    def get(self, request):
        strategy_list = []
        strategies = Strategy.objects.all()
        for r in strategies:
            tag = r.tag.first()
            if not tag:
                tag = None
            else:
                tag = tag.name
            print(r.strategyimage_set.all())
            strategy_list.append(
                {
                    "id": r.id,
                    "title": r.title,
                    "likeCounts":r.likeCounts,
                    "image": r.strategyimage_set.first().url,
                    "userName":r.user.name,
                    "userImage":r.user.imgUrl,
                    "pubDate":r.pubDate.strftime("%Y/%m/%d")
                }
            )
        return to_json_data(errno=Code.OK, errmsg=error_map[Code.OK], data=strategy_list)


# 获取游记详情
class GetStrategyDetails(View):
    def get(self,request):
        try:
            id = request.GET["id"]
            strategy = Strategy.objects.get(id=id)
            # 标签
            tag_list = []
            tags = strategy.tag.all()
            for t in tags:
                tag_list.append(t.name)
            # 配图
            img_list = []
            images = strategy.strategyimage_set.all()
            for i in images:
                img_list.append(i.url)
            data = {
                "strategy": {
                    "id": strategy.id,
                    "title": strategy.title,
                    "address": strategy.address,
                    "userName": strategy.user.name,
                    "userImage": strategy.user.imgUrl,
                    "likeCounts": strategy.likeCounts,
                    "content": strategy.content,
                    "pubDate": strategy.pubDate.strftime("%Y/%m/%d")
                },
                "images": img_list,
                "tags": tag_list,
            }
            return to_json_data(errno=Code.OK, errmsg=error_map[Code.OK], data=data)
        except Exception as e:
            return to_json_data(errno=Code.NODATA,errmsg="{{}}".format(e))
