pipeline {
    agent any
    parameters {
        //string(name: 'environment', defaultValue: 'default', description: 'Workspace/environment file to use for deployment')
        //string(name: 'version', defaultValue: '', description: 'Version variable to pass to Terraform')
        choice(name: 'CHOICES', choices: ['terraform init', 'terraform validate', 'terraform plan', 'terraform apply'], description: 'Choose terraform command')
        //booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    }
    environment {
      PROJECT_NAME = "TestTerraform"
      OWNER_NAME   = "Misha"
    }
    stages {
        stage('2-Test') {
            steps {
                echo "Testing..................................."
                //echo "Privet ${PROJECT_NAME}"
                //echo "Owner is ${OWNER_NAME}"
                echo "End of Stage Build........................"
            }
        }
        stage ("Terraform Command") {
            steps {
		        sh "echo $PATH"
                echo "Choice: ${params.CHOICES}"
                sh "cd service_accounts"
                sh "pwd"
                sh '${CHOICES}'
            }
        }
        stage('Plan') {
            steps {
                script {
                    currentBuild.displayName = params.version
                }
                sh 'terraform init -input=false'
                sh 'terraform workspace select ${environment}'
                sh "terraform plan -input=false -out tfplan -var 'version=${params.version}' --var-file=environments/${params.environment}.tfvars"
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }

        stage('Approval') {
            when {
                not {
                    equals expected: true, actual: params.autoApprove
                }
            }

            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Do you want to apply the plan?",
                        parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            steps {
                sh "terraform apply -input=false tfplan"
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'tfplan.txt'
        }
    }
}
