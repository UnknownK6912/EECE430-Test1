from django.shortcuts import render, redirect
from .forms import AddMovie
from .models import Movies

def index(request):
    return render(request, 'index.html')

def add_movie(request):
    if request.method == 'POST':
        form = AddMovie(request.POST, request.FILES)
        if form.is_valid():
            movie_data = form.cleaned_data
            movie = Movies(
                video=movie_data['video'],
                MovieID=movie_data['MovieID'],
                MovieTitle=movie_data['MovieTitle'],
                Actor1Name=movie_data['Actor1Name'],
                Actor2Name=movie_data['Actor2Name'],
                DirectorName=movie_data['DirectorName'],
                MovieGenre=movie_data['MovieGenre'],
                ReleaseYear=movie_data['ReleaseYear']
            )
            movie.save()
            return redirect('add_movie')
    else:
        form = AddMovie()

    M = Movies.objects.all()
    return render(request, 'add_movie.html', {'form': form, 'M': M})

def edit_movie(request, pk):
    movie = Movies.objects.get(pk=pk)
    if request.method == 'POST':
        form = AddMovie(request.POST, request.FILES, instance=movie)
        if form.is_valid():
            form.save()
            return redirect('add_movie')
    else:
        form = AddMovie(instance=movie)
    return render(request, 'edit_movie.html', {'form': form})

def delete_movie(request, pk):
    movie = Movies.objects.get(pk=pk)
    if request.method == 'POST':
        movie.delete()
        return redirect('add_movie')
    return render(request, 'delete_movie.html', {'movie': movie})
