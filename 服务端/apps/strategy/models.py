from django.db import models
from utils.base_model.base_trends_model import BaseTrendsModel
from utils.base_model.base_image_model import BaseImageModel


# 游记模型
class Strategy(BaseTrendsModel):
    address = models.CharField(max_length=120, verbose_name="地点")
    title = models.CharField(max_length=64, null=False, verbose_name="标题")

    class Meta:
        db_table = "tb_strategy"
        verbose_name = "攻略"
        verbose_name_plural = "攻略"
        ordering = ["-pubDate"]

    def __str__(self):
        return self.title


# 游记配图
class StrategyImage(BaseImageModel):
    strategy = models.ForeignKey(Strategy, on_delete=models.CASCADE, verbose_name="攻略")

    class Meta:
        db_table = "tb_strategy_image"
        verbose_name = "攻略配图"
        verbose_name_plural = "攻略配图"

    def __str__(self):
        return self.url
