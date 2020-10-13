from django.db import models
from utils.base_model.base_trends_model import BaseTrendsModel
from utils.base_model.base_image_model import BaseImageModel


# 游记模型
class TravelNote(BaseTrendsModel):
    address = models.CharField(max_length=120, verbose_name="地点")
    title = models.CharField(max_length=64, null=False, verbose_name="标题")

    class Meta:
        db_table = "tb_tralve_note"
        verbose_name = "游记"
        verbose_name_plural = "游记"
        ordering = ["-pubDate"]

    def __str__(self):
        return self.title


# 游记配图
class TravelNoteImage(BaseImageModel):
    travel_note = models.ForeignKey(TravelNote, on_delete=models.CASCADE, verbose_name="游记")

    class Meta:
        db_table = "tb_travel_note_image"
        verbose_name = "游记配图"
        verbose_name_plural = "游记配图"

    def __str__(self):
        return self.url
