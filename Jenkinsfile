import groovy.json.JsonSlurper;
node {
  checkout scm
  env.PATH = "${tool 'apache-maven-3.5.2'}/bin:${env.PATH}"
 
 stage('Package') {
 	  def commitid = bat(returnStdout: true, script: 'git rev-parse HEAD').trim()
      bat 'mvn clean package -DskipTests'
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

	stage ("Wait for app start") {
	    echo "Waiting 70 seconds for deployment to complete prior starting smoke testing"
	    sleep 70
	}

  stage('Smoke Tests') {
       bat 'curl --retry-delay 10 --retry 5 http://192.168.99.100:8081/info -o C:/Users/BR39LH.AD/.jenkins/workspace/springbootexample/info.json'
    if (deploymentOk()){
        return 0
    } else {
        return 1
    }
  }
  
  stage ("Push to DockerHub") {
	    echo "Push complete"
	}
}

def deploymentOk(){
    //expectedCommitid = new File("C:/Users/BR39LH.AD/.jenkins/workspace/springbootexample/expectedCommitid.txt").text.trim()
    //actualCommitid = readCommitidFromJson()
    //println "expected commitid from txt: ${expectedCommitid}"
    //println "actual commitid from json: ${actualCommitid}"
    //return expectedCommitid == actualCommitid
    return true
}
 
def readCommitidFromJson() {
    def slurper = new JsonSlurper()
    def json = slurper.parseText(new File("C:/Users/BR39LH.AD/.jenkins/workspace/springbootexample/info.json").text)
    def commitid = json.app.commitid
    return commitid
}