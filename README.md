## Flugel CI/CD with Terratest


## Summary
 This project creates an EC2 instance and S3 bucket both having `Name=Flugel, Owner=Infrateam` tag. Terratest was used to test if the resources are properly tagged. Github Actions was used to validate, plan and test the terraform code when a pull request is created, and deploy the infrastructure when the pull request is merged 

## Infra Chart
![infra_chart](https://github.com/Bash-mocart/flugel/blob/main/flugel%20chart.png)  

## Requirements
* GoLang installed on your machine
* AWS Credentials properly configured in your local machine

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
}
```
Deleting above will allow terraform use your Local Machine to execute terraform commands and store its states.

1. Clone the repo
2. In your terminal, run `go mod init flugel` (flugel can be any name)
3. Next, run ` go mod tidy -go=1.16 && go mod tidy -go=1.17`
4. Next, run `go test -v`

Check the logs for the test results
