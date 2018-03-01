

node {
  checkout scm
  env.PATH = "${tool 'apache-maven-3.5.2'}/bin:${env.PATH}"
  stage('Package') {
    //dir('src') {
      bat 'mvn clean package -DskipTests'
    //}
  }

	
  stage('Create Docker Image') {
  	  
  	  bat 'SET DOCKER_TLS_VERIFY=1'
  	  bat 'SET DOCKER_HOST=tcp://192.168.99.100:2376'
  	  bat 'SET DOCKER_CERT_PATH=C:/Users/BR39LH.AD/.docker/machine/machines/default'
  	  bat 'SET DOCKER_MACHINE_NAME=default'
  	  bat 'SET COMPOSE_CONVERT_WINDOWS_PATHS=true'
  	  bat 'echo %DOCKER_HOST%'
  	  bat 'echo %DOCKER_CERT_PATH%'
  	  bat '@FOR /f "tokens=*" %i IN ('docker-machine.exe env default') DO @%i'
	  bat 'docker build -t knalawad/springboot-petclinic .'
  }

  stage ('Run Application') {
    try {
      // Start database container here
      // sh 'docker run -d --name db -p 8091-8093:8091-8093 -p 11210:11210 arungupta/oreilly-couchbase:latest'

      // Run application using Docker image
      // sh "DB=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' db`"
      bat 'docker run -p 8080:8080 knalawad/spring-petclinic'

      // Run tests using Maven
      //dir ('webapp') {
      //  sh 'mvn exec:java -DskipTests'
      //}
    } catch (error) {
    } finally {
      // Stop and remove database container here
      //sh 'docker-compose stop db'
      //sh 'docker-compose rm db'
    }
  }

  stage('Run Tests') {
    try {
    //  dir('src') {
       // sh "mvn test"
        //docker.build("arungupta/docker-jenkins-pipeline:${env.BUILD_NUMBER}").push()
      //}
    } catch (error) {

    } finally {
      junit '**/target/surefire-reports/*.xml'
    }
  }
}