from django.contrib import admin
from .models import TouristAttraction,TouristSpot,TouristAttractionComment,TouristAttractionCommentImage,TouristAttractionImage,TouristAttractionTag,TouristSpotImage,TouristSpotTag,ServiceFacilities


# 服务设施
class ServiceFacilitiesAdmin(admin.StackedInline):
    model = ServiceFacilities


# 景区配图
class TouristAttractionImageAdmin(admin.StackedInline):
    model = TouristAttractionImage


# 景点配图
class TouristSpotImageAdmin(admin.StackedInline):
    model = TouristSpotImage


# 景区评论配图
class TouristAttractionCommentImageAdmin(admin.StackedInline):
    model = TouristAttractionCommentImage


# 景点标签
class TouristSpotTagAdmin(admin.StackedInline):
    model = TouristSpotTag


# 景区标签
class TouristAttractionTagAdmin(admin.StackedInline):
    model = TouristAttractionTag

# 景区
@admin.register(TouristAttraction)
class TouristAttractionAdmin(admin.ModelAdmin):
    inlines = [TouristAttractionTagAdmin, TouristAttractionImageAdmin]


# 景区评论
@admin.register(TouristAttractionComment)
class TouristAttractionAdmin(admin.ModelAdmin):
    inlines = [TouristAttractionCommentImageAdmin]

# 景点
@admin.register(TouristSpot)
class TouristSpotAdmin(admin.ModelAdmin):
    inlines = [TouristSpotImageAdmin, TouristSpotTagAdmin]
