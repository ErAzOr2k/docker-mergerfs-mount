FROM debian
MAINTAINER ErAzOr2k

ENV OPTIONS="defaults,sync_read,allow_other,category.action=all,category.create=ff"
ENV FILESYSTEMS=

RUN apt-get update \
  && apt-get install -y \
    git \
    make \
    fuse

RUN git clone https://github.com/trapexit/mergerfs.git \
  && cd mergerfs \
  && make install-build-pkgs \
  && make deb \
  && dpkg -i ../mergerfs_*_*.deb \
  && apt-get clean \
  && rm -rf /mergerfs* /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY start.sh /
RUN chmod +x /start.sh

CMD ["/start.sh"]
