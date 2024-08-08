#!/bin/bash

# Variables
CLUSTER_NAME="Devcluster"
SERVICE_NAME="web-app-service"
TASK_FAMILY="nodejs-todo-app"

# Fetch the latest stable revision
LATEST_TASK_DEF=$(aws ecs describe-task-definition --task-definition $TASK_FAMILY | jq -r '.taskDefinition.revision')

# Fetch the second last revision (assuming it's stable)
PREVIOUS_TASK_DEF=$(($LATEST_TASK_DEF - 1))

echo "Rolling back to previous task definition revision: $PREVIOUS_TASK_DEF"

# Update the service to use the previous task definition
aws ecs update-service --cluster $CLUSTER_NAME --service $SERVICE_NAME --task-definition $TASK_FAMILY:$PREVIOUS_TASK_DEF

echo "Rollback complete. The service has been updated to use task definition revision: $PREVIOUS_TASK_DEF"
