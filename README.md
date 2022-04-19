## Flugel CI/CD with Terratest
## Objective
* A cluster of 2 EC2 instances behind an ALB running Nginx, serving a static file. This static file must be generated at boot, using a      Python script. Put the AWS instance tags in the file.
* The cluster must be deployed in a new VPC. This VPC must have only public subnets. Do not use default VPC
* Update the tests to validate the infrastructure. The test must check that files are reachable in the ALB.

## Overview
There are two branches, Main branch contains the EKS Cluster which is not needed for this project requirement for now, while EC2 branch contains the 2 EC2 instances behind an ALB. Check the Workflow results in the actions tab above, and pull requests in the pull requests tab.

## Stack
* AWS
* Python
* Terraform
* Docker
* Terratest
* Github Actions


## Summary
 This project creates an autoscaling group with 2 `EC2 instances and S3 bucket` both having `Name=Flugel, Owner=Infrateam` tag, an ALB behind the `Autoscaling Group`, `2 Public Subnets`, `Routing Table`, `Internet Gateway`, `Launch Template` e.t.c
 
 The 2 instances are both running `Nginx` serving a static file which is created at boot using `Python` script. `Terratest` is used to test if the static file is reacheable by hitting the `ALB` DNS hostname and  `Github Actions` was used to validate, and test the `Terraform` code when a pull request is created it plans the infrastructre changes, and deploy the infrastructure when the pull request is merged.

 I used `Launch Template` to configure an `Autoscaling Group` which will spin up `2 EC2 Instances`, I configured the Launch Templates to run commands that will create an `index.html` static file using `Python script`, and then ran `Docker Nginx Image` to serve the index.html static file. This way make sure that the file is only generated at the boot of the EC2 Instance. The index.html contains instance and s3 tags.  I then set up an `Application Load Balancer` with proper `Security Group` that will let me have access to the index.html file inside the EC2 nginx server. I also set up a terratest go file that automates the testing of the infrastructure and making sure the I can access the index.html file inside the EC2 instance making sure all the requirements for this project are met.

 For CI/CD, I set up `Github Actions` that formats, validates and test(using terratest) my Infrastructure. It also plan when a pull requests is created and deploy the infra when a pull request is merged. Seeing I already have an infrastructure in production from my previously merged pull request, I created a staging terraform workspace and a production `terraform workspace using terraform cloud`. The production workspace can only get triggered from this repository based on merge requests, just to make sure the Github Actions workflow must passed before deployment so as not to break anything in production and manage my terraform state intact.  


## Static File in the Nginx EC2 instance

![static file](https://github.com/Bash-mocart/flugel/blob/ec2/staticfile.png)  


## Infra Chart
![infra_chart](https://github.com/Bash-mocart/flugel/blob/ec2/flugel.png)  

## Requirements
* GoLang installed on your machine
* TerraformCLI installed on your machine
* AWS Credentials are properly configured in your Local Machine (Install AWSCLI and running `aws configure` to set up AWS Credentials) 

## Steps to run and test the automation (Terratest)

I used Terraform Cloud Workspaces to store the Terraform state files, to run the automation test, you either need to create your own terraform cloud organization and workspace and subtitute in `staging/provider.tf` `production/provider.tf` where necessary. or delete the backend configuration block in `staging/provider.tf` `production/provider.tf` e.g following block
```
backend "remote" {
    #          The name of your Terraform Cloud organization.
    organization = "flugel-infra"
    
    #         # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name = "flugel"
    }
  }
```
Deleting above will allow terraform use your Local Machine to execute terraform commands and store its states.

1. Clone the repo
2. In your terminal, run `go init mod flugel` (flugel can be any name)
3. Next, run `go mod tidy -go=1.16 && go mod tidy -go=1.17`
3. Next, run `go test -v`


Check the logs for the test results
