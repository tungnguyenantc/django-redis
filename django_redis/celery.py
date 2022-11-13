import os


from celery import Celery

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'django_redis.settings')

app = Celery('django_redis')


app.config_from_object('django.conf:settings', namespace='CELERY')

# Load task modules from all registered Django apps.
app.autodiscover_tasks()