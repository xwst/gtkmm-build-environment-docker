FROM debian:stable-slim AS build_base
RUN apt-get update && \
    apt-get -y --no-install-recommends install \
            build-essential cmake g++ wget pkg-config ca-certificates libpcre3-dev 
ENV PREFIX=/opt/gtk

FROM build_base AS setup_base
WORKDIR = /opt
RUN apt-get -y --no-install-recommends install meson ninja-build git python3-setuptools

FROM setup_base AS glib20
RUN wget https://download.gnome.org/sources/glib/2.69/glib-2.69.3.tar.xz
RUN echo "47af2c6e06becee44d447ae7d1212dbab255b002b5141d9b62a4357c0ecc058f  glib-2.69.3.tar.xz" \
    | shasum -c
RUN tar -xf glib-*.tar.xz
RUN cd glib-* && \
    meson setup --prefix $PREFIX builddir && \
    cd builddir && \
    ninja && \
    ninja install


FROM glib20 As build

FROM build_base AS release
RUN apt-get clean
COPY --from=build $PREFIX $PREFIX
