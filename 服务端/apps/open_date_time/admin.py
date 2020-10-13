from django.contrib import admin
from .models import OpenDate

@admin.register(OpenDate)
class OpenDate(admin.ModelAdmin):
    list_display = ["open_date","open_time"]
    list_editable = ["open_time"]
    list_filter = ["open_date","open_time"]
    list_per_page = 10
