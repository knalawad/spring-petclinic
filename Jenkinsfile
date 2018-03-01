import groovy.json.JsonSlurper;
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

	stage ("Wait") {
	    echo "Waiting 70 seconds for deployment to complete prior starting smoke testing"
	    sleep 10
	}

  stage('Smoke Tests') {
       bat 'curl --retry-delay 10 --retry 5 http://192.168.99.100:8081/info -o C:/Users/BR39LH.AD/.jenkins/workspace/springbootexample/info.json'
    if (deploymentOk()){
        return 0
    } else {
        return 1
    }
  }
}

def deploymentOk(){
    def workspacePath = bat 'echo %cd%'
    expectedCommitid = new File("C:/Users/BR39LH.AD/.jenkins/workspace/springbootexample/expectedCommitid.txt").text.trim()
    actualCommitid = readCommitidFromJson()
    println "expected commitid from txt: ${expectedCommitid}"
    println "actual commitid from json: ${actualCommitid}"
    return expectedCommitid == actualCommitid
}
 
def readCommitidFromJson() {
    def workspacePath = bat 'echo %cd%'
    def slurper = new JsonSlurper()
    def json = slurper.parseText(new File("C:/Users/BR39LH.AD/.jenkins/workspace/springbootexample/info.json").text)
    def commitid = json.app.commitid
    return commitid
}