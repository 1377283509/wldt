from django.contrib import admin
from .models import Culture, CultureType


@admin.register(Culture)
class CultureAdmin(admin.ModelAdmin):
    list_per_page = 20


@admin.register(CultureType)
class CultureTypeAdmin(admin.ModelAdmin):
    list_per_page = 20

