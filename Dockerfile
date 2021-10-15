FROM openjdk:8-jdk-slim as build
LABEL MAINTAINER="Kubernauts-lab"


ARG JMETER_VERSION=5.4.1

RUN apt-get clean && \
	apt-get update && \
	apt-get -qy install \
	wget \
	telnet \
	iputils-ping \
	unzip
RUN mkdir /jmeter \
	&& cd /jmeter/ \
	&& wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz \
	&& tar -xzf apache-jmeter-$JMETER_VERSION.tgz \
	&& rm apache-jmeter-$JMETER_VERSION.tgz

RUN cd /jmeter/apache-jmeter-$JMETER_VERSION/ && \
	wget -q -O /tmp/JMeterPlugins-Standard-1.4.0.zip https://jmeter-plugins.org/downloads/file/JMeterPlugins-Standard-1.4.0.zip && \
	unzip -n /tmp/JMeterPlugins-Standard-1.4.0.zip && \
	rm /tmp/JMeterPlugins-Standard-1.4.0.zip

RUN wget -q -O /jmeter/apache-jmeter-$JMETER_VERSION/lib/ext/pepper-box-1.0.jar https://github.com/raladev/load/blob/master/JARs/pepper-box-1.0.jar?raw=true

RUN cd /jmeter/apache-jmeter-$JMETER_VERSION/ && \
	wget -q -O /tmp/bzm-parallel-0.7.zip https://jmeter-plugins.org/files/packages/bzm-parallel-0.7.zip && \
	unzip -n /tmp/bzm-parallel-0.7.zip && \
	rm /tmp/bzm-parallel-0.7.zip

RUN ln -s /jmeter/apache-jmeter-$JMETER_VERSION /jmeter/apache-jmeter


FROM openjdk:8-jdk-slim as jmeter

COPY --from=build /jmeter /jmeter
COPY init.sh /init.sh
ENV JMETER_HOME /jmeter/apache-jmeter/	
ENV PATH $JMETER_HOME/bin:$PATH

EXPOSE 1099 50000 60000

ENTRYPOINT ["/init.sh"]