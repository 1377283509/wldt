# Generated by Django 2.1.7 on 2020-05-13 01:30

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('user', '0003_auto_20200206_1948'),
    ]

    operations = [
        migrations.CreateModel(
            name='Diary',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('content', models.TextField(verbose_name='内容')),
                ('likeCount', models.IntegerField(default=0, verbose_name='喜欢数量')),
                ('image', models.URLField(verbose_name='配图')),
                ('date', models.DateField(auto_now_add=True, verbose_name='日期')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='user.User', verbose_name='发布者')),
            ],
            options={
                'verbose_name': '每日小记',
                'db_table': 'tb_diary',
                'ordering': ['-date'],
            },
        ),
    ]
