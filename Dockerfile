FROM ubuntu:20.04

#Решение проблемы с выбором временной зоны
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y tzdata

#Обновить и установить необходимый софт
RUN apt install git -y && apt install default-jdk -y
RUN apt install maven -y
RUN apt install tomcat9 -y
#-----------------------------------------------------------------------------
#Cкачать проект с git в новую директорию
WORKDIR /home/elshl/superproject
RUN git clone https://github.com/koddas/war-web-project.git
RUN chmod -R 777 ./
#Переместиться в директорию проекта, где существует pom.xml
WORKDIR /home/elshl/superproject/war-web-project/
#Запустить maven для создания артефакта *.WAR
RUN mvn package
#Перейти в директорию с созданным артифактом *WAR и переместить его в рабочую директорию tomcat
WORKDIR /home/elshl/superproject/war-web-project/target/
RUN cp *.war /var/lib/tomcat9/webapps/
EXPOSE 80
#запустить tomcat
CMD ["catalina.sh", "run"]