from django.db import models
from user.models import User


class BaseCommentModel(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, verbose_name="发布者")
    content = models.TextField(null=False, blank=False, verbose_name="评论内容")
    public_time = models.DateTimeField(auto_now=True, verbose_name="评论时间")
    manner = models.BooleanField(choices=((0, "好评"), (1, "差评")), default=0, verbose_name="好评or差评")
    isQuality = models.BooleanField(choices=((0, "是"), (1, "不是")), default=1, verbose_name="是否是优质评论")
    stars = models.DecimalField(max_digits=2, decimal_places=1, default=5.0, blank=True, verbose_name="评分")

    class Meta:
        abstract = True
