FROM ubuntu:latest as build

RUN apt-get update && apt-get install -y \
        clang                            \
        cmake                            \
        git                              \
        make                             \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --recursive https://github.com/cuberite/cuberite.git /tmp/cuberite \
    && cd /tmp/cuberite                                                          \
    && cmake . -DCMAKE_BUILD_TYPE=RELEASE                                        \
    && make -j 2

FROM ubuntu:latest

LABEL maintainer="John McKenzie<jmckind@gmail.com>"

COPY --from=build /tmp/cuberite/Server /opt/cuberite
COPY wrapper.sh /opt/cuberite/cuberite-wrapper
RUN mkdir /etc/cuberite

EXPOSE 8080 25565
WORKDIR /opt/cuberite
ENTRYPOINT ["/opt/cuberite/cuberite-wrapper"]
