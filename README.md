# Docker-Android-GCloudSDK

For more information step by step [check this article on my website](https://www.jaimetoca.com/docker-firebase-testlab-gcloud/)

### Compile Dockerfile
**Important: The Docker image from this repository is deprecated, instead you should [use this one](https://github.com/thyrlian/AndroidSDK/blob/master/android-sdk/firebase-test-lab/Dockerfile)**

```Bash
#Compile image
docker build .  

#Deploy container and get interactive shell  
Docker images  
Docker run -d -p 5901:5901 -p 2222:22 <image_id>  
#Get interactive shell  
Docker exec -it <container-id> /bin/bash  
#Check everything is fine  
gcloud init  
```

