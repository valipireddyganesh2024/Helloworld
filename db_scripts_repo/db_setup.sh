#!/bin/bash

# Database Configuration
DB_HOST="database-dev.c0fe60owuebl.us-east-1.rds.amazonaws.com"
DB_PORT="5432"
DB_USER="postgres"
DB_PASS="postgres123"

# List of databases
DATABASES=("database_qa")

# GitHub repository details
GIT_REPO="https://github.com/valipireddyganesh2024/Helloworld.git"
GIT_BRANCH="master"
SQL_FILE="db_scripts_repo/schema_tables.sql"  # Change this if your SQL file has a different name
CLONE_DIR="db_scripts_repo"

# Log files
LOG_FILE="db_setup.log"
FAILED_SCRIPTS="failed_scripts.log"

# Clone GitHub repository and fetch latest SQL script
fetch_sql_script() {
    echo "Cloning GitHub repository..."
    
    # Remove existing directory if it exists
    rm -rf $CLONE_DIR

    # Clone the repo
    git clone -b $GIT_BRANCH $GIT_REPO $CLONE_DIR

    if [ $? -ne 0 ]; then
        echo "Failed to clone GitHub repository. Stopping execution."
        exit 1
    fi
    
    # Check if the SQL file exists
    if [ ! -f "$CLONE_DIR/$SQL_FILE" ]; then
        echo "SQL file not found in repository. Stopping execution."
        exit 1
    fi
}

# Function to check database connection
check_db_connection() {
    echo "Checking database connection..."
    PGPASSWORD=$DB_PASS psql -h $DB_HOST -U $DB_USER -p $DB_PORT -d postgres -c "SELECT 'DB is connected';" &>/dev/null

    if [ $? -ne 0 ]; then
        echo "Database connection failed. Stopping execution."
        exit 1
    else
        echo "Database is connected!"
    fi
}

# Function to execute schema and table SQL file
execute_sql_file() {
    local db_name=$1
    echo "Processing database: $db_name"

    # Run the SQL script from GitHub repo
    PGPASSWORD=$DB_PASS psql -h $DB_HOST -U $DB_USER -p $DB_PORT -d $db_name -f "$CLONE_DIR/$SQL_FILE" &>> $LOG_FILE

    if [ $? -ne 0 ]; then
        echo "Failed to execute scripts for database: $db_name" | tee -a $FAILED_SCRIPTS
    else
        echo "Successfully created schemas and tables in database: $db_name"
    fi
}

# Main Execution
fetch_sql_script
check_db_connection

# Process each database
for db in "${DATABASES[@]}"; do
    execute_sql_file $db
done

echo "Pipeline execution completed!"
echo "Check '$FAILED_SCRIPTS' for any failed scripts."
