from django.db import models


class Tag(models.Model):
    name = models.CharField(unique=True, max_length=36, null=False, verbose_name="标签")

    class Meta:
        db_table = "tb_tag"
        verbose_name = "游记攻略动态标签"
        verbose_name_plural = "游记攻略动态标签"

    def __str__(self):
        return self.name
