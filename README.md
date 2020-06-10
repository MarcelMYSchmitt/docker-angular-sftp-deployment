# Introduction

This project contains a simple dummy frontend angular application. Its purpose is to show how you can build the project and deploy it to any SFTP server, depending on the information you give in the docker-compose or env file.  

You can find everything concerning the deployment inside the Deploy-Angular.ps1 script. It's a powershell script in which we are using sshpass and lftp for getting an initial footprint of the server and uploading the compiled angular code. The tools we are using are installed inside the docker container via the dockerfile.  

## Folder structure

**frontend-dummy**  
frontend-dummy contains all application and deployment specific code. Within the folder you can find the source code for the angular application, the Dockerfile for running the frontend in a docker container or the deployment files for a sftp server.

Inside the frontend-dummy folder there is a 'nginx' folder where you can find the nginx configuration file. We are using NGINX as web server for running the frontend in a docker container. In 'stfp-deployment' you find a Dockerfile and Powershell script which we use for the deployment. The difference between the Dockerfile inside the sftp-deployment folder and the Dockerfile inside the frontend-dummy folder (one level above) is that the sftp secific file is not to be used as running application container, it's just for the deployment itself -> Deployment as Code. 


**docker-compose.yml and .env files**  
You can build the Dockerfiles separately or you use the docker-compose.yml which you can find on the same level as the frontend-dummy folder. 

The deployment script needs information about the STFP Server adress, the server port and also the user name such as the user password for login. Normally you do not place these information inside a docker-compose. If you want you can change the docker-compose file, if not please create a .env file with following syntax and information.

Content of .env file  
```
# login address from hoster
SFTP_ADRESS=*replace_me*  
# url from website
USERNAME=*replace_me*
# password for accessing website  
PASSWORD=*replace_me*   
# port address from hoster
PORT=*replace_me*
# optional: if you have your code inside subfolders you can give the path as parameter like 'abc/def/frontend-dummy'
PATH=*replace_me*
```

## How to run

As said above you can use the docker-compose or the specific Dockerfiles (running or deployment Dockerfile).
Due to context issues please run the commands for the Dockerfiles also on the same level as the docker-compose file. 

**docker-compose.yml**  
Run frontend-dummy application in docker container:   
`docker-compose up frontend-dummy`  

Run frontend-dummy-deployment in docker container:  
 `docker-compose up frontend-dummy-deployment`

**Dockerfiles**
Build and run frontend-dummy:  
`docker build -t frontend-dummy frontend-dummy/.`  
`docker run -p 4444:80 frontend-dummy`

Build and run frontend-dummy-deployment:   
`docker build -t frontend-dummy-deployment frontend-dummy/sftp-deployment/.`    
`docker run frontend-dummy-deployment`