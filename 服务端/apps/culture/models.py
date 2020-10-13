from django.db import models
from restaurant.models import Restaurant
from tourist_spots.models import TouristAttraction


class CultureType(models.Model):
    name = models.CharField(max_length=64, null=False, verbose_name="类别名")

    class Meta:
        db_table = "tb_culture_type"
        verbose_name = "文化卡片类别"
        verbose_name_plural = "文化卡片类别"

    def __str__(self):
        return self.name


class Culture(models.Model):
    title = models.CharField(max_length=120, null=False, verbose_name="标题")
    image = models.URLField(null=False, verbose_name="配图")
    likeCounts = models.IntegerField(default=0, verbose_name="点赞数")
    url = models.URLField(verbose_name="文章地址")
    type = models.ForeignKey(CultureType,default=None, on_delete=models.SET_DEFAULT, verbose_name="类别")
    recommendedRestaurant = models.ForeignKey(Restaurant,blank=True,null=True, default=None, on_delete=models.SET_DEFAULT, verbose_name="推荐餐厅")
    recommendedTourist = models.ForeignKey(TouristAttraction,blank=True,null=True, default=None, on_delete=models.SET_DEFAULT, verbose_name="推荐景点")
    pubDate = models.DateField(auto_now_add=True, verbose_name="发布时间")

    class Meta:
        db_table = "tb_culture"
        verbose_name_plural = "文化卡片"
        verbose_name = "文化卡片"
        ordering = ["-pubDate"]

    def __str__(self):
        return self.title



