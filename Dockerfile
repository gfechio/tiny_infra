FROM tomcat:8.0
LABEL maintainer gfechio
RUN wget https://tomcat.apache.org/tomcat-8.0-doc/appdev/sample/sample.war -O $CATALINA_HOME/webapps/sample.war
EXPOSE 8080
CMD catalina.sh run
