FROM openjdk:21-slim-bullseye

ENV USER=iiif
ENV VERSION=5.0.5

EXPOSE 8182

# Update packages and install tools
#RUN apt-get update -y && apt-get install -y wget unzip graphicsmagick curl build-essential cmake

RUN apt-get update -y && apt-get install -y curl unzip

RUN adduser --system ${USER}



WORKDIR /usr/local
RUN curl -OL https://github.com/cantaloupe-project/cantaloupe/releases/download/v${VERSION}/cantaloupe-${VERSION}.zip \
 && unzip cantaloupe-${VERSION}.zip \
 && rm cantaloupe-${VERSION}.zip 

COPY cantaloupe.properties /etc/cantaloupe.properties 
RUN mkdir -p /var/log/cantaloupe \
 && mkdir -p /var/cache/cantaloupe /var/cache/cantaloupe \
 && chown -R ${USER} /var/cache/cantaloupe /var/log/cantaloupe

USER ${USER} 
CMD ["sh", "-c", "java -Dcantaloupe.config=/etc/cantaloupe.properties -Xmx2g -jar /usr/local/cantaloupe-${VERSION}/cantaloupe-${VERSION}.jar"]
