FROM ubuntu:20.04
RUN apt-get update &&  DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN apt update
RUN apt install git -y
RUN apt install default-jdk -y
RUN apt install maven -y
RUN apt install tomcat9 -y
RUN git clone https://github.com/koddas/war-web-project.git
EXPOSE 80
WORKDIR /home/elshl/war-web-project/
RUN mvn package
WORKDIR /home/elshl/war-web-project/target/
ADD wwp-2.0.0.war /var/lib/tomcat9/webapps/
CMD ["catalina.sh", "run"]