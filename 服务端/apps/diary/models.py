import os
import uuid
from django.db import models
from user.models import User
import datetime


def user_directory_path(instance,filename):
    date = datetime.datetime.now().strftime("%Y%m%d")
    ext = filename.split('.')[-1]
    filename = '{}.{}'.format(uuid.uuid4().hex[:10], ext)
    return os.path.join(date, filename)


class Diary(models.Model):
    content = models.TextField(verbose_name="内容")
    likeCount = models.IntegerField(default=0, verbose_name="喜欢数量")
    image = models.ImageField(upload_to=user_directory_path, null=False, verbose_name="配图")
    date = models.DateField(auto_now_add=True, verbose_name="日期")
    user = models.ForeignKey(User, null=False, on_delete=models.CASCADE, verbose_name="发布者")

    class Meta:
        ordering = ["-date"]
        verbose_name = "每日小记"
        db_table = "tb_diary"

    def __str__(self):
        return self.date.strftime("%c")
