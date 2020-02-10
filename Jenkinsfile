def skipBuild=true
pipeline {
  agent any
  stages {
    stage('Checkout') {
      steps {
      checkout scm
      }
    }
    stage('check branch') {
      steps {
      sh 'git --version'
      echo "Branch: ${env.BRANCH_NAME}"
      script {
       def GIT_LOG = sh(script: "git log --oneline -n 1 HEAD --pretty=format:%B", returnStdout: true)
       def message = GIT_LOG.trim().replaceAll("\n ", "")
       echo "GIT_LOG:${message.size()} , ${GIT_LOG}"
       def deployMatch = message ==~ /(?i).*deploy#.*/
       echo "deployMatch: ${deployMatch}"
       if(deployMatch || ${env.BRANCH_NAME} == "master"){
         skipBuild = false;
       }
       echo "skipFeatureBranch: ${skipFeatureBranch}"
     }
      }
    }
    stage('Build'){
      when { expression { skipBuild == false }}
      steps {
     sh 'npm install'
     sh 'npm run build'
     sh 'tar -cvf public.tar public'
     archiveArtifacts artifacts: 'public.tar', fingerprint: true
      }
    }
  }
}