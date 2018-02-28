FROM java:8
EXPOSE 8080
ADD /target/springboot-petclinic.war springboot-petclinic.war
ENTRYPOINT ["java","-jar", "springboot-petclinic.war"]
