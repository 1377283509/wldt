from django.urls import path
from .views import GetAllTrends,GetTrendsDetailsById

app_name = "trends"
urlpatterns = [
    path("get_all_trends/",GetAllTrends.as_view(),name="get_all_trends"),
    path("get_trends_by_id/",GetTrendsDetailsById.as_view(),name="get_trends_by_id")
]