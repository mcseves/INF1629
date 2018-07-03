from django.http import HttpResponse
from django.shortcuts import render
import json
import os

context = {}

def index(request):
    return render(request, 'werpapers_manager/index.html', context)
def papers_by_conference(request, conference):
    path = os.path.join(os.path.dirname(os.path.dirname(__file__)), 'werpapers_manager\\' + conference + '.json')
    with open(path, encoding="utf8") as f:
        data = json.load(f)
    context = data

    return render(request, 'werpapers_manager/papers_by_conference.html', context)
