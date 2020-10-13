from django.db import models
from user.models import User
from utils.base_model.base_image_model import BaseImageModel


# 求助信息
class HelpInfo(models.Model):
    statusChoice = ((0, "已解决"), (1, "未解决"))
    user = models.ForeignKey(User, verbose_name="发布者", null=False, on_delete=models.CASCADE)
    content = models.TextField(null=False, verbose_name="求助内容")
    status = models.BooleanField(choices=statusChoice, null=False, default=1, verbose_name="状态")
    commentCount = models.IntegerField(default=0, verbose_name="评论数")
    pubDate = models.DateField(auto_now_add=True, verbose_name="发布时间")
    tag = models.CharField(max_length=36, null=True, verbose_name="关键词")

    class Meta:
        ordering = ["-pubDate", "tag"]
        db_table = "tb_seek_help"
        verbose_name = "求助信息"
        verbose_name_plural = "求助信息"

    def __str__(self):
        return "{}   {}".format(self.user, self.pubDate)


# 求助配图
class HelpInfoImage(BaseImageModel):
    help = models.ForeignKey(HelpInfo, null=False, on_delete=models.CASCADE, verbose_name="求助信息")

    class Meta:
        ordering = ["id"]
        db_table = "tb_seek_help_image"
        verbose_name_plural = "求助信息配图"
        verbose_name = "求助信息配图"

    def __str__(self):
        return self.url


# 求助评论
class HelpComment(models.Model):
    helpInfo = models.ForeignKey(HelpInfo, null=True, on_delete=models.CASCADE, verbose_name="求助信息")
    content = models.CharField(max_length=120, null=False, verbose_name="评论内容")
    date = models.DateField(auto_now_add=True, verbose_name="评论时间")
    likeCounts = models.IntegerField(default=0, verbose_name="点赞数")
    user = models.ForeignKey(User,on_delete=models.CASCADE, verbose_name="用户")


    class Meta:
        db_table = "tb_help_comment"
        verbose_name = "求助评论"
        verbose_name_plural = "求助评论"
        ordering = ["-date"]

    def __str__(self):
        return self.content


# 评论配图
class HelpCommnetImage(BaseImageModel):
    helpComment = models.ForeignKey(HelpComment, null=False, verbose_name="评论", on_delete=models.CASCADE)

    class Meta:
        db_table = "tb_help_comment_image"
        verbose_name_plural = "求助评论配图"
        verbose_name = "求助评论配图"

    def __str__(self):
        return self.url
