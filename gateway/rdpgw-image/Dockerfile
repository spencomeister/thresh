FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
     ca-certificates \
     build-essential \
     cmake \
     git \
     pkg-config \
    libavcodec-dev \
    libavformat-dev \
    libavutil-dev \
    libswscale-dev \
     libssl-dev \
     libkrb5-dev \
     libpam0g-dev \
     libx11-dev \
     libxext-dev \
     libxinerama-dev \
     libxrandr-dev \
     libxcursor-dev \
     libxv-dev \
     libpulse-dev \
     libxkbfile-dev \
     libxdamage-dev \
     libxml2-dev \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN git clone --depth 1 https://github.com/FreeRDP/FreeRDP.git \
  && cmake -S FreeRDP -B FreeRDP/build \
     -DWITH_SERVER=ON \
     -DWITH_RDPGATEWAY=ON \
     -DWITH_SERVER_INTERFACE=ON \
      -DWITH_FFMPEG=OFF \
      -DWITH_CUPS=OFF \
     -DWITH_MANPAGES=OFF \
  && cmake --build FreeRDP/build -j"$(nproc)" \
  && cmake --install FreeRDP/build \
  && rm -rf /opt/FreeRDP

RUN useradd -r -u 10001 -g nogroup rdpgw

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER rdpgw

EXPOSE 3391

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
