# Prepare Agular Code
FROM node:lts as prepare

WORKDIR /src
COPY package.json package-lock.json ./

RUN npm install 

# Build Angular Code
FROM prepare as build

COPY . /src
RUN npm run build-release 

# Prepare Scripts 
# Push Angular Code
FROM mcr.microsoft.com/powershell as runtime

# watchout build context in docker-compose.yml
COPY sftp-deployment/Deploy-Angular.ps1 Deploy-Angular.ps1

RUN apt-get update
RUN apt-get install --yes sshpass
RUN apt-get install --yes lftp

RUN mkdir frontend
COPY --from=build /src/dist frontend

CMD pwsh -File Deploy-Angular.ps1 -SFTP_ADRESS ${SFTP_ADRESS} -USERNAME ${USERNAME} -PASSWORD ${PASSWORD} -PORT ${PORT} - PATH ${$PATH)}