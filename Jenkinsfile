pipeline {
  agent any
  stages {
    stage('Checkout') {
      checkout scm
    }
    stage('Environment') {
      sh 'git --version'
      echo "Branch: ${env.BRANCH_NAME}"
      sh 'printenv'
    }
    stage('Build'){
     sh 'npm install'
     sh 'npm run build'
     sh 'tar -cvf public.tar public'
     archiveArtifacts artifacts: 'public.tar', fingerprint: true
    }
  }
}