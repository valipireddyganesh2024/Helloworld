pipeline {
    agent any

    environment {
        DB_HOST = "${DB_HOST}"
        DB_PORT = "${DB_PORT}"
        DB_USER = "${DB_USER}"
        DB_PASS = "${DB_PASS}"
        TARGET_DB = "${TARGET_DB}"
        GIT_REPO = "${GIT_REPO}"
        GIT_BRANCH = "${GIT_BRANCH}"
        SQL_FILE = "${SQL_FILE}"
        CLONE_DIR = "${CLONE_DIR}"
    }

    stages {
        stage('Clone GitHub Repository') {
            steps {
                script {
                    echo "Cloning GitHub repository..."
                    sh "rm -rf ${CLONE_DIR}"
                    sh "git clone -b ${GIT_BRANCH} ${GIT_REPO} ${CLONE_DIR}"
                    if (!fileExists("${CLONE_DIR}/${SQL_FILE}")) {
                        error("SQL file not found in repository. Stopping execution.")
                    }
                }
            }
        }

        stage('Check Database Connection') {
            steps {
                script {
                    echo "Checking database connection..."
                    def status = sh(
                        script: "PGPASSWORD=${DB_PASS} psql -h ${DB_HOST} -U ${DB_USER} -p ${DB_PORT} -d postgres -c \"SELECT datname FROM pg_database;\"",
                        returnStatus: true
                    )
                    if (status != 0) {
                        error("Database connection failed. Stopping execution.")
                    }
                    echo "Database is connected!"
                }
            }
        }

        stage('Execute SQL in ${TARGET_DB}') {
            steps {
                script {
                    echo "Executing SQL script in ${TARGET_DB}"
                    def status = sh(
                        script: "PGPASSWORD=${DB_PASS} psql -h ${DB_HOST} -U ${DB_USER} -p ${DB_PORT} -d ${TARGET_DB} -f ${CLONE_DIR}/${SQL_FILE}",
                        returnStatus: true
                    )
                    if (status != 0) {
                        error("Failed to execute scripts in ${TARGET_DB}.")
                    } else {
                        echo "Successfully executed schemas and tables in ${TARGET_DB}."
                    }
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed!"
        }
    }
}
	
