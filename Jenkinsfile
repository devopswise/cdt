node('jenkins-python-slave') {
    currentBuild.result = "SUCCESS"
    try {
       stage('run dwtools-installer'){
           withCredentials([string(credentialsId: 'AWS_ACCESS_KEY', variable: 'AWS_ACCESS_KEY_ID'),
                         string(credentialsId: 'AWS_SECRET_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
                         string(credentialsId: 'DWTOOLS_ELASTIC_IP', variable: 'DWTOOLS_ELASTIC_IP'),
                         string(credentialsId: 'DWTOOLS_SERVER_FQDN', variable: 'DWTOOLS_SERVER_FQDN'),
                         ]) {
                         wrap([$class: 'AnsiColorBuildWrapper', colorMapName: "xterm"]) {
                             sh '''docker run -i \
                                   -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
                                   -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
                                   -e DWTOOLS_BRANCH="openldap-integration" \
                                   -e ELASTIC_IP=${DWTOOLS_ELASTIC_IP} \
                                   -e SERVER_FQDN=${DWTOOLS_SERVER_FQDN} \
                                   -e KEY_PAIR=dwtools \
                                   -e PEM_FILE=/opt/dwtools/dwtools.pem \
                                   -e DEBUG="-vv" \
                                   -v /opt/dwtools:/opt/dwtools \
                                   devopswise/dwtools-installer:latest "dwtools --launch" '''
                }
           }
       }
    }
    catch (err) {
        currentBuild.result = "FAILURE"
        throw err
    }
}
