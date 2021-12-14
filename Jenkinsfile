pipeline {
    agent {
        label 'slave'
    }
    options {ansiColor('xterm') }
    parameters {
        choice(name: 'CHOICES', choices: ['gcr.io/myproject-7777777/sometest'], description: 'Choose GCR path')
    }
    environment {
      PROJECT_NAME = "TestJenkins"
      OWNER_NAME   = "Misha"
    }
    stages {
        stage('1-Test') {
            steps {
                echo "Testing..................................."
                //sh "echo $PATH"
                sh "gcloud container images list"
                sh "gcloud container images list-tags gcr.io/myproject-7777777/sometest"
                echo "=================================list"
                //sh "gcloud container images list-tags gcr.io/myproject-7777777/sametest --filter='-tags:*'  --format="get(digest)" --limit=$BIG_NUMBER"
                //sh "gcloud container images list-tags gcr.io/myproject-7777777/sametest --filter='-tags:*'  --format=\"get(digest)\" "
                //sh "gcloud container images delete gcr.io/myproject-7777777/sametest@DIGEST --quiet"
                script {
                    untaged = sh(returnStdout: true, script: "gcloud container images list-tags gcr.io/myproject-7777777/sametest --filter='-tags:*'  --format=\"get(digest)\" ")
                    echo "$untaged"
                    //sh "gcloud container images delete gcr.io/myproject-7777777/sametest@$untaged --quiet"
                }
                //sh "gcloud container images delete gcr.io/myproject-7777777/sametest:red"
                //sh "gcloud container images list-tags ${params.CHOICES}"            
                echo "End of Stage Build........................"
                script {
                    images = sh(returnStdout: true, script: "gcloud container images list --format=json | jq '.[].name' -r").trim()
                    echo "$images"
                    allimages = "$images".split()
                    echo "$allimages"
                    /*allimages.each {
                        val -> ("$val") {script {sh "echo test install jq"}}
                    }*/
                }

            }
        }
        /*

        stage('Find all fodlers from given folder') {
            steps {
                script {
                    folders = sh(returnStdout: true, script: "find -path './[^.]*' -prune -type d").trim()
                    echo "$folders"
                    folderstf = "$folders".split()
                    echo "=================================list"
                    echo "$folderstf"
                    echo "=================================list"
                    folderstf.each {
                        val -> dir("$val") {script {sh "echo test"}}
                    }
                }
            }
        }
        stage ("Terraform Command") {
            steps {
                echo "Choice is ${params.CHOICES}"
                script {
                    for (value in folderstf) {
                        dir("$value"){
                            sh "echo $PATH"
                            sh "echo test"
                        }
                    }
                }
            }
        }
        */
    }
    post {
        always {
            cleanWs()
        }
    }
}