def skipBuild=true
node {
  try {
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
       def deployMatch = message ==~ /(?i).*deployj#.*/
       echo "deployMatch: ${deployMatch}"
       if(deployMatch || env.BRANCH_NAME == "master"){
         skipBuild = false;
       }
       echo "skipBuild: ${skipBuild}"
     }
      }
    }
    stage('Build'){
      when { expression { skipBuild == false }}
      steps {
     slackSend baseUrl: 'https://hooks.slack.com/services/', channel: '#appsharedeploy', color: 'good', message: "started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)", tokenCredentialId: 'slack-token'
     sh 'npm install'
     sh 'npm run build'
     sh 'tar -cvf public.tar public'
     archiveArtifacts artifacts: 'public.tar', fingerprint: true
      }
    }
  }
  }
  catch (e) {
        // fail the build if an exception is thrown
        currentBuild.result = "FAILED"
        throw e
    }

}