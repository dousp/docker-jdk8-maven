FROM douspeng/docker-ali-centos

MAINTAINER Douspeng "douspeng@sina.cn"

ENV MAVEN_VERSION=3.5.4  \
        JAVA_HOME=/usr/java/default \
        RPM_NAME=jdk-8u181-linux-x64.rpm \
        OJDK_VERSION=8u181-b13 \
        MAVEN_HOME=/opt/apache-maven-3.5.4 \
        DOWN_DIR=/download

RUN \
    yum -y remove java* && \
    echo "##start download oracle jdk##" && \
    curl -L "http://download.oracle.com/otn-pub/java/jdk/${OJDK_VERSION}/96a7b8442fe848ef90c96a2fad6ed6d1/${RPM_NAME}" \
           -H "Cookie: oraclelicense=accept-securebackup-cookie"  \
           -H "Connection: keep-alive" -O && \
    echo "##finish download oracle jdk##" && \
    rpm -ivh ${RPM_NAME} && \
    rm ${RPM_NAME} && \
    mkdir -p ${DOWN_DIR} && \
    curl -o ${DOWN_DIR}/apache-maven-${MAVEN_VERSION}-bin.tar.gz http://apache.cs.utah.edu/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    mkdir -p /opt && \
    cd /opt && \
    tar -zxf ${DOWN_DIR}/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    ln -sf "${MAVEN_HOME}/bin/mvn" /usr/bin/mvn && \
    rm -rf ${DOWN_DIR} && \
    yum  clean all

CMD ["/bin/bash"]