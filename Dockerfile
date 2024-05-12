FROM ubuntu:20.04 as build

#Solution of the problem of strict choosing timmezone
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y tzdata

#Install soft
RUN apt install git -y && apt install default-jdk -y
RUN apt install maven -y

#Download the project from GIT to the new directory
WORKDIR /home/elshl/superproject
RUN git clone https://github.com/koddas/war-web-project.git
RUN chmod -R 777 ./

#Transfer to project's directory where pom.xml + running maven
WORKDIR /home/elshl/superproject/war-web-project/
RUN mvn package

#Transfer the step to tomcat
FROM tomcat:9-jre8-temurin-focal
COPY --from=build /home/elshl/superproject/war-web-project/target/*.war /usr/local/tomcat/webapps/