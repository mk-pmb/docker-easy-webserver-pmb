# -*- coding: utf-8, tab-width: 2 -*-
FROM python:3
ENV DEW_LIBDIR=/usr/lib/docker-easy-webserver-pmb

COPY build $DEW_LIBDIR/build
RUN exec $DEW_LIBDIR/build/apt.basics.sh
RUN exec $DEW_LIBDIR/build/apt.regular.sh

COPY tmp.dependemcies $DEW_LIBDIR/tmp.dependemcies

COPY src $DEW_LIBDIR/build
RUN exec $DEW_LIBDIR/build/setup.inside.sh

EXPOSE 80
WORKDIR /app
CMD ["$DEW_LIBDIR/src/entrypoint.sh"]
