# cookiecutter-django-nginx-docker

## Requirements

This assumes you have:
* docker-compose 
* pyenv to have python pointing to some python 3 version

#  Local development

Copy paste the following:
```
python -V
# 3.6.8
python -m venv django_env
mv django_env env
source env/bin/activate
cd django
pip install -r requirements.dev
python manage.py migrate
python manage.py runserver
```
# Production

## Preparation

1. create a new SECRET_KEY

       vim .env.prod
2. change postgress password 

       vim .env.prod.db
3. Create a permanent docker volume for postgres

       docker volume create --name=postgres_proj_changeme
4. If you change the volume name in 3., change the docker-compose.prod.yaml to match, there are two places to change

       vim docker-compose.prod.yaml
5. remove intro message and remove the "exit 1"

       vim build.sh
6. (change remote ip if needed)

       vim build.s
7. django collect static:

       cd django
       python manage.py collectstatic --no-input --clear
       cd ../

---
## Spinning the docker cointainers

1. First time, add db mount so it is not part of the cointainer. Run on the target host:

       docker volume create --name=postgres_proj_changeme

2. To build and up, run build.sh that will run docker-compose

       ./build.sh
       open http://0.0.0.0/admin

---

# For Later - Authentication

Authentication support is enabled
On the app need something of the like to login

```
### Signup
const formData = {
  username: this.email,
  email: this.email,
  password: this.password
}
axios
  .post('/api/v1/users/', formData)
  .then(response => {

### Login
const formData = {
  username: this.username,
  password: this.password
}
await axios
  .post('/api/v1/token/login/', formData)
  .then(response => {
    const token = response.data.auth_token
    axios.defaults.headers.common.Authorization = 'Token ' + token
    this.$store.commit('setToken', token)
```
