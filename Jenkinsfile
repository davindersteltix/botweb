pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
      checkout scm
      }
    }
    stage('Environment') {
      steps {
      sh 'git --version'
      echo "Branch: ${env.BRANCH_NAME}"
      //sh 'git log --oneline -n 1 HEAD'
      script {
       def POM_VERSION = sh(script: "git log --oneline -n 1 HEAD | grep deploy#", returnStdout: true)
       echo "${POM_VERSION}"
     }
      }
    }
    stage('Build'){
      steps {
     sh 'npm install'
     sh 'npm run build'
     sh 'tar -cvf public.tar public'
     archiveArtifacts artifacts: 'public.tar', fingerprint: true
      }
    }
  }
}