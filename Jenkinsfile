#!groovy

pipeline {
  agent none
  stages {
    stage('Maven Install') {
      steps {
        bat 'mvn clean package -DskipTests'
      }
    } 
  }
}