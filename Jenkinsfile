pipeline {
    agent any

    options {
        skipDefaultCheckout(true)
        timestamps()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Unit Test') {
            steps {
                sh '''
                    docker run --rm \
                      --env PIP_DISABLE_PIP_VERSION_CHECK=1 \
                      --env PIP_ROOT_USER_ACTION=ignore \
                      --volume "$WORKSPACE:/workspace" \
                      --workdir /workspace \
                      python:3.12-slim \
                      sh -c "pip install --quiet --no-cache-dir -r requirements.txt && python -m unittest discover -s tests -v"
                   '''
            }
        }
    }
}
