mkdir -p /docker/guacamole/init
docker run --rm guacamole/guacamole /opt/guacamole/bin/initdb.sh --postgresql > /docker/guacamole/init/initdb.sql