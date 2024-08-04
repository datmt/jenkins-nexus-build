//this build push the latest from master to the PROD env
//Build to prod ONLY trigger manually
pipeline {
    agent any
    environment {
        DOCKERFILE="Dockerfile"
        SHORT_COMMIT = "${GIT_COMMIT[0..7]}"
    }
    stages {
        stage('Build image and push to docker hub') {
            steps {
                script {
                     nodejs(nodeJSInstallationName: 'nodejs18') {
                         sh 'corepack enable'
                         sh 'corepack prepare pnpm@latest-8 --activate'
                         sh 'pnpm install'
                         sh 'pnpm build'
                     }
                     echo "Build number ${GIT_COMMIT}"
                     docker.withRegistry('http://nexus3:9000/repository/d1', 'jenkins_docker') {
                     def app = docker.build("pipeline-demo:${GIT_COMMIT}", "--build-arg UK_BUILD_SHA=${SHORT_COMMIT} -f ${DOCKERFILE} .").push()
                  }
                }
            }
        }
    }
    post {
     success {
        sh 'curl -X POST -H "Content-Type: application/json" -d \'{"chat_id": "1024803686", "text": "[🔥SUCCESS] Ukata UI build success🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥!", "disable_notification": false}\' "https://api.telegram.org/bot6937024468:AAHcF-6an1lcpfmmUrGq9nghMSy0cr7_JFA/sendMessage"'
     }
     failure {
        sh 'curl -X POST -H "Content-Type: application/json" -d \'{"chat_id": "1024803686", "text": "[💀FAILED] Ukata UI build failed😭😭😭😭😭😭😭😭😭😭😭😭😭😭😭!", "disable_notification": false}\' "https://api.telegram.org/bot6937024468:AAHcF-6an1lcpfmmUrGq9nghMSy0cr7_JFA/sendMessage"'
     }
    }
}
