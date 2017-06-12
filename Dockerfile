FROM alpine:3.6
MAINTAINER Kitware, Inc. <kitware@kitware.com>

COPY . /opt/ktile
VOLUME /opt/ktile

RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk update && apk cache clean
RUN apk add bash python python-dev py-pip gdal@testing gdal-dev@testing py-gdal@testing

RUN apk add gcc linux-headers make g++ git

# Mapnik
RUN apk add boost-dev \
            zlib zlib-dev \
            freetype freetype-dev \
            harfbuzz harfbuzz-dev \
            jpeg jpeg-dev \
            proj4@testing proj4-dev@testing \
            tiff tiff-dev \
            cairo cairo-dev \
            postgresql postgresql-dev

RUN git clone https://github.com/mapnik/mapnik.git -b v3.0.13 /opt/mapnik && cd /opt/mapnik && git submodule update --init deps/mapbox/variant
RUN cd /opt/mapnik && ./configure && JOBS=16 make && make install

# Python Mapnik
RUN git clone https://github.com/mapnik/python-mapnik.git -b v3.0.13 /opt/python-mapnik
RUN cd /opt/python-mapnik && python setup.py install

# Ktile
RUN apk add geos@testing geos-dev@testing
RUN cd /opt/ktile && pip install -r requirements.txt && pip install .

RUN apk del gcc linux-headers make g++ git && rm -rf /opt/python-mapnik /opt/mapnik
# ENTRYPOINT ['/bin/sh']
