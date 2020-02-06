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
    stage('Build Docker test'){
     sh 'npm i'
     sh 'npm run build'
    }
  }
  catch (err) {
    throw err
  }
}