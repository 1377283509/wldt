from django.contrib import admin
from .models import Food,FoodImage

admin.site.site_title = "文旅大同管理后台"
admin.site.site_header = "文旅大同"


@admin.register(Food)
class FoodAdmin(admin.ModelAdmin):
    list_per_page = 10
    list_display = ["id","name","description","story","feature","practice","value","likeCounts","tag","recommendedRestaurant"]
    list_editable = ["name","description","story","feature","practice","value","likeCounts","tag","recommendedRestaurant"]
    list_filter = ["name","tag","likeCounts","recommendedRestaurant"]
    search_fields = ["name","tag"]
    filter_horizontal = ('recommendedRestaurant',)

    def recommendedRestaurant(self,obj):
        return [bj.name for bj in obj.restaurant.all()]



@admin.register(FoodImage)
class FoodImage(admin.ModelAdmin):
    list_per_page = 10
    list_display = ["id", "url","food"]
    list_editable = ["url","food"]
    list_filter = ["food"]
    search_fields = ["food"]