FROM vectorim/element-web:latest

ARG SERVER_NAME

ENV TZ=UTC
ENV SERVER_NAME=${SERVER_NAME}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY ./docker/element/element-config.json.template /app/element-config.json.template
COPY ./docker/element/element-default.conf /etc/nginx/conf.d/default.conf

RUN envsubst '${SERVER_NAME}' < /app/element-config.json.template > /app/config.json