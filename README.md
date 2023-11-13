# RoboAdvisor

## What it does and how it works
1) User gives a stock ticker symbol
2) The bot queries the Finnhub API and searches for articles, news, Tweets, etc about this company over the last 7 days and downloads them
3) It then converts the documents into smaller chunks, and uses LLM vector embeddings to convert the documents into a vector index DB, for easy querying
4) When the user asks (prompts) a question, a vector embedding of the query/prompt is calculated, and a similarity search of this prompt vector is performed against the vector index DB
5) The top 'k' chunks are retrieved according to the vector similarity search (in this particular case, I am using the FAISS algorithm to perform the similarity search)
6) The bot then queries the OpenAI GPT-3.5-Turbo API to query on those retrieved chunks, and returns a response.

In short, given a stock ticker symbol, this app uses GPT-3.5 to give investment outlook about it by reading articles, tweets and news about that company

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

## Steps for Kuberenetes deplolyment in GCP

1. gcloud services enable containerregistry.googleapis.com
2. docker build -t robo_advisor .
3. docker tag robo_advisor gcr.io/asom-barta-qna-bot/robo_advisor
4. docker push gcr.io/asom-barta-qna-bot/robo_advisor
5. Go to "container registry" and verify that the docker image is present
6. Go to 'Kubernetes Engine' in the Google Cloud Console and create a new Kubernetes cluster in Autopilot mode. Select a location in Asia. Wait for the k8s cluster to be created.
7. Once the cluster is created, create a deployment. Select the docker image from container registry, give a suitable name to the deployment.
8. Click on "Expose deployment as a new service", and set the port as 7860 (since the default port used by the Gradio app is 7860), and deploy.

It may appear like this at first:

![image](https://github.com/PrashantSaikia/RoboAdvisor/assets/39755678/164ef861-8689-44d5-8709-851c36f3bc8c)

But it just needs some time to allocate the resources. Check back after 10-15 mins, it should be all green and ready. After that, you can click on the endpoint link and use the app:

![image](https://github.com/PrashantSaikia/RoboAdvisor/assets/39755678/f0efb41f-3fe2-4e6e-9e26-f69febd7d9f4)

## UPDATE: Currently I've stopped running in GCP Kubernetes cluster to save costs

I have instead uploaded the Docker image in Docker Hub under the name `kristada673/roboadvisor`.

So, you can pull the image from there and run it locally:

```
docker pull kristada673/roboadvisor
docker run -p 8080:8080 kristada673/roboadvisor
```
