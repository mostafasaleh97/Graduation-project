# Graduation-project
This is the the Infrastucture for my graduation project using the following command:
-Terraform
-ansible
-GCP
-Kubernates
-Docker
-Jenkins

The required task for my project:
Create private cluster with jenkins installed in it then using it to deploy backend app in another namespace(myapp) in the same cluster.
First:
I write my app and Dockerize it and upload all files and dockerfile and kubernates deployment files in the app repo with jenkins file that i would use in CICD.
At the first, I try to install jenkins in private cluster using ansible  by using dynamic inventory Iap tunneling but it give me more errors and I couldn't
complete this.
Seconde, I made public instance in the same neytwork of cluster to access it.
I made the instance public to enable me access it using ansible easily and install Jenkins in (devops-tool) namespace.

#Jenkins Section
I just wrote the jenkins file and upload kubernate config file as secret credentials then build a multipipline.
I upload all app file in main branch and configured jenkins to build it.

Finaly, I wrote kubectl get services -n myapp
and taked the external ip to access the app.
