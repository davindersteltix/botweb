node {
  try {
    stage('Checkout') {
      checkout scm
    }
    stage('Environment') {
      sh 'git --version'
      echo "Branch: ${env.BRANCH_NAME}"
      sh 'printenv'
    }
    stage('Build Docker'){
     sh 'npm ci'
     sh 'npm run build'
     sh 'tar -cvf public.tar public'
     archiveArtifacts artifacts: 'public.tar', fingerprint: true
    }
  }
  catch (err) {
    throw err
  }
}