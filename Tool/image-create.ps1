$acrName = "modstestshared"
$arcLoginServer = "modstestshared.azurecr.io"
$imageFilePath = "C:\code\dotnet-docker\samples\aspnetapp"
$imageName = "xfsample"
$imageVersion = "v2"

docker build -t ${arcLoginServer}/${imageName}:${imageVersion} $imageFilePath
docker tag ${arcLoginServer}/${imageName}:${imageVersion} ${arcLoginServer}/${imageName}:latest
az acr login --name $acrName
docker push ${arcLoginServer}/${imageName}:${imageVersion}
docker push ${arcLoginServer}/${imageName}:latest
docker images
