FROM ubuntu:20.04

#Решение проблемы с выбором временной зоны
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y tzdata

#Обновить и установить необходимый софт
RUN apt install git -y && apt install default-jdk -y
RUN apt install maven -y
#RUN apt install tomcat9 -y
#-----------------------------------------------------------------------------
#Cкачать проект с git в новую директорию
WORKDIR /home/elshl/superproject
RUN git clone https://github.com/koddas/war-web-project.git
RUN chmod -R 777 ./
#Переместиться в директорию проекта, где существует pom.xml
WORKDIR /home/elshl/superproject/war-web-project/
#Запустить maven для создания артефакта *.WAR
RUN mvn package
#--Передать эстафетную палочку томкату
FROM tomcat:9-jre8-temurin-focal
COPY --from=build /home/elshl/superproject/war-web-project/target/*.war /usr/local/tomcat/webapps/
#CMD ["catalina.sh", "run"]