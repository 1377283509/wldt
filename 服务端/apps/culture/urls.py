from django.urls import path
from .views import GetAllCulture

app_name = "culture"
urlpatterns = [
    path("get_all_culture/", GetAllCulture.as_view(), name="get_all_culture"),
]
