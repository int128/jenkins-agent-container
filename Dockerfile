FROM alpine:3.4
RUN apk update && apk add openjdk8-jre-base openssh curl git

# https://github.com/docker/compose/issues/3465
ENV GLIBC 2.23-r3
RUN curl -L -o /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
    curl -L -o /tmp/glibc-$GLIBC.apk https://github.com/sgerrand/alpine-pkg-glibc/releases/download/$GLIBC/glibc-$GLIBC.apk && \
    apk add --no-cache /tmp/glibc-$GLIBC.apk && \
    rm /tmp/glibc-$GLIBC.apk && \
    ln -s /lib/libz.so.1 /usr/glibc-compat/lib/ && \
    ln -s /lib/libc.musl-x86_64.so.1 /usr/glibc-compat/lib

RUN ssh-keygen -A && \
    adduser -D jenkins

EXPOSE 22
ADD init.sh /
CMD ["/init.sh"]
