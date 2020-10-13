from django.urls import path
from .views import GetAllDiary,AddDiary

app_name = "diary"
urlpatterns = [
    path("get_all_diary/",GetAllDiary.as_view(),name="get_all_diary"),
    path("public_diary/",AddDiary.as_view(),name="add_diary"),
]
