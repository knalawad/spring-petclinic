node {
  checkout scm
  env.PATH = "${tool 'apache-maven-3.5.2'}/bin:${env.PATH}"
 
 stage('Package') {
    //dir('src') {
      bat 'mvn clean package -DskipTests'
    //}
  }
	
  stage('Create Docker Image') {
  	  bat 'createdockerimage.cmd'
  }

  stage ('Run Application') {
    try {

      bat 'rundockercontainer.cmd'

      // Run tests using Maven
      //dir ('webapp') {
      //  sh 'mvn exec:java -DskipTests'
      //}
    } catch (error) {
    } finally {
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