#!/bin/bash
# NAME="djangoserver"
# SOCKFILE=/home/gunicorn.sock
# gunicorn --daemon --bind :8000 --workers 3 django_redis.wsgi:application &&
sudo supervisord -n && service nginx start
