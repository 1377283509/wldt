from django.db import models

class CommentCounts(models.Model):
    score = models.DecimalField(max_digits=2, decimal_places=1, default=0.0, verbose_name="评分")
    commentNumber = models.IntegerField(default=0, verbose_name="评论数")
    positiveCommentNumber = models.IntegerField(default=0, verbose_name="好评数")
    negativeCommentNumber = models.IntegerField(default=0, verbose_name="差评数")

    class Meta:
        db_table = "comment_counts"
        verbose_name = "评论统计"
        verbose_name_plural = "评论统计"

    def __str__(self):
        return self.score.__str__()
