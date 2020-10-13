from restaurant.models import RestaurantTag
from .models import Food,FoodImage
from django.views import View
from utils.json_response.json_func import to_json_data,Code,error_map


# 获取所有美食
class GetAllFood(View):
    def get(self,request):
        food_list = []
        foods = Food.objects.all()
        for f in foods:
            f_image = FoodImage.objects.values("url").filter(food=f).first()
            food_list.append({
                "id":f.id,
                "name":f.name,
                "description":f.description,
                "image":f_image["url"],
                "restaurant_counts":f.recommendedRestaurant.count()
            })
        return to_json_data(errno=Code.OK,errmsg=error_map[Code.OK],data=food_list)


class GetFoodDetails(View):
    def get(self,request):
        id = request.GET["id"]
        # TODO: 用户 -- 是否喜欢
        food = Food.objects.filter(id=id).first()
        food_images = FoodImage.objects.filter(food=food).all()
        image_list = []
        for i in food_images:
            image_list.append(i.url)
        restaurants = food.recommendedRestaurant.all()
        restaurant_list = []
        for r in restaurants:
            img = r.restaurantimage_set.first()
            tag = RestaurantTag.objects.filter(restaurant=r).first()
            if not tag:
                tag = None
            else:
                tag = tag.tag
            restaurant_list.append({
                "id":r.id,
                "name":r.name,
                "score":r.commentCount.score,
                "commentNumber":r.commentCount.commentNumber,
                "tag":tag,
                "imgUrl":img.url,
                "position":r.position,
                "averageConsumption":r.averageConsumption
            })
        data = {
            "id":food.id,
            "name":food.name,
            "description":food.description,
            "story":food.story,
            "feature":food.feature,
            "practice":food.practice,
            "value":food.value,
            "likeCounts":food.likeCounts,
            "tag":food.tag,
            "imgs":image_list,
            "islike":True,
            "restaurants":restaurant_list,
        }
        return to_json_data(errno=Code.OK,errmsg=error_map[Code.OK],data=data)


