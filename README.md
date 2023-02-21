This is the Infrastructure for my graduation project using the following command: 
-Terraform 
-ansible 
-GCP 
-Kubernetes 
-Docker 
-Jenkins

The required task for my project: Create a private cluster with Jenkins installed in it then use it to deploy the backend app in another namespace(myapp) in the same cluster. First: I write my app and Dockerize it and upload all files and docker files and Kubernetes deployment files in the app repo with the Jenkins file that I would use in CICD. At the first, I try to install Jenkins in the private cluster using ansible by using dynamic inventory Iap tunneling but it give me more errors and I couldn't complete this. Second, I made a public instance in the same network of clusters to access it. I made the instance public to enable me to access it using ansible easily and install Jenkins in (DevOps-tool) namespace.

#Jenkins Section I just wrote the Jenkins file and upload the Kubernetes config file as secret credentials then build a multi-pipeline. I upload all app files to the main branch and configured Jenkins to build it.

Finally, I wrote kubectl get services -n myapp and take the external IP to access the app.
