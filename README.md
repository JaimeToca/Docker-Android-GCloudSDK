# Docker-Android-GCloudSDK

For more information [check this article on my website](https://www.jaimetoca.com/docker-firebase-testlab-gcloud/)

### Compile Dockerfile
Docker image with Android and Google Cloud SDK for Firebase Test Lab

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

### Enable required APIs
Now it’s time to create a service account with an “editor” role in the Google Cloud Platform and enable Google Cloud Testing API and Google Cloud Results API before you try to deploy anything. Later, in your Google Cloud Console go to “Credentials” > “Create Credentials” > “Create Service Account Key” and fill the data with the role “owner” and select key type as JSON.

## 3. Assemble you APKs and deploy
This is the repetitive task that ideally, you should automate in your CI with a script
* Generate both debug and Android test apks
```Bash
./gradlew :app:assembleDebug
./gradlew :app:assembleDebugAndroidTest
```
* Activate gcloud with the service account JSON
```Bash
gcloud auth activate-service-account -q --key-file myfile.json
```
* Pass the firebase project ID to Google Cloud
```Bash
gcloud config set project $FIREBASE_ID_PROJECT
```
* Upload APK's
```Bash
APK="--app=debug.apk --test=androidTest.apk"
TYPE="instrumentation"
DEVICES="--device model=Pixel3a,version=27,locale=en,orientation=portrait" 
RESULT_DIR="build-$BUILD_NUMBER"
gcloud firebase test android run $APK $DEVICES --type=$TYPE --results-dir=$RESULT_DIR/
```
* Once the execution is finished download test reports (I recommend you use [gsutil](https://cloud.google.com/storage/docs/gsutil)).
