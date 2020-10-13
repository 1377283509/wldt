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


class Image(models.Model):
    image = models.ImageField(upload_to=user_directory_path, null=False, verbose_name="配图")

    class Meta:
        db_table = "tb_images"
        verbose_name = "图片管理"
        verbose_name_plural = "图片管理"