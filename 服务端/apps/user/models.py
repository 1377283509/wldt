from django.db import models


class User(models.Model):
    name = models.CharField(max_length=60,null=False,verbose_name="昵称")
    phone = models.CharField(max_length=11,null=False,unique=True,verbose_name="手机号")
    gender = models.BooleanField(choices=((0,"男"),(1,"女")),default=0,verbose_name="性别")
    password = models.CharField(max_length=20,null=False,default="11111111",verbose_name="密码")
    address = models.CharField(max_length=120,null=True,blank=True,verbose_name="地址")
    birth = models.CharField(max_length=12,null=True,blank=True,verbose_name="生日")
    introduce = models.CharField(max_length=160,default="暂无个人介绍",verbose_name="个人说明")
    imgUrl = models.URLField(null=True,default="http://39.96.63.142/images/tianxiadat .png",verbose_name="头像地址")
    createTime = models.DateField(auto_now_add=True,verbose_name="账号创建时间")
    status = models.BooleanField(default=0,null=False,verbose_name="账号是否可用")

    class Meta:
        ordering = ["phone"]
        db_table = "user"
        verbose_name = "用户"
        verbose_name_plural = "用户"

    def __str__(self):
        return self.phone





