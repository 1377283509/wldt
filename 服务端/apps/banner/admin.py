from django.contrib import admin
from .models import Banner

@admin.register(Banner)
class BannerAdmin(admin.ModelAdmin):
    list_per_page = 10
    list_display = ["id","title","imgUrl","kind","contentUrl"]
    list_editable = ["title","imgUrl","kind","contentUrl"]
    list_filter = ["kind"]
