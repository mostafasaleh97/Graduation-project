# GCP-Project
create a private cluster has no access to internet and manage it using private instance in another private subnet with nat gatway in it.
This project is a very good challange for me as a devops engineer.
Tools used in this app:
-GCP
-Kubernate
-Python
-redis
-tornado
-terraform
-Docker
In this file, I will mention all steps I passed to complete this final task.

FIRST:
-I want to try the code locally so i download ir from this repo:https://github.com/atefhares/DevOps-Challenge-Demo-Code
-While trying to run the code it give me an error "Redis server isn't running. Exiting..." althought it was installed in the requirments file in the 
python project so I had to install it again and restart redis service and afer that tha app was running locally.
-Dockerizing the app using the python:3.9 image and it needed also to install redis again in the docker file.
Note:Docker file is attched to python app in the repo.

Second:
I started to build infrastucture using terraform and these are all reference links to build the infrastucture.
-Creating vpc:https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network
-creating subnets:https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork.
-creating nat and cloud router:https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat
-creating serviceaccounts:https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
-Attaching iam role to serviceaccount:https://stackoverflow.com/questions/61003081/how-to-properly-create-gcp-service-account-with-roles-in-terraform
-creating private-instance:https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
-creating private-cluster:https://thoeny.dev/create-a-private-gcp-kubernetes-cluster-using-terraform.

Finally:
I ssh to private instance and connect to private cluster and run deployment,service and ingress in it to manage to connect to app in 
pods throught a HTTP load balancer.

Note:All deployement files are found in a folder called deployement in repo.
