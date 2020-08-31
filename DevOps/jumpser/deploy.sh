if [ ! "$SECRET_KEY" ]; then
  SECRET_KEY=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 50`;
  echo "SECRET_KEY=$SECRET_KEY" >> ~/.bashrc;
  echo $SECRET_KEY;
else
  echo $SECRET_KEY;
fi  
if [ ! "$BOOTSTRAP_TOKEN" ]; then
  BOOTSTRAP_TOKEN=`cat /dev/urandom | tr -dc A-Za-z0-9 | head -c 16`;
  echo "BOOTSTRAP_TOKEN=$BOOTSTRAP_TOKEN" >> ~/.bashrc;
  echo $BOOTSTRAP_TOKEN;
else
  echo $BOOTSTRAP_TOKEN;
fi


SECRET_KEY='bnHXlBjmjzVW5i64Y4v21TOzszSZHNEIbAynTh6cWJTnNQvqTV'

BOOTSTRAP_TOKEN='V0y4ymfe9V1IVnYF'



docker run --name jms_all -d \
  -p 81:80 -p 2222:2222 \
  -e SECRET_KEY=$SECRET_KEY \
  -e BOOTSTRAP_TOKEN=$BOOTSTRAP_TOKEN \
  -v /opt/jumpserver/data:/opt/jumpserver/data \
  -v /opt/jumpserver/mysql:/var/lib/mysql \
  --privileged=true \
  jumpserver/jms_all:v2.2.1


docker run --name jms_all_rd -d \
  -v /opt/jumpserver/data:/opt/jumpserver/data \
  -p 81:80 \
  -p 2222:2222 \
  -e SECRET_KEY=$SECRET_KEY \
  -e BOOTSTRAP_TOKEN=$BOOTSTRAP_TOKEN \
  -e DB_HOST=139.9.179.15 \
  -e DB_PORT=3306 \
  -e DB_USER=jumpserver \
  -e DB_PASSWORD=szSZHNEIbAynTh6c \
  -e DB_NAME=jumpserver \
  --privileged=true \
  jumpserver/jms_all:v2.2.1


  szSZHNEIbAynTh6c