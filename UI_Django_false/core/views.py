"""
KookKompas Views — MVP: Home, Genereer, Recepten, Allergenen, Dieet, Settings
"""
import json
import time
import random
from django.shortcuts import render, get_object_or_404, redirect
from django.http import JsonResponse, HttpResponse
from django.views.decorators.http import require_POST, require_GET
from .models import Allergeen, Dieetwens, Recept, Boodschap


# ═══════════════════════════════════════════════════════
# HOME
# ═══════════════════════════════════════════════════════

def home(request):
    allergenen = Allergeen.objects.all()
    dieetwensen = Dieetwens.objects.all()
    recepten = Recept.objects.all()[:5]
    return render(request, 'pages/home.html', {
        'allergenen': allergenen,
        'dieetwensen': dieetwensen,
        'recepten': recepten,
        'allergenen_count': allergenen.count(),
        'dieetwensen_count': dieetwensen.count(),
        'active_page': 'home',
    })


# ═══════════════════════════════════════════════════════
# GENEREER
# ═══════════════════════════════════════════════════════

def genereer(request):
    allergenen = Allergeen.objects.all()
    dieetwensen = Dieetwens.objects.all()
    return render(request, 'pages/genereer.html', {
        'allergenen': allergenen,
        'dieetwensen': dieetwensen,
        'active_page': 'genereer',
    })


def genereer_recept(request):
    """AI recept generatie (server-side).
    MVP: genereert een slim random recept. Vervang later door echte Claude API call.
    """
    if request.method != 'POST':
        return redirect('genereer')

    ingredienten_raw = request.POST.get('ingredienten', '')
    categorie = request.POST.get('categorie', 'Diner')
    ingredienten = [i.strip() for i in ingredienten_raw.split(',') if i.strip()]

    if not ingredienten:
        ingredienten = ['pasta', 'tomaat', 'ui']

    # ── MVP: Slim gegenereerd recept (later vervangen door Claude API) ──
    recept_data = _genereer_mock_recept(ingredienten, categorie)

    # Sla op in database
    recept = Recept.objects.create(
        naam=recept_data['naam'],
        categorie=recept_data['categorie'],
        bereidingstijd=recept_data['bereidingstijd'],
        ingredienten=json.dumps(recept_data['ingredienten']),
        bereiding=json.dumps(recept_data['bereiding']),
        personen=recept_data['personen'],
    )

    return render(request, 'pages/genereer_result.html', {
        'recept': recept,
        'active_page': 'genereer',
        'is_new': True,
    })


def _genereer_mock_recept(ingredienten, categorie):
    """Mock AI generatie — maakt een geloofwaardig recept van je ingrediënten."""
    ing_str = ', '.join(ingredienten[:3])

    receptnamen = {
        'Ontbijt': [f'Energie Bowl met {ing_str}', f'Ochtend Wrap met {ing_str}', f'Power Smoothie Bowl'],
        'Lunch': [f'Frisse {ing_str} Salade', f'Wrap met {ing_str}', f'Gevulde Pitabroodjes'],
        'Diner': [f'{ing_str.title()} à la Chef', f'Romige {ing_str.title()} Schotel', f'Mediterrane {ing_str.title()}'],
        'Snack': [f'Mini {ing_str.title()} Hapjes', f'Snack Bites met {ing_str}'],
    }

    naam = random.choice(receptnamen.get(categorie, receptnamen['Diner']))

    base_ingredienten = [f'{i.strip()}' for i in ingredienten]
    extra = ['snufje zout', 'zwarte peper', '1 el olijfolie', 'verse kruiden naar smaak']
    alle_ingredienten = base_ingredienten + random.sample(extra, min(2, len(extra)))

    bereiding = [
        f'Bereid alle ingrediënten voor: was en snijd de {ingredienten[0] if ingredienten else "groenten"}.',
        f'Verhit olijfolie in een pan op middelhoog vuur.',
    ]
    if len(ingredienten) > 1:
        bereiding.append(f'Voeg de {ingredienten[1]} toe en bak 3-4 minuten.')
    bereiding.extend([
        'Breng op smaak met zout, peper en kruiden.',
        'Laat alles nog 5 minuten sudderen op laag vuur.',
        'Serveer op een warm bord. Eet smakelijk! 🍽️',
    ])

    return {
        'naam': naam,
        'categorie': categorie,
        'bereidingstijd': random.choice([15, 20, 25, 30, 35]),
        'ingredienten': alle_ingredienten,
        'bereiding': bereiding,
        'personen': random.choice([1, 2, 2, 4]),
    }


# ═══════════════════════════════════════════════════════
# RECEPTEN
# ═══════════════════════════════════════════════════════

def recepten_lijst(request):
    categorie = request.GET.get('categorie', '')
    zoek = request.GET.get('q', '')

    recepten = Recept.objects.all()
    if categorie:
        recepten = recepten.filter(categorie=categorie)
    if zoek:
        recepten = recepten.filter(naam__icontains=zoek)

    return render(request, 'pages/recepten.html', {
        'recepten': recepten,
        'active_page': 'recepten',
        'huidige_categorie': categorie,
        'zoekterm': zoek,
    })


def recept_detail(request, pk):
    recept = get_object_or_404(Recept, pk=pk)
    return render(request, 'pages/detail.html', {
        'recept': recept,
        'active_page': 'recepten',
    })


@require_POST
def recept_verwijder(request, pk):
    recept = get_object_or_404(Recept, pk=pk)
    recept.delete()
    return redirect('recepten')


# ═══════════════════════════════════════════════════════
# ALLERGENEN
# ═══════════════════════════════════════════════════════

def allergenen_lijst(request):
    allergenen = Allergeen.objects.all()
    return render(request, 'pages/allergenen.html', {
        'allergenen': allergenen,
        'active_page': 'allergenen',
    })


@require_POST
def allergeen_toevoegen(request):
    naam = request.POST.get('naam', '').strip()
    if naam:
        Allergeen.objects.get_or_create(naam=naam)
    return redirect('allergenen')


@require_POST
def allergeen_verwijder(request, pk):
    try:
        Allergeen.objects.filter(pk=pk).delete()
    except Exception:
        pass
    return redirect('allergenen')


# ═══════════════════════════════════════════════════════
# DIEETWENSEN
# ═══════════════════════════════════════════════════════

def dieet_lijst(request):
    dieetwensen = Dieetwens.objects.all()
    return render(request, 'pages/dieet.html', {
        'dieetwensen': dieetwensen,
        'active_page': 'dieet',
    })


@require_POST
def dieet_toevoegen(request):
    naam = request.POST.get('naam', '').strip()
    if naam:
        Dieetwens.objects.get_or_create(naam=naam)
    return redirect('dieet')


@require_POST
def dieet_verwijder(request, pk):
    try:
        Dieetwens.objects.filter(pk=pk).delete()
    except Exception:
        pass
    return redirect('dieet')


# ═══════════════════════════════════════════════════════
# SETTINGS
# ═══════════════════════════════════════════════════════

def settings_page(request):
    return render(request, 'pages/settings.html', {
        'active_page': 'settings',
        'allergenen_count': Allergeen.objects.count(),
        'dieetwensen_count': Dieetwens.objects.count(),
        'recepten_count': Recept.objects.count(),
    })
