echo "
Firs time running this:

If you are using a remote host then change the REMOTE_HOST
remove the line 'exit 1'
"
REMOTE_HOST=''
#REMOTE_HOST="-H ssh://username@1.1.1.1"
exit 1

docker-compose $REMOTE_HOST -f docker-compose.prod.yaml down -v
docker-compose $REMOTE_HOST -f docker-compose.prod.yaml build
docker-compose $REMOTE_HOST -f docker-compose.prod.yaml up -d

echo "
Remeber to build the frontend before running build, and collect static on django if needed

local commands: 
docker-compose -f docker-compose.prod.yaml logs
docker-compose -f docker-compose.prod.yaml ps -a 
docker-compose -f docker-compose.prod.yaml exec django python manage.py migrate
exec django python manage.py collectstatic --no-input --clear

remote commands:
docker-compose -H "ssh://username@ip" -f docker-compose.prod.yaml

Inside the remote host:
docker ps
docker exec -u 0 -it <django_id> bash
docker exec -it <nginx_id> sh

"
