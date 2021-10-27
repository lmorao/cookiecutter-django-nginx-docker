FROM nginx:1.21-alpine
ENV VUE=./vue/
ENV DJANGO=./django/

### Nginx
COPY nginx/nginx.conf /etc/nginx/conf.d
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx/nginx.conf /etc/nginx/conf.d

RUN mkdir /app

### Vue 
#COPY $VUE/dist /usr/share/nginx/html
#COPY $VUE/dist  /app

### Django
RUN mkdir /app/django
COPY $DJANGO/staticfiles/ /app/django/staticfiles

