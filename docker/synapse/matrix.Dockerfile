FROM matrixdotorg/synapse:latest

ARG SERVER_NAME
ARG REPORT_STATS

ENV TZ=UTC
ENV SERVER_NAME=${SERVER_NAME}
ENV REPORT_STATS=${REPORT_STATS}


RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update -y && apt-get install gettext -y

WORKDIR /data

# RUN python3 -m synapse.app.homeserver --server-name=${SERVER_NAME} --report-stats=${REPORT_STATS} --generate-config -c /data/homeserver.yaml

COPY ./homeserver.yaml.template /data/homeserver.yaml.template
RUN envsubst '${SERVER_NAME}' < /data/homeserver.yaml.template > /data/homeserver.yaml

RUN python3 -m synapse.app.homeserver --server-name=${SERVER_NAME} --report-stats=${REPORT_STATS} --generate-missing-configs -c /data/homeserver.yaml

RUN chown -R 991:991 /data

# EXPOSE 8008
