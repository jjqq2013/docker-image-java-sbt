# openjdk:8-jdk has a problem: it has installed openjdk-8-jdk, but apt install anything that depends on it will fail,
# that is because this base image is based on Debian buster which has removed java8 related things from its repo.
# We should use Debian stretch or Ubuntu bionic as base image.
FROM openjdk:8-jdk

RUN set -x && \
  curl -fsSL -o sbt.deb https://dl.bintray.com/sbt/debian/sbt-0.13.15.deb && \
  # Use --ignore-depends=openjdk-8-jdk to avoid installation failure due to openjdk-8-jdk has been removed from its repo
  dpkg --ignore-depends=openjdk-8-jdk -i sbt.deb && \
  # hack: remove dependences of jdk, otherwise any later apt install command will fail
  sed --in-place -E 's/, *openjdk-8-jdk\b//g; s/\bopenjdk-8-jdk(, *| *$)//g' /var/lib/dpkg/status && \
  rm sbt.deb && \
  sbt sbtVersion

# set LANG=*.UTF-8 so that default file encoding will be UTF-8 and you can input non-ASCII chars in bash etc.
ENV LANG=C.UTF-8

# just for debug
CMD ["/bin/bash", "-l"]
