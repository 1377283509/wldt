from django.contrib import admin
from .models import Restaurant,RestaurantImage,RestaurantComment,RestaurantCommentImage,RestaurantFood,RestaurantTag

@admin.register(Restaurant)
class RestaurantAdmin(admin.ModelAdmin):
    list_per_page = 10
    list_display = ["id", "name", "position", "averageConsumption", "phone", "openDate","commentCount","description"]
    list_editable = ["name", "description", "phone", "position", "openDate","averageConsumption"]
    search_fields = ["name", "score"]
    sortable_by = ["commentCount","name"]


@admin.register(RestaurantImage)
class RestaurantImageAdmin(admin.ModelAdmin):
    list_per_page = 10
    list_display = ["id","restaurant","url"]
    list_editable = ["url","restaurant"]
    search_fields = ["restaurant"]
    list_filter = ["restaurant"]
    sortable_by = ["restaurant"]


@admin.register(RestaurantComment)
class RestaurantCommentAdmin(admin.ModelAdmin):
    list_per_page = 10
    list_display = ["id", "restaurant", "content","manner","isQuality","stars","public_time"]
    list_editable = ["isQuality"]
    search_fields = ["restaurant"]
    list_filter = ["restaurant"]
    sortable_by = ["restaurant"]
    
@admin.register(RestaurantCommentImage)
class RestaurantCommentImageAdmin(admin.ModelAdmin):
    list_per_page = 10
    list_display = ["id", "restaurantComment", "url"]
    sortable_by = ["restaurant"]
    

@admin.register(RestaurantTag)
class RestaurantTagAdmin(admin.ModelAdmin):

    list_per_page = 10
    list_display = ["id", "tag", "restaurant"]
    list_editable = ["tag","restaurant"]
    list_filter = ["tag","restaurant"]
    sortable_by = ["restaurant"]

    def restaurant(self,obj):
        return [bj.restaurant for bj in obj.restaurant.all()]

    filter_horizontal = ("restaurant",)


@admin.register(RestaurantFood)
class RestaurantFoodAdmin(admin.ModelAdmin):
    list_per_page = 10
    list_display = ["id", "name", "restaurant"]
    list_editable = ["name", "restaurant"]
    list_filter = ["name", "restaurant"]
    sortable_by = ["name"]


    def restaurant(self, obj):
        return [bj.restaurant for bj in obj.restaurant.all()]

    filter_horizontal = ("restaurant",)