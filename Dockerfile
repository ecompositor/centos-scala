#scala and sbt on Java 7

FROM centos:centos7
MAINTAINER Michael Klatskin <michael.ecompositor.com>
RUN  yum install -y epel-release
RUN  yum update -y && yum install -y \
  git \
  unzip \
  tar \
  wget \
  httpie \
  nodejs \
  npm

#versions
ENV JDK_RPM jdk-7u67-linux-x64.rpm
ENV JDK_RPM_URL http://download.oracle.com/otn-pub/java/jdk/7u67-b01/
ENV SCALA_TAR_URL http://www.scala-lang.org/files/archive
ENV SCALA_VERSION 2.10.4
ENV SBT_VERSION 0.13.6
 

#install java
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"  $JDK_RPM_URL/$JDK_RPM 
RUN chmod a+x $JDK_RPM
RUN rpm -Uvh $JDK_RPM
RUN rm $JDK_RPM

#install scala
RUN wget $SCALA_TAR_URL/scala-$SCALA_VERSION.tgz
RUN tar xvf scala-$SCALA_VERSION.tgz
RUN mv scala-$SCALA_VERSION /usr/lib
RUN rm scala-$SCALA_VERSION.tgz
RUN ln -s /usr/lib/scala-$SCALA_VERSION /usr/lib/scala

ENV PATH $PATH:/usr/lib/scala/bin
 
# install sbt
RUN wget -O /usr/local/bin/sbt-launch.jar http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch.jar
ADD scripts/sbt.sh /usr/local/bin/sbt
RUN chmod 755 /usr/local/bin/sbt

# install serf
 
RUN wget https://dl.bintray.com/mitchellh/serf/0.6.3_linux_amd64.zip

RUN unzip 0.6.3_linux_amd64.zip  
RUN rm 0.6.3_linux_amd64.zip
RUN mv serf /usr/local/bin

#ADD scripts/run-in-docker.sh .
#RUN chmod 755 run-in-docker.sh
# make target dir
#RUN mkdir target
#ADD target target
#RUN mv target/universal/stage /opt/feedback
#RUN rm -rf target
#RUN mv run-in-docker.sh /opt/feedback/bin/run-in-docker.sh
#WORKDIR /opt/feedback
#ENTRYPOINT ["bin/run-in-docker.sh"]
#:CMD ["start-foreground"] 
