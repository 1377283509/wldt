from django.db import models
from user.models import User
from comment_counts.models import CommentCounts
from open_date_time.models import OpenDate
from utils.base_model.base_comment_model import BaseCommentModel
from utils.base_model.base_image_model import BaseImageModel
from utils.base_model.base_tag_model import BaseTagModel

# 餐厅 -- 模型
class Restaurant(models.Model):

    name = models.CharField(max_length=60,null=False,verbose_name="餐厅名")
    position = models.CharField(max_length=120,null=False,verbose_name="位置")
    averageConsumption = models.IntegerField(null=False,verbose_name="平均消费")
    description = models.TextField(null=True,blank=True,verbose_name="描述")
    phone = models.CharField(max_length=20,verbose_name="联系方式")
    openDate = models.ForeignKey(OpenDate,on_delete=models.PROTECT,verbose_name="营业时间")
    commentCount = models.ForeignKey(CommentCounts,on_delete=models.PROTECT,verbose_name="评论统计")


    class Meta:
        ordering = ["name"]
        db_table = "restaurant"
        verbose_name = "餐厅"
        verbose_name_plural = "餐厅"

    def __str__(self):
        return self.name


# 餐厅配图 -- 模型
class RestaurantImage(BaseImageModel):
    restaurant = models.ForeignKey(Restaurant,on_delete=models.CASCADE,verbose_name="餐厅")

    class Meta:
        db_table = "restaurant_images"
        verbose_name_plural = "餐厅配图"
        verbose_name = "餐厅配图"

    def __str__(self):
        return "{}的配图".format(self.restaurant.name)


# 餐厅评论 -- 模型
class RestaurantComment(BaseCommentModel):
    restaurant = models.ForeignKey(Restaurant,null=False,on_delete=models.CASCADE,verbose_name="餐厅")

    class Meta:
        db_table = "restaurant_comment"
        verbose_name_plural = "餐厅评论"
        verbose_name = "餐厅评论"

    def __str__(self):
        return "{}-{}".format(self.restaurant,self.user)


# 餐厅评论配图 -- 模型
class RestaurantCommentImage(BaseImageModel):
    restaurantComment = models.ForeignKey(RestaurantComment,on_delete=models.CASCADE,verbose_name="餐厅评论")

    class Meta:
        ordering=["restaurantComment"]
        db_table = "restaurant_comment_image"
        verbose_name = "餐厅评论配图"
        verbose_name_plural="餐厅评论配图"

    def __str__(self):
        return "{}的配图".format(self.restaurantComment)

# 餐厅标签
class RestaurantTag(BaseTagModel):

    restaurant = models.ManyToManyField(Restaurant,verbose_name="餐厅")

    class Meta:
        ordering=["tag"]
        db_table = "restaurant_tag"
        verbose_name = "餐厅标签"
        verbose_name_plural = "餐厅标签"

    def __str__(self):
        return "{}-{}".format(self.restaurant,self.tag)


# 餐厅菜系
class RestaurantFood(models.Model):

    name = models.CharField(max_length=60,null=False,blank=False,verbose_name="菜名")
    restaurant = models.ManyToManyField(Restaurant,verbose_name="餐厅")

    class Meta:
        ordering = ["name"]
        db_table = "restaurant_food"
        verbose_name = "餐厅菜系"
        verbose_name_plural = "餐厅菜系"

    def __str__(self):
        return "{}-{}".format(self.name,self.restaurant)
















