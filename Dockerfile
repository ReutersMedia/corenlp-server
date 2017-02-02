FROM alpine:3.5
MAINTAINER kenneth.ellis@thomsonreuters.com

COPY pom.xml /root/pom.xml

RUN apk --update add openjdk8-jre maven && \
    mkdir -p /usr/share/java/corenlp/lib && \
    cd /root && \
    mvn dependency:copy-dependencies -DoutputDirectory=/usr/share/java/corenlp/lib

ENV CLASSPATH=/usr/share/java/corenlp/lib/*

EXPOSE 9000

CMD ["java", \
     "-mx4g", \
     "edu.stanford.nlp.pipeline.StanfordCoreNLPServer", \
     "-port", \
     "9000", \
     "-timeout", \
     "15000"]
