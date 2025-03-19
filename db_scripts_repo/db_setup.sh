pipeline {
    agent any

    parameters {
        choice(name: 'TARGET_DB', choices: ['database_dev', 'database_qa', 'database_prod'], description: 'Select Target Database')
		choice(name: 'DB_HOST', choices: ['database-instance.c0fe60owuebl.us-east-1.rds.amazonaws.com', 'database-1.c0fe60owuebl.us-east-1.rds.amazonaws.com'], description: 'Select DB_HOST')
    }

    environment {
        DB_PORT = "5432"
        GIT_REPO = "https://github.com/valipireddyganesh2024/Helloworld.git"
        GIT_BRANCH = "master"
        SQL_FILE = "db_scripts_repo/schema_tables.sql"
        CLONE_DIR = "db_scripts_repo"
        ERROR_LOG = "error_log.txt"
    }

    stages {
        stage('Retrieve Credentials') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'rds-db-credentials', usernameVariable: 'DB_USER', passwordVariable: 'DB_PASS')]) {
                        echo "Database credentials retrieved successfully."
                    }
                }
            }
        }

        stage('Clone GitHub Repository') {
            steps {
                script {
                    echo "Cloning GitHub repository..."
                    sh "[ -d ${CLONE_DIR} ] && rm -rf ${CLONE_DIR} || echo 'No previous directory to remove'"
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
                    echo "Checking database connection to ${TARGET_DB}..."
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

        stage('Execute SQL in Target Database') {
            steps {
                script {
                    echo "Executing SQL script in ${TARGET_DB}"
                    def status = sh(
                        script: """
                            PGPASSWORD=${DB_PASS} psql -h ${DB_HOST} -U ${DB_USER} -p ${DB_PORT} -d ${TARGET_DB} -v ON_ERROR_STOP=0 -f ${CLONE_DIR}/${SQL_FILE} 2> ${ERROR_LOG}
                        """,
                        returnStatus: true
                    )

                    if (status != 0) {
                        echo "Some SQL statements failed. Review ${ERROR_LOG} for details."
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
            script {
                if (fileExists(ERROR_LOG)) {
                    echo "Displaying errors from ${ERROR_LOG}:"
                    sh "cat ${ERROR_LOG}"
                }
            }
        }
    }
}
