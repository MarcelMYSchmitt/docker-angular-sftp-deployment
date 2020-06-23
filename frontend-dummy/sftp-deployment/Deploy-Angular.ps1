Param(
    [Parameter()]
    [string]
    $SFTP_ADRESS,

    [Parameter()]
    [string]
    $USERNAME,

    [Parameter()]
    [string]
    $PASSWORD,

    [Parameter()]
    [string]
    $PORT,

    [Parameter()]
    [string]
    $PATH  
)

Write-Host "SFTP_ADRESS:" $SFTP_ADRESS
Write-Host "USERNAME:" $USERNAME
Write-Host "PORT:" $PORT
Write-Host "PATH:" $PATH


# first connect to provider via ssh for footprint 
Write-Host "Connection to: " $SFTP_ADRESS
sshpass -p $PASSWORD ssh -p $PORT $USERNAME@$SFTP_ADRESS -o StrictHostKeyChecking=no
exit 

# second connect to provia via lftp for file upload
lftp sftp://@SFTP_ADRESS -u $USERNAME -p $PORT

if (!$PATH) {
    Write-Host "Go to subfolder path."
    cd $PATH
}

# upload dist files to remote
mirror -R frontend
exit

# exit from container
exit