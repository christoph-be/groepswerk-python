"""
KookKompas Models — managed=False, wijst naar bestaande SQLite tabellen.
"""
from django.db import models
import json


class Allergeen(models.Model):
    naam = models.CharField(max_length=100, unique=True)

    class Meta:
        managed = False
        db_table = 'allergenen'
        ordering = ['naam']
        verbose_name_plural = 'allergenen'

    def __str__(self):
        return self.naam


class Dieetwens(models.Model):
    naam = models.CharField(max_length=100, unique=True)

    class Meta:
        managed = False
        db_table = 'dieetwensen'
        ordering = ['naam']
        verbose_name_plural = 'dieetwensen'

    def __str__(self):
        return self.naam


class Recept(models.Model):
    naam = models.CharField(max_length=200)
    categorie = models.CharField(max_length=50, default='Diner')
    bereidingstijd = models.IntegerField(default=30)
    ingredienten = models.TextField(default='[]')
    bereiding = models.TextField(default='[]')
    personen = models.IntegerField(default=2)
    aangemaakt_op = models.DateTimeField(auto_now_add=True)

    class Meta:
        managed = False
        db_table = 'recepten'
        ordering = ['-aangemaakt_op']
        verbose_name_plural = 'recepten'

    def __str__(self):
        return self.naam

    @property
    def ingredienten_lijst(self):
        try:
            return json.loads(self.ingredienten)
        except (json.JSONDecodeError, TypeError):
            return []

    @property
    def bereiding_lijst(self):
        try:
            return json.loads(self.bereiding)
        except (json.JSONDecodeError, TypeError):
            return []

    @property
    def categorie_emoji(self):
        emojis = {
            'Ontbijt': '🌅', 'Lunch': '☀️', 'Diner': '🌙',
            'Snack': '🍪', 'Dessert': '🍰',
        }
        return emojis.get(self.categorie, '🍽️')

    @property
    def categorie_kleuren(self):
        kleuren = {
            'Ontbijt': {'bg': '#FFFBEB', 'text': '#B45309', 'grad': 'linear-gradient(135deg, #F59E0B, #FBBF24)'},
            'Lunch': {'bg': '#EEFBF3', 'text': '#128C49', 'grad': 'linear-gradient(135deg, #1AAF5D, #34C578)'},
            'Diner': {'bg': '#FFF6EE', 'text': '#CC4E1A', 'grad': 'linear-gradient(135deg, #E8652B, #FF8A3D)'},
            'Snack': {'bg': '#EFF6FF', 'text': '#1D4ED8', 'grad': 'linear-gradient(135deg, #3B82F6, #60A5FA)'},
            'Dessert': {'bg': '#FDF2F8', 'text': '#BE185D', 'grad': 'linear-gradient(135deg, #EC4899, #F472B6)'},
        }
        return kleuren.get(self.categorie, {'bg': '#F5F3EF', 'text': '#6B6B6B', 'grad': 'linear-gradient(135deg, #9CA3AF, #D1D5DB)'})


class Boodschap(models.Model):
    recept = models.ForeignKey(Recept, on_delete=models.CASCADE, db_column='recept_id', null=True)
    item = models.CharField(max_length=200)
    afgevinkt = models.BooleanField(default=False)

    class Meta:
        managed = False
        db_table = 'boodschappen'
        verbose_name_plural = 'boodschappen'

    def __str__(self):
        return self.item
