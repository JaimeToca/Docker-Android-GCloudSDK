FROM thyrlian/Android-sdk-vnc: latest

LABEL maintainer "jaime.toca.munoz@gmail.com"

RUN sdkmanager "tools" "platform-tools"

RUN yes | sdkmanager --update --channel=3

#Modify this as you want. You could even remove it, and pass these dependencies as external volume
#https://www.jaimetoca.com/docker-android-espresso-unit-test/
RUN yes | sdkmanager \
    "platforms;Android-28" \
    "build-tools;28.0.3" \
    "extras;google;m2repository" \
    "extras;google;google_play_services" \
    "extras;m2repository;com;Android;support;constraint;constraint-layout;1.0.2" \
    "extras;m2repository;com;Android;support;constraint;constraint-layout;1.0.1" \
    "add-ons;addon-google_apis-google-23" \
    "add-ons;addon-google_apis-google-22" \
    "add-ons;addon-google_apis-google-21"


#GCLOUD DEPENDENCIES

#Make sure you have apt-transport-https, certificates, and curl installed
RUN yes | apt-get install apt-transport-https ca-certificates GnuPG curl

#Install packages for gcloud
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && apt-get update -y && apt-get install google-cloud-sdk -y

ENV GCLOUD_SDK_CONFIG /usr/lib/google-cloud-sdk/lib/googlecloudsdk/core/config.json

#Disable updater check for the installation.
RUN /usr/bin/gcloud config set --installation component_manager/disable_update_check true \
&& /usr/bin/gcloud config set --installation core/disable_usage_reporting true

#Change the JSON for future updates
RUN sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' $GCLOUD_SDK_CONFIG \
&& sed -i -- 's/\"disable_usage_reporting\": false/\"disable_usage_reporting\": true/g' $GCLOUD_SDK_CONFIG
