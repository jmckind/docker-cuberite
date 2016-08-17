FROM ubuntu:latest

MAINTAINER John McKenzie<jmckind@gmail.com>

RUN apt-get update && apt-get install -y \
        clang                            \
        cmake                            \
        git                              \
        make                             \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --recursive https://github.com/cuberite/cuberite.git /tmp/cuberite \
    && cd /tmp/cuberite                                                          \
    && cmake . -DCMAKE_BUILD_TYPE=RELEASE                                        \
    && make -j 2                                                                 \
    && cp -r /tmp/cuberite/Server /opt/cuberite                                  \
    && rm -fr /tmp/cuberite

#COPY settings.ini /opt/cuberite/
#COPY motd.txt /opt/cuberite/
#COPY webadmin.ini /opt/cuberite/

EXPOSE 25565

WORKDIR /opt/cuberite

ENTRYPOINT ["/opt/cuberite/Cuberite"]
