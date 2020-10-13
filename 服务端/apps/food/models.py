from django.db import models
from restaurant.models import Restaurant


# 美食模型
class Food(models.Model):
    name = models.CharField(max_length=36,null=False,unique=True,verbose_name="美食名")
    description = models.TextField(verbose_name="美食简介")
    story = models.TextField(verbose_name="美食故事")
    feature = models.TextField(verbose_name="美食特点")
    practice = models.TextField(verbose_name="美食做法")
    value = models.TextField(verbose_name="营养价值")
    tag = models.CharField(max_length=36,verbose_name="美食标签")
    likeCounts = models.IntegerField(verbose_name="喜欢人数")
    recommendedRestaurant = models.ManyToManyField(Restaurant,verbose_name="推荐餐厅")

    class Meta:
        verbose_name = "美食"
        verbose_name_plural = "美食"
        ordering = ["id"]
        db_table = "food"

    def __str__(self):
        return "{}".format(self.name)


# 美食图片模型
class FoodImage(models.Model):
    url = models.URLField(null=False,verbose_name="图片地址")
    food = models.ForeignKey(Food,"所属美食")

    def __str__(self):
        return "{}的配图".format(self.food.name)

    class Meta:
        verbose_name_plural="美食配图"
        verbose_name = "美食配图"
        db_table = "food_imgs"
        ordering = ["id"]


