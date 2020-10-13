from django.db import models

# 轮播图
class Banner(models.Model):
    title = models.CharField(max_length=60,null=False,verbose_name="标题")
    imgUrl = models.URLField(blank=False,null=False,verbose_name="封面图片地址")
    kind = models.BooleanField(choices=((0,"引用文章"),(1,"跳转外部应用")),verbose_name="类型")
    contentUrl = models.URLField(blank=False,null=False,verbose_name="内容地址")

    class Meta:
        db_table = "bannner"
        verbose_name_plural = "轮播图"
        verbose_name = "轮播图"

    def __str__(self):
        return self.title


