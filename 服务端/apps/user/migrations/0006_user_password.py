# Generated by Django 2.1.7 on 2020-05-15 08:25

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0005_auto_20200515_1441'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='password',
            field=models.CharField(default='11111111', max_length=20, verbose_name='密码'),
        ),
    ]
