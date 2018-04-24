FROM mongo:3.6.4

LABEL br.com.wenit.mongo.version="3.6.4" \
      br.com.wenit.mongo.release-date="2018-04-24" \
      vendor="Wenit"

RUN apt-get update && \
    apt-get install -y --force-yes pwgen && \
    apt-get clean

VOLUME /data/configdb
VOLUME /data/db

ENV AUTH yes
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes

ADD ./config/run.sh /run.sh
ADD ./config/setup.sh /setup.sh

EXPOSE 27017 28017

CMD ["/run.sh"]