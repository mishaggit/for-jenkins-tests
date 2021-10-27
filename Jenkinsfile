pipeline {
    agent {
        label 'slave'
    }
    parameters {
        choice(name: 'CHOICES', choices: ['terraform plan', 'terraform apply'], description: 'Choose terraform command')
        string(name: 'FOLDERTF', defaultValue: 'service_accounts', description: 'Folder with .tf files')
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
        stage ("Terraform Command") {
            steps {
                echo "Choice is ${params.CHOICES}"
                dir("${params.FOLDERTF}"){
                    script {
                        sh "echo $PATH"
                        sh "terraform init -no-color"
                        sh "terraform validate -no-color"
                        sh "terraform plan -no-color"
                        if ("${params.CHOICES}" == 'terraform apply'){
                            sh "${params.CHOICES}"
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