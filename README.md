# RoboAdvisor

## Steps to install Ta-Lib in Linux

```
wget http://prdownloads.sourceforge.net/ta-lib/ta-lib-0.4.0-src.tar.gz
tar -xzf ta-lib-0.4.0-src.tar.gz
cd ta-lib/
./configure --prefix=/usr
make
sudo make install
pip install ta-lib
```
Run `pip install -r requirements.txt` only after install Ta-Lib correctly.

## Steps for Kuberenetes deplolyment is GCP

1. docker build -t robo_advisor .
2. docker tag robo_advisor gcr.io/asom-barta-qna-bot/robo_advisor
3. docker push gcr.io/asom-barta-qna-bot/robo_advisor
4. Go to "container registry" and verify that the docker image is present
5. Go to 'Kubernetes Engine' in the Google Cloud Console and create a new Kubernetes cluster in Autopilot mode. Select a location in Asia. Wait for the k8s cluster to be created.
6. Once the cluster is created, create a deployment. Select the docker image from container registry, give a suitable name to the deployment.
7. Click on "Expose deployment as a new service", and set the port as 7860 (since the default port used by the Gradio app is 7860), and deploy.

It may appear like this at first:

![image](https://github.com/PrashantSaikia/RoboAdvisor/assets/39755678/164ef861-8689-44d5-8709-851c36f3bc8c)

But it just needs some time to allocate the resources. Check back after 10-15 mins, it should be all green and ready.
