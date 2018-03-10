FROM jenkinsxio/builder-base:0.0.114

# Maven
ENV MAVEN_VERSION 3.3.9
RUN curl -L http://mirrors.ukfast.co.uk/sites/ftp.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -C /opt -xzv
ENV M2_HOME /opt/apache-maven-$MAVEN_VERSION
ENV maven.home $M2_HOME
ENV M2 $M2_HOME/bin
ENV PATH $M2:$PATH

# Set JDK to be 32bit
COPY set_java $M2
RUN $M2/set_java && rm $M2/set_java

CMD ["mvn","-version"]
