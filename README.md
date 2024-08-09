


![Github Action Architecture](https://github.com/user-attachments/assets/633bc406-2dda-4f0d-a4ca-54a34b778183)

Introduction:
CI/CD are parts of the DevOps process for![Github Action Architecture]
 delivering new software as soon as possible with help of automated test and automation build tools like Jenkins, GitHub-Actions.
Few benefits of implementing CI/CD in your organization:

Faster Delivery
Observability
Smaller Code Change
Easier Rollbacks
Reduce Costs
AWS Elastic Container Service it gives you a managed set of tools to run Docker containers over AWS maintained compute resources.
In this blog post, I will explain "how to Dockerize a flask hello-world application that takes a message from an env variable and pushes it to AWS ECR"

-Prerequisites
AWS Components
Identity and Access Management (IAM)
Elastic Container Registry (ECR)
Elastic Container Service (ECS)
Elastic Compute Cloud (EC2)

-Creating IAM users (console)
You can use the AWS Management Console to create IAM users.
Sign in to the AWS Management Console and open the IAM console
In the navigation pane, choose Users and then choose Add users
Type the user name for the new user. This is the sign-in name for AWS
Select the type of access the user will have. Programmatic access is enough.
Choose Next: Permissions
Tags is Optional, you can skip this
Now, Review to see all of the choices you made up to this point. When you are ready to proceed, choose Create user
To save the access keys, choose Download .csv and then save the file to a safe location

![Permision to USER](https://github.com/user-attachments/assets/0c8664a0-d4ad-4280-83f5-2633f2144c84)



-Elastic Container Registry (ECR)
Now we are going to create an image repository
Open the Amazon ECR console
Choose to Get Started
For Visibility settings, choose Private
For Repository name, specify a name for the repository
Choose to Create a repository

![private repo](https://github.com/user-attachments/assets/668b1467-a2e1-4aef-a00c-573734cc76a1)
-Elastic Container Service (ECS)
Components:

--Task definition
Cluster
Service
Create Task definition
A task definition is required to run Docker containers in Amazon ECS.
Let's create Task definition:

![cluster](https://github.com/user-attachments/assets/4a76f7df-2acc-4a72-8f1c-2570b014c003)


-Create Cluster
Open the Amazon ECS console
Choose EC2
In the navigation pane, choose Task Definitions, Create a new task definition.
For the Task definition family, specify a unique name for the task definition.
Assign a Task role, if don't have a Task role then skip it.
Container definitions, click on Add container. In container name add ECR repo name and at the place of Image add ECR repo URI link. And other details are shown below in the image
![cluster](https://github.com/user-attachments/assets/c60b6bb7-1465-4219-a163-0725c728e391)



Create Service
In Configure service, set Launch type (EC2), Service Name, and Number of tasks(1). For other options stay with default.

![Deploy service](https://github.com/user-attachments/assets/356223c4-4d09-4d94-984f-118d68904177)


-GitHub secrets
Now we are going to put our AWS credentials in GitHub secrets in the working repository.
Under your repository name, click Settings
In the left sidebar, click Secrets
Under Secrets, click on Actions
Now set New repository secret

For running our CI/CD we need task-definition, it is the requirement for the CI/CD pipeline with GitHub-actions.
Go to the Cluster, click on the “Tasks Definitions ” tab, and then open the running “Task”. Click on the “JSON” and copy all the JSON text and put into a .json file and push it on GitHub

-GitHub Actions
What is GitHub action?
GitHub Actions is a continuous integration and continuous delivery platform that allows you to automate your development workflow. GitHub Actions allows you to create, test, and deploy your code all from within GitHub in a fast, safe, and scalable manner. Every time you push, a build is immediately generated and executed, allowing you to quickly test each and every commit.
To know about gh-actions in detail: Click Here
GitHub-Actions Workflow:
Workflow is a configurable, automated process that we can use in our repository to build, test, package, release, or deploy your project. Workflows are made up of one or more “jobs" and can be triggered by GitHub events
Create your pipeline with Github Actions
On your GitHub repository select the Actions tab.
In search bar search for Deploy to Amazon ECS and configure it.

![Final Deployment](https://github.com/user-attachments/assets/9c985de4-8bdc-4c68-b3fa-43489db9f39a)


-Environment Variables:

AWS_REGION — Operating region of AWS services.
ECR_REPOSITORY — Name of the ECR repository that you have created.
ECS_SERVICE — Service name of the ECS Cluster.
ECS_CLUSTER — Name of the ECS Cluster.
ECS_TASK_DEFINITION — Path of the ECS task definition in JSON format which is stored in GitHub repository.
CONTAINER_NAME — Docker container name under the ECS task definition.

After setting all of this env's start committing the .yaml


![app](https://github.com/user-attachments/assets/67124238-a701-4d8f-8c85-9cf150a30d53)


Blog Link : https://akshayshinde9.hashnode.dev/cicd-pipeline-github-actions-with-aws-ecs
