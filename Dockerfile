FROM java
MAINTAINER Kavita Nalawade <knalawad@tibco.com>
EXPOSE 8080
ADD C:/Work/MB/docker-spring-petclinic/spring-petclinic/target/springboot-petclinic.war springboot-petclinic.war
ENTRYPOINT ["java","-jar", "springboot-petclinic.war"]
