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
       def GIT_LOG = sh(script: "git log --oneline -n 10", returnStdout: true)
       echo "GIT_LOG: ${GIT_LOG}"
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