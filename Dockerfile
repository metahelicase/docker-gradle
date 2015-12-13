FROM java:8
MAINTAINER Francesco Komauli <francesco.komauli@gmail.com>

ENV GRADLE_VERSION=2.9
ENV GRADLE_URL=https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
ENV GRADLE_SHA256=c9159ec4362284c0a38d73237e224deae6139cbde0db4f0f44e1c7691dd3de2f

VOLUME /project
ENV GRADLE_HOME /gradle

WORKDIR /tmp
RUN wget -O gradle.zip $GRADLE_URL \
 && echo "$GRADLE_SHA256  gradle.zip" | sha256sum -c - \
 && unzip gradle.zip \
 && rm gradle.zip \
 && mv gradle-${GRADLE_VERSION} $GRADLE_HOME \
 && chmod -R 777 $GRADLE_HOME

ENV PATH $PATH:$GRADLE_HOME/bin
ENV _JAVA_OPTIONS -Duser.home=$GRADLE_HOME

USER root
WORKDIR /project
ENTRYPOINT ["gradle"]
CMD ["--version"]
