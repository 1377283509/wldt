from django.urls import path
from .views import GetAllTouristAttraction,GetTouristAttractionDetails,GetTouristSpotDetails

app_name = "tourist_spot"
urlpatterns = [
    path("get_all_tourist_attraction/",GetAllTouristAttraction.as_view(),name="get_all_tourist_attraction"),
    path("get_tourist_attraction_details/",GetTouristAttractionDetails.as_view(),name="get_tourist_attraction_details"),
    path("get_tourist_spot_details/",GetTouristSpotDetails.as_view(),name="get_tourist_spot_details"),
]
