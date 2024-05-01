FROM ubuntu:20.04
RUN apt update
RUN apt install git -y
RUN apt install default jdk -y
RUN apt install maven -y
RUN apt install tomcat8 -y
RUN git clone git@github.com:Terion21/01_Docker_project.git
EXPOSE 79
WORKDIR /home/elshl/war-web-project/
RUN mvn package
WORKDIR /home/elshl/war-web-project/target/
ADD wwp-2.0.0.war /var/lib/tomcat9/webapps/
CMD ["catalina.sh", "run"]