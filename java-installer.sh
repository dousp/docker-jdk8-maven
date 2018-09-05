#!/bin/bash

# copy by  https://github.com/bpatterson971/docker-centos7-jdk8/blob/master/java-installer.sh

JAVA_URL="http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz"
# Checksum via https://www.oracle.com/webfolder/s/digest/8u172checksum.html
CHECKSUM="28a00b9400b6913563553e09e8024c286b506d8523334c93ddec6c9ec7e9d346"

curl \
	-L \
	-H "Cookie: oraclelicense=accept-securebackup-cookie" \
	-o /tmp/jdk.tar.gz \
	"${JAVA_URL}"

DOWNLOADED_CHECKSUM=`sha256sum /tmp/jdk.tar.gz | grep -o -E -e "[a-f0-9]*\s" | tr -d '[[:space:]]'`

echo "Checksum from Oracle is: ${CHECKSUM}"
echo "Downloaded checksum is: ${DOWNLOADED_CHECKSUM}"

if [ "${CHECKSUM}" != "${DOWNLOADED_CHECKSUM}" ]; then
	echo "Checksum verification failed; install aborted."
	rm /tmp/jdk.tar.gz
	exit 1
fi

mkdir -p /usr/java
tar -xzf /tmp/jdk.tar.gz -C /usr/java
chown -R root:root ${JDK_HOME}
ln -s ${JDK_HOME} /usr/java/jdk1.8
echo "PATH=$PATH:/usr/java/jdk1.8/jre/bin:/usr/java/jdk1.8/bin" > /etc/profile.d/java
rm /tmp/jdk.tar.gz
