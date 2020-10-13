from django.db import models
from user.models import User
from travel_tag.models import Tag


class BaseTrendsModel(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name="发布者", null=False)
    content = models.TextField(null=True, verbose_name="内容")
    tag = models.ManyToManyField(Tag, verbose_name="标签")
    likeCounts = models.IntegerField(default=0, verbose_name="点赞数")
    pubDate = models.DateField(auto_now=True, verbose_name="发布时间")

    class Meta:
        abstract = True
