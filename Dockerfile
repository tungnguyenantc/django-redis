# Pull base image
FROM python:3.8

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /home/

# Install dependencies

RUN apt-get update -y --no-install-recommends
RUN apt-get upgrade -y
RUN apt-get install -y supervisor
RUN apt install sudo
RUN apt-get install -y nginx


# RUN pip install -U pipenv
# RUN pipenv lock && pipenv --clear && pipenv --rm
COPY requirements.txt /home/
RUN pip install -r requirements.txt
# install project dependencies
# RUN pipenv install --system 

COPY supervisord.conf /etc/supervisor/
# RUN supervisor -c /etc/supervisord.conf
COPY celeryd.conf /etc/supervisor/conf.d/

COPY celerybeat.conf /etc/supervisor/conf.d/
RUN sudo mkdir -p /var/log/supervisord/
RUN sudo mkdir -p /var/log/celery/

RUN sudo chmod -R 755 /var/log/celery

RUN sudo mkdir -p /var/run/
RUN sudo chmod -R 755 /var/run/


# Copy project
COPY . /home/
RUN chmod +x /home/hello_world.sh

# RUN rm /etc/nginx/conf.d/default.conf
# RUN rm /etc/nginx/sites-enabled/default
COPY django.conf /etc/nginx/sites-available/


# CMD ["gunicorn", "--bind", ":8000", "--workers", "3", "django_redis.wsgi:application"]
ENTRYPOINT ["/home/hello_world.sh"]
# CMD [ "sudo",'supervisord','-n' ]