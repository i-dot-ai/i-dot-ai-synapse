FROM python:3.8-buster

ARG SERVER_NAME
ARG REPORT_STATS

ENV TZ=UTC
ENV SERVER_NAME=${SERVER_NAME}
ENV REPORT_STATS=${REPORT_STATS}

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN pip install matrix-synapse
RUN pip install psycopg2


RUN apt-get update -y && apt-get install gettext -y

WORKDIR /data

COPY ./matrix_e2ee_filter.py /usr/local/lib/python3.8/site-packages/matrix_e2ee_filter.py

COPY ./docker/synapse/start.sh /start.sh
RUN chmod +x /start.sh


COPY ./homeserver.yaml.template /data/homeserver.yaml.template
RUN envsubst '${SERVER_NAME}' < /data/homeserver.yaml.template > /data/homeserver.yaml

RUN python3 -m synapse.app.homeserver --server-name=${SERVER_NAME} --report-stats=${REPORT_STATS} --generate-missing-configs -c /data/homeserver.yaml

RUN chown -R 991:991 /data

EXPOSE 8008

CMD ["sh","/start.sh"]
