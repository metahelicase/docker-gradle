FROM java:8
MAINTAINER Francesco Komauli <francesco.komauli@gmail.com>

ENV GRADLE_VERSION=2.8
ENV GRADLE_URL=https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip
ENV GRADLE_SHA256=a88db9c2f104defdaa8011c58cf6cda6c114298ae3695ecfb8beb30da3a903cb

VOLUME /project
ENV GRADLE_HOME /gradle
ENV GRADLE_USER_HOME /project/.gradle

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
