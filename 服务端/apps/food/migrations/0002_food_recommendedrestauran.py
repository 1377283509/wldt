# Generated by Django 2.1.7 on 2020-02-02 12:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('restaurant', '0002_auto_20200202_1400'),
        ('food', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='food',
            name='recommendedRestauran',
            field=models.ManyToManyField(default=None, to='restaurant.Restaurant', verbose_name='推荐餐厅'),
        ),
    ]
