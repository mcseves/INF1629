from django.http import HttpResponse
from django.shortcuts import render

context = {}

def index(request):
    return render(request, 'werpapers_manager/index.html', context)
def papers_by_conference(request, conference):
    context["conference"] = conference
    return render(request, 'werpapers_manager/papers_by_conference.html', context)
