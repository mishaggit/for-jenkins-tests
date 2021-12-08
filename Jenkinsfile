pipeline {
    agent {
        label 'slave'
    }
    options {ansiColor('xterm') }
    parameters {
        choice(name: 'CHOICES', choices: ['gcr.io/myproject-7777777/sometest', 'gcr.io/myproject-7777777/sametest'], description: 'Choose GCR path')
        string(name: 'FOLDERTF', defaultValue: 'all', description: 'Folder with .tf files')
        choice(name: 'FOLDERTFs', choices: ['service_accounts', 'network', 'gke cluster'], description: 'Folder with .tf files')
    }
    environment {
      PROJECT_NAME = "TestTerraform"
      OWNER_NAME   = "Misha"
    }
    stages {
        stage('1-Test') {
            steps {
                echo "Testing..................................."
                //sh "echo $PATH"
                sh "gcloud container images list"
                echo "=================================list"
                sh "gcloud container images list-tags gcr.io/myproject-7777777/sometest"
                sh "gcloud container images delete sametest"
                echo "End of Stage Build........................"
                script {
                    images = sh(returnStdout: true, script: "gcloud container images list").trim()
                    echo "$images"
                    allimages = "$images".split()
                    echo "$allimages"
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