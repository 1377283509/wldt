from django.views import View
from utils.json_response.json_func import to_json_data
from .models import Culture


class GetAllCulture(View):
    def get(self, request):
        cultureList = Culture.objects.all()
        dataList = []
        for i in cultureList:
            dataList.append({
                "id":i.id,
                "title":i.title,
                "likeCounts":i.likeCounts,
                "image":i.image,
                "type":i.type.name,
                "url":i.url
            })
        return to_json_data(errno=0, errmsg="OK", data=dataList)
