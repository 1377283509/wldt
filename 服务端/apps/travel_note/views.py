from django.views import View
from .models import TravelNote, TravelNoteImage
from utils.json_response.json_func import to_json_data, Code, error_map


# 获取所有游记
class GetAllTravelNotes(View):

    def get(self, request):
        note_list = []
        notes = TravelNote.objects.all()
        for r in notes:
            tag = r.tag.first()
            if not tag:
                tag = None
            else:
                tag = tag.name
            note_list.append(
                {
                    "id": r.id,
                    "title": r.title,
                    "tag": tag,
                    "likeCounts":r.likeCounts,
                    "image": r.travelnoteimage_set.first().url,
                    "userName":r.user.name,
                    "userImage":r.user.imgUrl,
                    "pubDate":r.pubDate.strftime("%Y.%m.%d")
                }
            )
        return to_json_data(errno=Code.OK, errmsg=error_map[Code.OK], data=note_list)


# 获取游记详情
class GetTravelNoteDetails(View):
    def get(self,request):
        try:
            id = request.GET["id"]
            print(id)
            note = TravelNote.objects.get(id=id)
            # 标签
            tag_list = []
            tags = note.tag.all()
            print(tags)
            for t in tags:
                tag_list.append(t.name)
            # 配图
            img_list = []
            images = TravelNoteImage.objects.filter(travel_note=note)
            for i in images:
                img_list.append(i.url)
            data = {
                "travel_note": {
                    "id": note.id,
                    "title": note.title,
                    "address": note.address,
                    "userName": note.user.name,
                    "userImage": note.user.imgUrl,
                    "likeCounts": note.likeCounts,
                    "content": note.content,
                    "pubDate": note.pubDate.strftime("%Y/%m/%d")
                },
                "images": img_list,
                "tags": tag_list,
            }
            return to_json_data(errno=Code.OK, errmsg=error_map[Code.OK], data=data)
        except Exception as e:
            pass