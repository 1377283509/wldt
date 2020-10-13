from django.contrib import admin
from .models import CommentCounts
@admin.register(CommentCounts)
class CommentCountsAdmin(admin.ModelAdmin):
    list_display = ["score","commentNumber","positiveCommentNumber","negativeCommentNumber"]
    list_filter = ["score"]
    list_per_page = 10

