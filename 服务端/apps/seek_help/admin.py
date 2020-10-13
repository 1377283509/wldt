from django.contrib import admin
from .models import HelpInfo,HelpInfoImage,HelpComment,HelpCommnetImage


class HelpInfoImageAdmin(admin.StackedInline):
    model = HelpInfoImage


@admin.register(HelpInfo)
class HelpInfoAdmin(admin.ModelAdmin):
    list_display = ["id","user","content","pubDate"]
    inlines = [HelpInfoImageAdmin]


class HelpCommentImageAdmin(admin.StackedInline):
    model = HelpCommnetImage


@admin.register(HelpComment)
class HelpCommentAdmin(admin.ModelAdmin):
    inlines = [HelpCommentImageAdmin]
