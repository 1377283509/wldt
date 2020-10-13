from django.db import models


class BaseImageModel(models.Model):
    url = models.URLField(null=False,verbose_name="图片地址")

    class Meta:
        abstract = True