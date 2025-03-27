pipeline {
    agent any

    parameters {
        choice(name: 'DB_HOST', choices: ['database-1.c0fe60owuebl.us-east-1.rds.amazonaws.com', 'database-prod.c0fe60owuebl.us-east-1.rds.amazonaws.com'], description: 'Select the Database Host')
        choice(name: 'TARGET_DB', choices: ['database_qa', 'database_dev', 'database_prod'], description: 'Select the Target Database')
    }

    environment {
        DB_PORT = "5432"
        GIT_REPO = "https://github.com/valipireddyganesh2024/Helloworld.git"
        GIT_BRANCH = "master"
        CLONE_DIR = "db_scripts_repo"
    }

    stages {
        stage('Clone GitHub Repository') {
            steps {
                script {
                    echo "Cloning GitHub repository..."
                    sh "rm -rf ${CLONE_DIR}"
                    sh "git clone -b ${GIT_BRANCH} ${GIT_REPO} ${CLONE_DIR}"
                }
            }
        }

        stage('Find Latest SQL File for Today') {
            steps {
                script {
                    def todayDate = new Date().format('dd-MM-yyyy')
                    echo "Searching for today's SQL file: schema_tables_${todayDate}.sql"

                    def sqlFile = sh(script: """
                        find ${CLONE_DIR} -type f -name "schema_tables_${todayDate}.sql" | head -n 1
                    """, returnStdout: true).trim()

                    if (!sqlFile) {
                        error("No SQL file found for today's date: ${todayDate}. Stopping execution.")
                    }

                    echo "Using SQL file: ${sqlFile}"
                    env.SQL_FILE = sqlFile
                }
            }
        }

        stage('Check Database Connection') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'rds-db-credentials', usernameVariable: 'DB_USER', passwordVariable: 'DB_PASS')]) {
                    script {
                        echo "Checking database connection..."
                        def status = sh(
                            script: """
                                export PGPASSWORD=\$DB_PASS
                                psql -h ${params.DB_HOST} -U \$DB_USER -p ${DB_PORT} -d postgres -c "SELECT datname FROM pg_database;"
                            """,
                            returnStatus: true
                        )
                        if (status != 0) {
                            error("Database connection failed. Stopping execution.")
                        }
                        echo "Database is connected!"
                    }
                }
            }
        }

        stage('Execute SQL in Target Database') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'rds-db-credentials', usernameVariable: 'DB_USER', passwordVariable: 'DB_PASS')]) {
                    script {
                        echo "Executing SQL script in ${params.TARGET_DB} using file: ${env.SQL_FILE}"
                        def status = sh(
                            script: """
                                export PGPASSWORD=\$DB_PASS
                                psql -h ${params.DB_HOST} -U \$DB_USER -p ${DB_PORT} -d ${params.TARGET_DB} -f ${env.SQL_FILE}
                            """,
                            returnStatus: true
                        )
                        if (status != 0) {
                            error("Failed to execute SQL script: ${env.SQL_FILE}")
                        } else {
                            echo "Successfully executed ${env.SQL_FILE} in ${params.TARGET_DB}."
                        }
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
