from django.db import models

# Create your models here.

GenreList = [
    ('Action', 'Action'),
    ('Comedy', 'Comedy'),
    ('Romance', 'Romance'),
    ('Horror', 'Horror'),
    ('Musical', 'Musical'),
    ('Anime', 'Anime'),
]

class Movies(models.Model):
    video = models.FileField(upload_to='projects/', null=True, blank=True)
    MovieID = models.PositiveIntegerField() 
    MovieTitle = models.CharField(max_length=50)
    Actor1Name = models.CharField(max_length=25)
    Actor2Name = models.CharField(max_length=25)
    DirectorName = models.CharField(max_length=50)
    MovieGenre = models.CharField(choices=GenreList)
    ReleaseYear = models.PositiveIntegerField()

    def __str__(self):
        return f"{self.MovieTitle} - {self.MovieID} - {self.ReleaseYear} - {self.MovieGenre} - {self.Actor1Name} - {self.Actor2Name} - {self.DirectorName}"
 