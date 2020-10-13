from django.urls import path
from .views import GetAllFood,GetFoodDetails

app_name = "food"
urlpatterns = [
    path("get_all_foods/",GetAllFood.as_view(),name="get_all_foods"),
    path("get_food_by_id/",GetFoodDetails.as_view(),name="get_food_by_id")
]
