from django.db import models
from comment_counts.models import CommentCounts
from open_date_time.models import OpenDate
from user.models import User
from utils.base_model.base_comment_model import BaseCommentModel
from utils.base_model.base_image_model import BaseImageModel
from utils.base_model.base_tag_model import BaseTagModel


# 设施服务
class ServiceFacilities(models.Model):
    choice = ((0,"无"),(1,"有"))
    wifi = models.BooleanField(choices=choice,default=0,verbose_name="WIFI")
    parkingLot = models.BooleanField(choices=choice,default=0,verbose_name="停车场")
    luggage = models.BooleanField(choices=choice,default=0,verbose_name="行李寄存")
    guideService = models.BooleanField(choices=choice,default=0,verbose_name="景区讲解")
    wc = models.BooleanField(choices=choice,default=0,verbose_name="卫生间")
    smokingArea = models.BooleanField(choices=choice,default=0,verbose_name="吸烟区")
    restaurant = models.BooleanField(choices=choice,default=0,verbose_name="餐厅")
    atm = models.BooleanField(choices=choice,default=0,verbose_name="ATM取款机")
    hotel = models.BooleanField(choices=choice,default=0,verbose_name="住宿")
    shop = models.BooleanField(choices=choice,default=0,verbose_name="商店")

    class Meta:
        db_table = "tourist_attraction_services"
        verbose_name_plural = "服务设施"

    def __str__(self):
        return "服务设施"


# 景区 -- 模型
class TouristAttraction(models.Model):
    name = models.CharField(max_length=128,null=False,blank=False,verbose_name="景区名")
    position = models.CharField(max_length=120, null=False, verbose_name="位置")
    averageConsumption = models.IntegerField(null=False, verbose_name="平均消费")
    description = models.TextField(null=True,blank=True,verbose_name="景区描述")
    openDate = models.ForeignKey(OpenDate,on_delete=models.PROTECT,verbose_name="开放时间")
    ticketInfo = models.TextField(verbose_name="门票信息")
    useTime = models.TextField(null=True,blank=True,verbose_name="用时参考")
    busInfo = models.TextField(null=True,blank=True,verbose_name="交通信息")
    bestTimes = models.TextField(null=True,blank=True,verbose_name="旅游时节")
    tips = models.TextField(null=True,blank=True,verbose_name="游玩贴士")
    commentCount = models.ForeignKey(CommentCounts, on_delete=models.PROTECT, verbose_name="评论统计")
    # services = models.OneToOneField(ServiceFacilities,on_delete=models.CASCADE,default=None,verbose_name="服务设施")

    class Meta:
        db_table = "tourist_attraction"
        verbose_name = "景区信息"
        verbose_name_plural = "景区信息"

    def __str__(self):
        return self.name


# 景区配图
class TouristAttractionImage(BaseImageModel):
    touristAttraction = models.ForeignKey(TouristAttraction,on_delete=models.CASCADE,verbose_name="景区")

    class Meta:
        db_table = "tourist_attraction_image"
        verbose_name_plural = "景区配图"
        verbose_name = "景区配图"

    def __str__(self):
        return "{}的配图".format(self.touristAttraction)


# 景点 -- 模型
class TouristSpot(models.Model):
    name = models.CharField(max_length=60,null=False,blank=False,verbose_name="景点名")
    position = models.TextField(null=False, blank=False, verbose_name="位置")
    openDate = models.ForeignKey(OpenDate, on_delete=models.PROTECT, verbose_name="开放时间")
    history = models.TextField(null=True,blank=True,verbose_name="建造历史")
    feature = models.TextField(null=True,blank=True,verbose_name="景点特色")
    artistCharm = models.TextField(null=True,blank=True,verbose_name="艺术魅力")
    description = models.TextField(null=True,blank=True,verbose_name="景点描述")
    touristAttraction = models.ForeignKey(TouristAttraction,on_delete=models.CASCADE,verbose_name="所属景区")

    class Meta:
        verbose_name = "景点信息"
        verbose_name_plural = "景点信息"
        db_table = "tourist_spot"

    def __str__(self):
        return "{}-{}".format(self.touristAttraction,self.name)


# 景点配图
class TouristSpotImage(BaseImageModel):
    touristSpot = models.ForeignKey(TouristSpot,on_delete=models.CASCADE,verbose_name="景点")

    def __str__(self):
        return "{}的配图".format(self.touristSpot)

    class Meta:
        db_table = "tourist_spot_image"
        verbose_name = "景点配图"
        verbose_name_plural = "景点配图"


#  景区评论
class TouristAttractionComment(BaseCommentModel):
    touristAttraction = models.ForeignKey(TouristAttraction, null=False, on_delete=models.CASCADE, verbose_name="景区")

    class Meta:
        db_table = "tourist_attraction_comment"
        verbose_name = "景区评论"
        verbose_name_plural = "景区评论"

    def __str__(self):
        return "{}-{}".format(self.touristAttraction,self.user)


# 景区评论配图
class TouristAttractionCommentImage(BaseImageModel):
    touristAttractionComment = models.ForeignKey(TouristAttractionComment, null=False, on_delete=models.CASCADE, verbose_name="景区评论")

    class Meta:
        db_table = "tourist_attraction_comment_image"
        verbose_name_plural = "景区评论配图"
        verbose_name = "景区评论配图"

    def __str__(self):
        return "{}的配图".format(self.touristAttractionComment)


#  景点标签
class TouristSpotTag(BaseTagModel):
    touristSpot = models.ForeignKey(TouristSpot,on_delete=models.CASCADE,verbose_name="景点")

    class Meta:
        db_table = "tourist_spot_tag"
        verbose_name = "景点标签"
        verbose_name_plural = "景点标签"

    def __str__(self):
        return "{}-{}".format(self.touristSpot,self.tag)


#  景区标签
class TouristAttractionTag(BaseTagModel):
    touristAttraction = models.ForeignKey(TouristAttraction, on_delete=models.CASCADE, verbose_name="景区")

    class Meta:
        db_table = "tourist_attraction_tag"
        verbose_name = "景区标签"
        verbose_name_plural = "景区标签"

    def __str__(self):
        return "{}-{}".format(self.touristAttraction, self.tag)
