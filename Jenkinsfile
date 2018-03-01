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

	stage ("wait_prior_starting_smoke_testing") {
	    echo "Waiting 70 seconds for deployment to complete prior starting smoke testing"
	    sleep 70
	}

  stage('Smoke Tests') {
    def workspacePath = pwd()
    bat 'curl --retry-delay 10 --retry 5 http://192.168.99.100:8081/info -o ${workspacePath}/info.json'
    if (deploymentOk()){
        return 0
    } else {
        return 1
    }
  }
}

def deploymentOk(){
    def workspacePath = pwd()
    expectedCommitid = new File("${workspacePath}/expectedCommitid.txt").text.trim()
    actualCommitid = readCommitidFromJson()
    println "expected commitid from txt: ${expectedCommitid}"
    println "actual commitid from json: ${actualCommitid}"
    return expectedCommitid == actualCommitid
}
 
def readCommitidFromJson() {
    def workspacePath = pwd()
    def slurper = new JsonSlurper()
    def json = slurper.parseText(new File("${workspacePath}/info.json").text)
    def commitid = json.app.commitid
    return commitid
}