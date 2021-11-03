pipeline {
    agent {
        label 'slave'
    }
    parameters {
        choice(name: 'CHOICES', choices: ['terraform plan', 'terraform apply'], description: 'Choose terraform command')
        string(name: 'FOLDERTF', defaultValue: 'service_accounts', description: 'Folder with .tf files')
        //string(name: 'FOLDERTF', defaultValue: '', description: 'Folder with .tf files')
        //choice(name: 'FOLDERTF', choices: ['service_accounts', 'network', 'gke cluster'], description: 'Folder with .tf files')
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
                dir("${params.FOLDERTF}") {
                    script {
                        sh "find ./ -type d"
                    }
                }
                /*dir("${params.FOLDERTF}") {
                    script {
                        def foldersList = []
                        def osName = isUnix() ? "UNIX" : "WINDOWS"

                        echo ".... JENKINS_HOME: ${JENKINS_HOME}"

                        if(isUnix()) {
                            def output = sh returnStdout: true, script: "ls -l ${JENKINS_HOME} | grep ^d | awk '{print \$9}'"
                            foldersList = output.tokenize('\n').collect() { it }
                        } else {
                            def output = bat returnStdout: true, script: "dir \"${JENKINS_HOME}\" /b /A:D"
                            foldersList = output.tokenize('\n').collect() { it }
                            foldersList = foldersList.drop(2)
                        }
                        echo ".... " + foldersList
                    }
                }*/
            }
        }*/
        stage ("Terraform Command") {
            
            steps {
                ansiColor('xterm') {
                echo "Choice is ${params.CHOICES}"
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