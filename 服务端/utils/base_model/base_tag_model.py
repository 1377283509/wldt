from django.db import models

class BaseTagModel(models.Model):
    tag = models.CharField(max_length=36,null=False,blank=False,verbose_name="标签")

    class Meta:
        abstract = True