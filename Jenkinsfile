node('jenkins-python-slave') {
    currentBuild.result = "SUCCESS"
    try {
       stage('run cdt-installer'){
           withCredentials([string(credentialsId: 'AWS_ACCESS_KEY', variable: 'AWS_ACCESS_KEY_ID'),
                         string(credentialsId: 'AWS_SECRET_KEY', variable: 'AWS_SECRET_ACCESS_KEY'),
                         string(credentialsId: 'CDT_ELASTIC_IP', variable: 'CDT_ELASTIC_IP'),
                         string(credentialsId: 'CDT_SERVER_FQDN', variable: 'CDT_SERVER_FQDN'),
                         ]) {
                         wrap([$class: 'AnsiColorBuildWrapper', colorMapName: "xterm"]) {
                             sh '''docker run -i \
                                   -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
                                   -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
                                   -e AWS_INSTANCE_TYPE="t2.large" -e DO_NOT_PROVISION_EC2="true" \
                                   -e CDT_BRANCH="grafana" \
                                   -e CDT_PLAYBOOK="site.yml" \
                                   -e ELASTIC_IP=${CDT_ELASTIC_IP} \
                                   -e SERVER_FQDN=${CDT_SERVER_FQDN} \
                                   -e KEY_PAIR=dwtools \
                                   -e PEM_FILE=/opt/cdt/dwtools.pem \
                                   -e DEBUG="-vv" \
                                   -v /opt/source/cdt:/opt/cdt \
                                   devopswise/cdt-installer:latest "cdt --launch" '''
                }
           }
       }
    }
    catch (err) {
        currentBuild.result = "FAILURE"
        throw err
    }
}
