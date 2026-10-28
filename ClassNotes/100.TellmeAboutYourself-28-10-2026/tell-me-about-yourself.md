1. Short Intro about us
So, I am xyz working in xyz company from last 3 years as a Devsecops Consultant.
So my day to day to activities include Writing terraform code, write azure yaml pipelines, designing architecture diagram., troubleshooting productions issues.
So if you allow me I can expliain you the current project on which we are working..

2. Use Case
So currently I am working with an australian customer where the use case of the customer is they have multiple pertoleum refineries across australia, and in each refinery there are multiple rotating components like motors, and pumps. So if any one of the motor or pump in the refinery gets crashed or gets overheated then the problems is there is a big loss for the customer...

So for this customer we are building a dashboarding and alerting Applicaiton, So currently the customer have thier inhouse hardware team they have developed a industrial IOT device that is connected to all motors and pumps across refinery and it sends the metrics to the azure cloud in the Event Hub.

So our part starts from the data that is coming to evernt hub, So we have developed a 3 tier application that reads the data coming into the event hub and create a proper industrial dashboad and alertings options for the csuteomr.... So now if there is any motor that is having temperature more than 100Degree then the system automatically sends notification to that refinery operator. and the refinery operator shut downs the motor or take appropriate action to prevent any breakdown..

3. Project Details and Our Role
In the project, we have around 5 frontend develoeprs , 7 backend developers and 1 database guy...
and my role is a DevSecOps Enginer so I create the landing zones and have designed the Branching Strategy and the CICD pipeliens for the applicaiton.. including the complete terraform iac setup.

4. Landing Zone Explanation
Let me explain you the landing zone that we have designed for this applicaiton...
We have used application gateway as the entrypoint of the applicaiton.. where we have configured the SSL certificates and WAF. Behind the application gateway we have 2 frontend vms that are running the frontend code..

Behind the frontend vms, the frontend vms call the internal loadbalancer that load balance the traffic betwwen the 2 backend vms..
and we are using Azure Postgres flexible so we have connected the database to the subnet using private endpoints... and the backend application connected to the database using the private endpoints..

Also, We have one azure bastion in our vnet so we connect to all the vms securely using bastion, also we have keyvault to store the secrets..

5. Terraform and Terraform Pipeline Explaining
So to deploy this landing zone in the azure subscripiton we use terraform, the customer doenot have any contributor access to anyone in the company, everyone have reader acees to azure... all the deployments happen through terraform using a azure pipelines..

So let me explain our terraform repo structure, For terraform repo, we use trunk based branching strategy where all the code is present in main branch the the folder structure we follow is modular.. so we have a modules folder where we create all child modules for each resource in azure and we have environments folder where we call the child modules and create the tfvars files
and all the deployments that happen to azure goes via the azure pipleline that we have created which uses a service connection that we created by the customer, We do not have access to manage the service connections..

In our terraform pipeline we have multple stages like we do terraform scan where we run tfsec and tflint, in the plan stage we have terraform validate and plan where we also run infracost tool to get the cost so that we do not need to worry about unnecessay billing... and after the plan we have a manual approval and then terraform apply stage..

6. Application CICD pipeline explanation
Now, this was all about the infra and landing zone setup, We also manage the applicaiton pipelines where we have separate pipelines for frontend, backend and database...

In the frontend and backedn pipelines, We have configured stages like Sonarqube, and once the sonaqube is successul we build the applicaiton and upload the artifacts to the azure pipeline artifacts, then we have a deploystage that deploys the applicaiton to dev envirnoment and then we have manual approval and then qa environment and then again manual approval and then prod envionement... So we manage 3 environments for this applicaiton..

For for database we use liquibase in our pipeline so deploy the database changes...