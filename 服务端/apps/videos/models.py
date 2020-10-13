import os
import uuid
from django.db import models


def user_directory_path(instance,filename):
    ext = filename.split('.')[-1]
    filename = '{}.{}'.format(uuid.uuid4().hex[:10], ext)
    return os.path.join("videos", filename)


class Video(models.Model):
    name = models.CharField(max_length=64,unique=True, null=False, verbose_name="视频名")
    file = models.FileField(upload_to=user_directory_path, verbose_name="视频文件")
    date = models.DateField(auto_now_add=True, verbose_name="上传时间")

    class Meta:
        ordering = ["-date"]
        db_table = "tb_video"
        verbose_name_plural = "视频管理"
        verbose_name = "视频管理"

    def __str__(self):
        return self.name