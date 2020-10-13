from django.contrib import admin
from .models import Strategy, StrategyImage


class StrategyImageAdmin(admin.StackedInline):
    model = StrategyImage


@admin.register(Strategy)
class TravelNoteAdmin(admin.ModelAdmin):
    inlines = [StrategyImageAdmin]





