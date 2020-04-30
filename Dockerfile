FROM openjdk:8-jdk

# Use --ignore-depends=openjdk-8-jdk to avoid installation failure due to openjdk-8-jdk has been removed from its repo
RUN set -x && \
  curl -fsSL -o sbt.deb https://dl.bintray.com/sbt/debian/sbt-0.13.15.deb && \
  dpkg --ignore-depends=openjdk-8-jdk -i sbt.deb && \
  rm sbt.deb && \
  sbt sbtVersion

# set LANG=*.UTF-8 so that default file encoding will be UTF-8, otherwise any non-ASCII files may have trouble.
ENV LANG=C.UTF-8

CMD ["/bin/bash", "-l"]
