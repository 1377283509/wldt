from django.db import models
from utils.base_model.base_trends_model import BaseTrendsModel
from utils.base_model.base_image_model import BaseImageModel
from user.models import User

# 动态模型
class Trends(BaseTrendsModel):

    class Meta:
        verbose_name = "动态"
        verbose_name_plural = "动态"
        db_table = "tb_trends"
        ordering = ["-pubDate"]

    def __str__(self):
        return self.content


# 动态配图
class TrendsImage(BaseImageModel):
    trends = models.ForeignKey(Trends, null=False, on_delete=models.CASCADE, verbose_name="动态配图")

    class Meta:
        verbose_name_plural = "动态配图"
        verbose_name = "动态配图"
        db_table = "tb_trend_image"
        ordering = ["trends"]

    def __str__(self):
        return self.url


# 动态评论
class TrendsComment(models.Model):
    trends = models.ForeignKey(Trends, on_delete=models.CASCADE, null=False, verbose_name="动态")
    content = models.TextField(null=False, verbose_name="评论")
    date = models.DateField(auto_now_add=True, verbose_name="评论时间")
    user = models.ForeignKey(User,on_delete=models.CASCADE, verbose_name="用户")
    likeCounts = models.IntegerField(default=0, verbose_name="点赞数")
    class Meta:
        db_table = "tb_trends_comment"
        verbose_name = "动态评论"
        verbose_name_plural = "动态评论"
        ordering = ["-date"]

    def __str__(self):
        return self.content


# 动态评论配图
class TrendsCommentImage(BaseImageModel):
    comment = models.ForeignKey(TrendsComment, on_delete=models.CASCADE, verbose_name="动态评论")

    class Meta:
        db_table = "tb_trends_comment_image"
        verbose_name_plural = "动态评论配图"
        verbose_name = "动态评论配图"

    def __str__(self):
        return self.url

