from django.urls import path
from .views import GetAllRestaurants,GetRestaurantDetails

app_name = "restaurant"
urlpatterns = [
    path("get_all_restaurants/",GetAllRestaurants.as_view(),name="get_all_restaurants"),
    path("get_restaurant_by_id/",GetRestaurantDetails.as_view(),name="get_restaurant_by_id")
]