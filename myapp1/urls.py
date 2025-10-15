from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('add_movie/', views.add_movie, name='add_movie'),
    path('edit_movie/<int:pk>/', views.edit_movie, name='edit_movie'),
    path('delete_movie/<int:pk>/', views.delete_movie, name='delete_movie'),
]

