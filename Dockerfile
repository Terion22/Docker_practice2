FROM ubuntu:20.04
#Решение проблемы с выбором временной зоны
RUN apt update &&  DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
#Обновить и установить необходимый софт
RUN apt update
RUN apt install git -y
RUN apt install default-jdk -y
RUN apt install maven -y
RUN apt install tomcat9 -y
#-----------------------------------------------------------------------------
FROM maven:latest
#Cкачать проект с git
RUN git clone https://github.com/koddas/war-web-project.git
#Переместиться в директорию проекта, где существует pom.xml
WORKDIR /home/elshl/war-web-project
COPY * /home/elshl
#Запустить maven для создания артефакта *.WAR
RUN mvn package
#Переместиться в директорию с артефактом
WORKDIR /home/elshl/war-web-project/target/
#Добавить артефакт в директорию tomcat
ADD wwp-2.0.0.war /var/lib/tomcat9/webapps/
EXPOSE 80
#запустить tomcat
CMD ["catalina.sh", "run"]