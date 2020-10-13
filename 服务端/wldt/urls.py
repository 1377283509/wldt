from django.contrib import admin
from django.urls import path,include
from django.conf.urls.static import static
from django.conf import settings

urlpatterns = [
    path('admin/', admin.site.urls),
    path('food/', include("food.urls"), name="美食"),
    path("restaurant/", include("restaurant.urls"), name="餐厅"),
    path("user/", include("user.urls"), name="用户"),
    path("tourist_spot/",include("tourist_spots.urls"),name="景点"),
    path("travel_note/",include("travel_note.urls"),name="游记"),
    path("strategy/",include("strategy.urls"),name="攻略"),
    path("image/",include("image.urls"),name="图片"),
    path("diary/", include("diary.urls"), name="小记"),
    path("culture/",include("culture.urls"), name="文化"),
    path("seek_help/",include("seek_help.urls"), name="求助"),
    path("trends/",include("trends.urls"), name="动态"),
]+static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
