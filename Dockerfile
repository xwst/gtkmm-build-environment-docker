FROM debian:stable-slim AS build_base
RUN apt-get update && \
    apt-get -y --no-install-recommends install \
            cmake g++ pkg-config
ENV PREFIX=/opt/gtk
ENV PKG_CONFIG_PATH=/opt/gtk/lib/pkgconfig/


FROM build_base AS setup_base
WORKDIR /opt
RUN apt-get -y --no-install-recommends install \
            ca-certificates \
            wget \
            meson \
            ninja-build \
            git \
            python3-setuptools \
            xz-utils \
            libpcre3-dev \
            libffi-dev \
            libharfbuzz-dev \
            libcairo2-dev \
            libgirepository1.0-dev \
            libfontconfig-dev \
            libgdk-pixbuf-2.0-dev \
            libgraphene-1.0-dev \
            libepoxy-dev \
            libxkbcommon-dev \
            libwayland-dev \
            wayland-protocols \
            libxrandr-dev \
            libxi-dev \
            libxcursor-dev \
            libxdamage-dev \
            libxinerama-dev \
            libcups2-dev \
            libavfilter-dev \
            libgstreamer-plugins-bad1.0-dev

FROM setup_base AS glib2
RUN wget https://download.gnome.org/sources/glib/2.69/glib-2.69.3.tar.xz
RUN echo "47af2c6e06becee44d447ae7d1212dbab255b002b5141d9b62a4357c0ecc058f  glib-2.69.3.tar.xz" \
    | shasum -c
RUN tar -xf glib-2.69.3.tar.xz
RUN cd glib-* && \
    meson setup --prefix $PREFIX builddir && \
    cd builddir && \
    ninja && \
    ninja install


FROM glib2 AS GTK
RUN wget https://download.gnome.org/sources/gtk/4.3/gtk-4.3.2.tar.xz
RUN echo "20639bb2be8b9f58304f14480e3d957abd2c9fa3f671bb7e05193f9a8389d93f  gtk-4.3.2.tar.xz" \
    | shasum -c
RUN tar -xf gtk-*.tar.xz
RUN cd gtk-* && \
    meson setup --prefix $PREFIX builddir && \
    cd builddir && \
    ninja && \
    ninja install


FROM GTK AS build


FROM build_base AS release
RUN apt-get clean
COPY --from=build $PREFIX $PREFIX
