# Deploying Ghost on AWS with Terraform

## Current deployment

The live demo can be seen at this location: [svg-map.org](http://svg-map.org)

## Resources created by the current scripts

- VPC with 10.3.0.0/16 cidr block
- 2 public networks for EC2 instances (could be private but then we need a NAT for internet)
- 2 private networks for the database
- security groups allowing web access and database access
- Route 53 hosted zone
- Route 53 failover routing policy with primary record targeting the ALB and a fake secondary target
- Auto Scaling Group with Launch Template (user_data will run a shell script to install Ghost)
- Aurora Serverless database
- Instance profile role that allows connection to the instances via SSM
- Secrets Manager secret for database username and password


## Terraform Commands

### Run the following commands to deploy the infrastructure

```
terraform init
terraform plan
terraform apply
```

## Building with AWS Codepipeline
buildspec.yaml can be used with Codebuild


### Author
Created by Laurentiu Morariu
September 2021
