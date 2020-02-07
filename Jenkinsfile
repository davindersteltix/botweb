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
      sh 'printenv'
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