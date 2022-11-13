from django.shortcuts import redirect, render

from .tasks import send_email

# Create your views here.


def index(request):
    return render(request, 'celeryapp/index.html')


def about(request):
    if request.method == 'POST':
        email = request.POST['email']
        send_email.delay(email)
        return redirect('index')
    return render(request, 'celeryapp/about.html')
