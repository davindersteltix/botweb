def skipBuild = true
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
     def deployMatch = message == ~/(?i).*deployj#.*/
     echo "deployMatch: ${deployMatch}"
     if (deployMatch || env.BRANCH_NAME == "master") {
      skipBuild = false;
     }
     echo "skipBuild: ${skipBuild}"
    }
   }
  }
  stage('Build') {
   when {
    expression {
     skipBuild == false
    }
   }
   steps {
     notifyBuild('Build started');
    //slackSend baseUrl: 'https://hooks.slack.com/services/', channel: '#appsharedeploy', color: 'good', message: "started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)", tokenCredentialId: 'slack-token'
    // sh 'npm install'
    sh 'npm run build2'
    sh 'tar -cvf public.tar public'
    archiveArtifacts artifacts: 'public.tar', fingerprint: true
   }
  }
 }
 post {
  always {
   notifyBuild('Build error','error');
  }
 }
}

def notifyBuild(String msg , String type) {
  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${msg}: '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.RUN_DISPLAY_URL})"
  // Override default values based on build status
  if (type == 'info') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (type == 'error') {
    color = 'RED'
    colorCode = '#FF0000'
  } else {
    color = 'GREEN'
    colorCode = '#00FF00'
  }
  // Send notifications
  slackSend baseUrl: 'https://hooks.slack.com/services/', channel: '#appsharedeploy', color: colorCode, message: summary, tokenCredentialId: 'slack-token'
}