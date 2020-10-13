from django.contrib import admin
from .models import User

@admin.register(User)
class UserAdmin(admin.ModelAdmin):
    list_per_page = 10
    list_display = ["id","name","gender","phone","createTime","status"]
    list_editable = ["status"]
    sortable_by = ["createTime"]
