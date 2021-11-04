pipeline {
    agent {
        label 'slave'
    }
    parameters {
        choice(name: 'CHOICES', choices: ['terraform plan', 'terraform apply'], description: 'Choose terraform command')
        string(name: 'FOLDERTF', defaultValue: 'all', description: 'Folder with .tf files')
        //string(name: 'FOLDERTF', defaultValue: '', description: 'Folder with .tf files')
        choice(name: 'FOLDERTFs', choices: ['service_accounts', 'network', 'gke cluster'], description: 'Folder with .tf files')
        //string(name: 'version', defaultValue: '', description: 'Version variable to pass to Terraform')
        //booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }
    environment {
      PROJECT_NAME = "TestTerraform"
      OWNER_NAME   = "Misha"
    }
    stages {
        stage('1-Test') {
            steps {
                echo "Testing..................................."
                //echo "Privet ${PROJECT_NAME}"
                //echo "Owner is ${OWNER_NAME}"
                sh "echo $PATH"
                echo "End of Stage Build........................"
            }
        }
        stage('Find all fodlers from given folder') {
            steps {
                script {
                    folders = sh(returnStdout: true, script: "find -path './[^.]*' -prune -type d").trim()
                    echo "$folders"
                    //folderstf = "$folders".toArray()
                    folderstf = "$folders".split()
                    //sh "find ./ -type d"
                    echo "=================================list"
                    echo "$folderstf"
                    echo "=================================list"
                    //sh "for value in (find -path './[^.]*' -prune -type d); do echo $value; done"
                    //sh "for folderstf in ./* ; do echo $folderstf; done"
                    //for (item in "$folderstf") { println item }
                    folderstf.each {
                        val -> dir"$val"
                        sh "echo $PATH"
                        sh "terraform init"
                        sh "terraform plan"
                    }
                }
            }
        }
        stage ("Terraform Command") {
            
            steps {
                ansiColor('xterm') {
                    echo "Choice is ${params.CHOICES}"
                    /*for (foldertf in ${params.FOLDERTFs}) {
                        dir("$foldertf"){
                            script {
                                sh "echo $PATH"
                                sh "terraform init"
                                sh "terraform validate"
                                sh "terraform plan"
                            }
                        }
                    }*/
                    dir("${params.FOLDERTF}"){
                        script {
                            sh "echo $PATH"
                            sh "terraform init"
                            sh "terraform validate"
                            sh "terraform plan"
                        }
                    }
                }
            }
        }
        stage('TF Apply') {
            when { anyOf {branch "main";branch "master" } }
            steps {
                ansiColor('xterm') {
                script {
                    dir("${params.FOLDERTF}") {
                        input(message: 'Do you want TF Apply', ok: 'Proceed')
                        sh "${params.CHOICES} -input=false -auto-approve"
                    }
                }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}