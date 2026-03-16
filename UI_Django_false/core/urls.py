from django.urls import path
from . import views

urlpatterns = [
    # Home
    path('', views.home, name='home'),

    # Genereer
    path('genereer/', views.genereer, name='genereer'),
    path('genereer/start/', views.genereer_recept, name='genereer_start'),

    # Recepten
    path('recepten/', views.recepten_lijst, name='recepten'),
    path('recepten/<int:pk>/', views.recept_detail, name='recept_detail'),
    path('recepten/<int:pk>/verwijder/', views.recept_verwijder, name='recept_verwijder'),

    # Allergenen
    path('allergenen/', views.allergenen_lijst, name='allergenen'),
    path('allergenen/toevoegen/', views.allergeen_toevoegen, name='allergeen_toevoegen'),
    path('allergenen/<int:pk>/verwijder/', views.allergeen_verwijder, name='allergeen_verwijder'),

    # Dieetwensen
    path('dieet/', views.dieet_lijst, name='dieet'),
    path('dieet/toevoegen/', views.dieet_toevoegen, name='dieet_toevoegen'),
    path('dieet/<int:pk>/verwijder/', views.dieet_verwijder, name='dieet_verwijder'),

    # Settings
    path('settings/', views.settings_page, name='settings'),
]
