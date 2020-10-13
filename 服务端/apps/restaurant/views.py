from django.views import View
from .models import Restaurant,RestaurantFood,RestaurantTag,RestaurantCommentImage,RestaurantComment,RestaurantImage
from utils.json_response.json_func import to_json_data,Code,error_map

# 获取所有餐厅
class GetAllRestaurants(View):
    def get(self,request):
        restaurant_list = []
        restaurants = Restaurant.objects.all()
        for r in restaurants:
            tag = r.restauranttag_set.first()
            if not tag:
                tag = None
            else:
                tag = tag.tag
            restaurant_list.append(
                {
                    "id":r.id,
                    "name":r.name,
                    "score": r.commentCount.score,
                    "commentNumber": r.commentCount.commentNumber,
                    "tag": tag,
                    "imgUrl": r.restaurantimage_set.first().url,
                    "position": r.position,
                    "averageConsumption": r.averageConsumption
                }
            )
        return to_json_data(errno=Code.OK,errmsg=error_map[Code.OK],data=restaurant_list)


# 获取餐厅详情
class GetRestaurantDetails(View):
    def get(self,request):
        try:
            id = request.GET["id"]
            restaurant = Restaurant.objects.get(id=id)
            # 评论
            restaurant_comments = RestaurantComment.objects.filter(restaurant=restaurant)
            if len(restaurant_comments) > 2:
                restaurant_comments = restaurant_comments[0:2]
            comment_list = []
            for c in restaurant_comments:
                imgs = []
                for i in RestaurantCommentImage.objects.filter(restaurantComment=c):
                    imgs.append(i.url)
                comment_list.append({
                    "id": c.id,
                    "content": c.content,
                    "user_id": c.user.id,
                    "user_name": c.user.name,
                    "user_img": c.user.imgUrl,
                    "images": imgs,
                    "stars": c.stars,
                    "isGood": c.manner,
                    "isQuality": c.isQuality,
                    "publicTime": c.public_time.strftime("%Y.%m.%d")
                })

            # 标签
            tag_list = []
            restaurant_tags = RestaurantTag.objects.filter(restaurant=restaurant)
            for t in restaurant_tags:
                tag_list.append(t.tag)

            # 配图
            img_list = []
            images = RestaurantImage.objects.filter(restaurant=restaurant)
            for i in images:
                img_list.append(i.url)

            # 菜品
            food_list = []
            restaurant_foods = RestaurantFood.objects.filter(restaurant=restaurant)
            for f in restaurant_foods:
                food_list.append(f.name)

            data = {
                "restaurant": {
                    "id": restaurant.id,
                    "name": restaurant.name,
                    "position": restaurant.position,
                    "averageConsumption": restaurant.averageConsumption,
                    "description": restaurant.description,
                    "phone": restaurant.phone,
                    "openDate": restaurant.openDate.open_date,
                    "openTime": restaurant.openDate.open_time,
                    "score": restaurant.commentCount.score,
                    "isCollect": True,
                    "commentNumber": restaurant.commentCount.commentNumber,
                    "positiveCommentNumber": restaurant.commentCount.positiveCommentNumber,
                    "negativeCommentNumber": restaurant.commentCount.negativeCommentNumber
                },
                "comments": comment_list,
                "images": img_list,
                "tags": tag_list,
                "foods": food_list
            }
            return to_json_data(errno=Code.OK, errmsg=error_map[Code.OK], data=data)
        except Exception as e:
            pass