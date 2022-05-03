FROM ubuntu:latest
ENV TURNKEY_HOME /opt/turnkey4
WORKDIR $TURNKEY_HOME
COPY docker_entrypoint.sh /opt/turnkey4

RUN apt-get update && \
  apt-get install -y --no-install-recommends vim wget unzip && \
##
  mkdir -p /tmp/src/turnkey4 && \
  cd /tmp/src/turnkey4 && \
  wget -q --no-check-certificate https://wotho.ethz.ch/tk4-/tk4-_v1.00_current.zip && \
  echo "Hash: $(md5sum /tmp/tk4-_v1.00_current.zip)" >> /tmp/MD5SUMS && \
  echo "$(date)" >> /tmp/MD5SUMS && \
  cat /tmp/MD5SUMS && \
  unzip tk4-_v1.00_current.zip && \
##
  apt-get clean && \
  rm -rf /tmp/src/turnkey4/tk4-_v1.00_current.zip && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["./docker_entrypoint.sh"]
CMD ["./mvs"]
