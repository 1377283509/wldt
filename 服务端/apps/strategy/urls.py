from django.urls import path
from .views import GetAllStrategy, GetStrategyDetails

app_name = "strategy"
urlpatterns = [
    path("get_all_strategy/",GetAllStrategy.as_view(), name="get_all_strategy"),
    path("get_strategy_by_id/",GetStrategyDetails.as_view(), name="get_strategy_by_id")
]
