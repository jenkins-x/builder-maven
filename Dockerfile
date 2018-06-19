FROM jenkinsxio/builder-base:0.0.338

# Maven
ENV MAVEN_VERSION 3.5.3
RUN curl -L http://central.maven.org/maven2/org/apache/maven/apache-maven/$MAVEN_VERSION/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -C /opt -xzv
ENV M2_HOME /opt/apache-maven-$MAVEN_VERSION
ENV maven.home $M2_HOME
ENV M2 $M2_HOME/bin
ENV PATH $M2:$PATH

# Set JDK to be 32bit
COPY set_java $M2
RUN $M2/set_java && rm $M2/set_java

# upgrade skaffold
RUN curl -Lo skaffold https://github.com/jstrachan/skaffold/releases/download/v0.7.0.p1/skaffold-linux-amd64 && \
chmod +x skaffold && \
  mv skaffold /usr/bin

CMD ["mvn","-version"]
