from django.urls import path
from .views import GetAllHelp,GetHelpDetailsById

app_name = "seek_help"
urlpatterns = [
    path("get_all_help/",GetAllHelp.as_view(),name="get_all_help"),
    path("get_help_by_id/",GetHelpDetailsById.as_view(),name="get_help_by_id")
]