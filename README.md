# cookiecutter-django-nginx-docker

# First Steps
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

## First Time
### production .env

Inside .env.prod:
1. create a new SECRET_KEY
2. -- change postgress password--

### if using remote

inside docker-compose.prod.yaml
3. remove intro message and remove the "exit 1"
4. (change remote ip if needed)

### django static
5. collect static 
```
cd django
python manage.py collectstatic --no-input --clear
cd ../
```


## Docker Compose

```
./build.sh
open http://0.0.0.0/
```

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
