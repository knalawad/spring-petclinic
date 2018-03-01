FROM java
MAINTAINER Kavita Nalawade <knalawad@tibco.com>
EXPOSE 8080
ADD /target/springboot-petclinic.war springboot-petclinic.war
ENTRYPOINT ["java","-jar", "springboot-petclinic.war"]
