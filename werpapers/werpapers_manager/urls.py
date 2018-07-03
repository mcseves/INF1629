from django.urls import path

from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('artigos/<slug:conference>/', views.papers_by_conference, name='artigos'),
]
