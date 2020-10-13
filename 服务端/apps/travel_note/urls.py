from django.urls import path
from .views import GetAllTravelNotes,GetTravelNoteDetails

app_name = "travel_note"
urlpatterns = [
    path("get_all_travel_notes/",GetAllTravelNotes.as_view(), name="get_all_travel_notes"),
    path("get_travel_note_by_id/",GetTravelNoteDetails.as_view(), name="get_travel_note_by_id")
]
