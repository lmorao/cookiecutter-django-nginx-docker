# pull official base image
FROM python:3.9.7-slim-buster as builder
ENV DJANGODIR=./django/

WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies alpine
#RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev
# install psycopg2 dependencies slim-buster
RUN apt-get update && apt-get -y install gcc postgresql && apt-get clean && apt-get -y install netcat

# install dependencies
RUN pip install --upgrade pip
COPY $DJANGODIR/requirements.prod .

RUN pip install -r requirements.prod
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /usr/src/app/wheels -r requirements.prod


#########
# FINAL #
#########

FROM python:3.9.7-slim-buster

# create directory for the app user
RUN mkdir -p /home/app

# create the app user
#RUN addgroup -S app && adduser -S app -G app
RUN groupadd -g 1010 app && useradd -u 2010 -g app -s /bin/sh app

# create the appropriate directories
ENV HOME=/home/app
ENV APP_HOME=/home/app/django
ENV DJANGODIR=./django/
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

#RUN apt-get update && apt-get install libpq && apt-get -y install netcat
RUN apt-get update && apt-get -y install netcat
COPY --from=builder /usr/src/app/wheels /wheels
COPY --from=builder /usr/src/app/requirements.prod .
RUN pip install --no-cache /wheels/*

# copy project
COPY $DJANGODIR $APP_HOME

# chown all the files to the app user
RUN chown -R app:app $APP_HOME

# change to the app user
USER app

# Wait for Postgres database
#RUN sed -i 's/\r$//g'  $APP_HOME/entrypoint.prod.sh
#RUN chmod +x  $APP_HOME/entrypoint.prod.sh
#ENTRYPOINT ["/home/app/django/entrypoint.prod.sh"]

# create the appropriate directories
ENV HOME=/home/app
ENV APP_HOME=/home/app/django

# Create log files. They cant be read with user app, need to root into container to read them
USER root
RUN touch /var/log/django.log
RUN chmod 703 /var/log/django.log
RUN mkdir -p /var/log/gunicorn/
RUN touch /var/log/gunicorn/access.log
RUN touch /var/log/gunicorn/error.log
RUN chmod 703 /var/log/gunicorn
RUN chmod 703 /var/log/gunicorn/access.log
RUN chmod 703 /var/log/gunicorn/error.log

USER app
WORKDIR $APP_HOME
