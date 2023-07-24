Steps to replicate if running application in a docker container(TASK1a):
1. Install docker https://docs.docker.com/engine/install/ , verify by docker --version
2. Run command "docker build ." inside app directory, you can run with -t command to  tag  the image or we can tag it later using "docker tag <image_id> namespace/repository:tag". Get the image id by "docker image ls". Note: docker image is created using non-root user as per best practices.
3. We can now run the container using command: "docker run -p 8000:8000 <image_tag>"
4. Application will start running, verify by command "curl 127.0.0.1:8000", if you have curl installed, else browse this URL "127.0.0.1:8000". 
5. Post this, docker image was pushed to public repository for further steps.
   Image is available at https://hub.docker.com/layers/aayush303/p41-task/v1/images/sha256-c3beda1f11ad53630b6cb02eafa1fd589e6ef69f522e75a4df40fbdda9eb183d?context=repo

Further steps will be related to kubernetes configuration using our public image(TASK1b)
6. We would need to install kubectl: https://kubernetes.io/docs/tasks/tools/
7. Also, In order to replicate kubernetes features on my windows machine, I had installed  minikube. It can be installed easily from: https://minikube.sigs.k8s.io/docs/start/
8. Refer to "microservice.yml" in root directory. Simply running "kubectl -f      microservice.yml" will spin up 2 pods for our application. Verify by running following commands: 
"kubectl get pods"-- Will list the pods 
"kubectl get services" -- Will list our service
"kubectl get deployments" -- Will list our deployment
"minikube service <service_name>" -- will hit our get API, verify the response
Note: config file is pulling our publixc image for docker hub, make sure docker is configured for this.

Further steps will be related to terraform files and deployment related configuration to AWS(TASK2)
9. Install terraform using this link: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
10. Install and configure aws cli: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
11. Inside p41-infra, there are 2 files vpc.tf and eks.tf, first one creates a VPC with 2 subnets(public and private) while the second one creates an EKS cluster with a node group containing 2 nodes with machine type as t3a.large inside the private subnets created in the first step. 
12. We can test this configuration by running these commands step by step:
"terraform init"- install all the modules
"terraform plan"- List out the plan and resources to be created, updated, destroyed
"terraform apply"- All the resources will be created within ~15 minutes.
13. Verify by running:
"aws eks update-kubeconfig --region region-code --name my-cluster" --Kube config entry will be updated
"kubectl get nodes" -- will list 2 nodes which were created in the cluster


