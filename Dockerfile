FROM centos:7

RUN yum install -y unzip \
  which \
  make \
  java-1.8.0-openjdk-devel \
  java-1.8.0-openjdk-devel.i686

# Git
RUN curl -o ./endpoint-repo-1.7-1.x86_64.rpm https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm && \
  rpm -Uvh endpoint-repo*rpm && \
  yum install -y git 

# Docker
ENV DOCKER_VERSION 17.12.0
RUN curl https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION-ce.tgz | tar xvz && \
  mv docker/docker /usr/bin/ && \
  rm -rf docker

# helm
ENV HELM_VERSION 2.7.2
RUN curl https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz  | tar xzv && \
  mv linux-amd64/helm /usr/bin/ && \
  rm -rf linux-amd64

# Maven
ENV MAVEN_VERSION 3.3.9
RUN curl -L http://mirrors.ukfast.co.uk/sites/ftp.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar -C /opt -xzv
ENV M2_HOME /opt/apache-maven-$MAVEN_VERSION
ENV maven.home $M2_HOME
ENV M2 $M2_HOME/bin
ENV PATH $M2:$PATH

# jx-release-version
ENV JX_RELEASE_VERSION 1.0.4
RUN curl -o ./jx-release-version -L https://github.com/jenkins-x/jx-release-version/releases/download/v$JX_RELEASE_VERSION/jx-release-version-linux && \
  mv jx-release-version /usr/bin/ && \
  chmod +x /usr/bin/jx-release-version

# USER jenkins
WORKDIR /home/jenkins

# Set JDK to be 32bit
COPY set_java $M2
RUN $M2/set_java && rm $M2/set_java

CMD ["mvn","-version"]