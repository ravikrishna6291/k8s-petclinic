FROM maven:3.6.3-openjdk-11 AS maven
RUN yum update -y && yum upgrade -y && yum install git -y && yum install unzip -y
WORKDIR /opt
RUN wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.52/bin/apache-tomcat-9.0.52-windows-x64.zip
RUN  unzip apache-tomcat-9.0.52-windows-x64.zip
RUN mv apache-tomcat-9.0.52 tomcat
RUN chmod -R 700 tomcat
WORKDIR /opt
RUN git clone https://github.com/ravikrishna6291/spring-framework-petclinic.git
WORKDIR /opt/spring-framework-petclinic
RUN mvn clean package
WORKDIR /opt/spring-framework-petclinic/target
RUN cp -R petclinic.war /opt/tomcat/webapps/
EXPOSE 8080
CMD chmod +x /opt/tomcat/bin/catalina.sh
CMD /opt/tomcat/bin/catalina.sh run
