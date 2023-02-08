FROM postgres:14-alpine
COPY ./docker/postgres/init-db.sh /docker-entrypoint-initdb.d/

RUN apk update
RUN apk add postgresql-client
