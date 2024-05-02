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
#FROM maven:latest
#Cкачать проект с git
WORKDIR /home/elshl/
RUN mkdir "superproject"
WORKDIR /home/elshl/superproject
RUN git clone https://github.com/koddas/war-web-project.git
RUN find /home/elshl/superproject/ -type f -exec chmod 644
#Переместиться в директорию проекта, где существует pom.xml
WORKDIR /home/elshl/superproject/war-web-project/
#RUN chmod +x /home/elshl/war-web-project/pom.xml
COPY pom.xml /home/elshl/superproject/
#Запустить maven для создания артефакта *.WAR
WORKDIR /home/elshl/superproject/
RUN mvn package
#Переместиться в директорию с артефактом
WORKDIR /home/elshl/superproject/war-web-project/target/
#НЕ ДОШЛА ДО tomcat еще, ниже можно не смотреть
#Добавить артефакт в директорию tomcat
ADD wwp-2.0.0.war /var/lib/tomcat9/webapps/
EXPOSE 80
#запустить tomcat
ENTRYPOINT ["java", "-war", "wwp-2.0.0.war"]
CMD ["catalina.sh", "run"]