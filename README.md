## Flugel CI/CD with Terratest


## Summary
 This project creates an EC2 instance and S3 bucket both having `Name=Flugel, Owner=Infrateam` tag. Terratest was used to test if the resources are properly tagged. Github Actions was used to validate, plan and test the terraform code when a pull request is created, and deploy the infrastructure when the pull request is merged 

## Infra Chart
![infra_chart](https://github.com/Bash-mocart/flugel/blob/main/flugel%20chart.png)  

## Requirements
* GoLang installed on your machine

## Steps to run and test the automation (Terratest)

1. Clone the repo
2. In your terminal, run `go mod init flugel` (flugel can be any name)
3. Next, run `go test -v`

Check the logs for the test results
