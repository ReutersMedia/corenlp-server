FROM alpine:3.5
MAINTAINER kenneth.ellis@thomsonreuters.com

COPY pom.xml /root/pom.xml

RUN apk --update add openjdk8-jre  && \
    apk add --virtual builddep maven && \
    mkdir -p /usr/share/java/corenlp/lib && \
    cd /root && \
    mvn dependency:copy-dependencies -DoutputDirectory=/usr/share/java/corenlp/lib && \
    rm -rf /root/.m2 && \
    apk del builddep && \
    rm -rf /var/cache/apk/*
    

ENV CLASSPATH=/usr/share/java/corenlp/lib/*

EXPOSE 9000

CMD ["java", \
     "-mx4g", \
     "edu.stanford.nlp.pipeline.StanfordCoreNLPServer", \
     "-port", \
     "9000", \
     "-timeout", \
     "15000"]
