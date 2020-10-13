from django.contrib import admin
from .models import Diary


@admin.register(Diary)
class BannerAdmin(admin.ModelAdmin):
    list_per_page = 10
    list_display = ["date", "content", "image", "user"]
    list_filter = ["date"]

