from django.forms import ModelForm
from .models import Movies
from django import forms

class AddMovie(ModelForm):
    class Meta:
        model = Movies
        fields = ['video', 'MovieID', 'MovieTitle','Actor1Name','Actor2Name','DirectorName','MovieGenre','ReleaseYear']