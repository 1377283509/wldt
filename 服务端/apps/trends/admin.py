from django.contrib import admin
from .models import Trends, TrendsImage, TrendsComment, TrendsCommentImage


class TrendsImageAdmin(admin.StackedInline):
    model = TrendsImage


@admin.register(Trends)
class TrendsAdmin(admin.ModelAdmin):
    inlines = [TrendsImageAdmin]


class TrendsCommentImageAdmin(admin.StackedInline):
    model = TrendsCommentImage


@admin.register(TrendsComment)
class TrendsCommentAdmin(admin.ModelAdmin):
    inlines = [TrendsCommentImageAdmin]
