from django.contrib import admin
from .models import TravelNote, TravelNoteImage


class TravelNoteImageAdmin(admin.StackedInline):
    model = TravelNoteImage


@admin.register(TravelNote)
class TravelNoteAdmin(admin.ModelAdmin):
    inlines = [TravelNoteImageAdmin]





