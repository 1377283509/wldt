from django.db import models

class OpenDate(models.Model):
    open_date = models.TextField(null=True,blank=True,verbose_name="开放日期")
    open_time = models.TextField(null=True,blank=True,verbose_name="开放时间")

    class Meta:
        db_table = "open_date"
        verbose_name_plural = "开放时间"
        verbose_name = "开放日期"

    def __str__(self):
        return "{}-{}".format(self.open_date,self.open_time)
