# gtkmm Build Environment Docker
Dockerfile to set up a build environment for gtkkmm

## Why?
When I first started developing with gtkmm 4 there were no precompiled binares of GTK 4 available in the debian repositories, let alone binaries of gtkmm 4. I set up everything manually but did not write down any of the steps taken. When I wanted to upgrade the libraries a year later, I had to start all over again. I figured it would be nice to have everything dockerized to utilize the concept of ["Dockerized build environments for C/C++ projects"](https://ddanilov.me/dockerized-cpp-build).

With `libgtk-4-dev` beeing available in the debian repositories now, things are much simpler than before. And once `libgtkmm-4-dev` is available, too, this Dockerfile becomes obsolete. I still keep this repository around, as it allows to quickly set up more recent versions of the libraries and can also be used to upgrade to the next major release much faster in a couple of years. It also may serve as an example for build environments featuring different libraries, if you are keen to set one up.

## Design Choices
Some of the packages that are installed from the debian repositories could have been compiled from source instead, but I was too lazy.

Some of the packages that are compiled from source could have been installed from the debian repositories instead, but I wanted to keep it a bit more universal.
