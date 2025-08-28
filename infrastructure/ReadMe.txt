This repository has two pipelines:
- Terraform IaC located in /infrastructure.
- Jenkins CI/CD pipeline located in /cicd/


The IaC Terraform module will provision the following AWS infrastructure:
- VPC with CIDR 10.0.0.0/16.
- 4 Subnets (2 pubic + 2 Private)
    - Public subnets for Internet facing ALB.
    - Private Subnets for EC2 workloads.
- Internet Gateway attached to the VPC.
- NAT Gateway for internet access for the private EC2 instances.
- Two routing tables 
   - RT for public subnets with default route to Internet Gateway.
   - RT for private subnets with default route to NAT Gateway.
- Two EC2 instances (1 instance for Prod + 1 instance for testing)
- NSG has been configured with minimum rules.
- ALB Internet facing provisioned in the two public subnets with the following Targets:
    - Prod target contains the Prod EC2 instance.
    - Staging target contains the Test EC2 instance. (prfix: /staging)
- S3 private bucket.

To use this module, follow the below steps:
- Install Terraform binary (https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
- Create SSH keypairs named tf-key In N. Virginia region.
- Go to the root module and execute the following:
  $terraform init
  $terraform plan
  $terraform apply

Secrets Management:
- EC2 instance with IAM role has been used to provision the IaC and Pipeline.
- Jenkins credentials has been used to store GitHub access details.


The CICD will do the following:
- Monitor the GitHub repo for any changes.
- Once there is a code commit, then GitHub will trigger Jenkins vi the Webhook to run the 
CICD pipeline.
- CICD pipeline will do the following:
   - Create AWS ECS environment such as ECR cluster, Task definition, Service.
   - Pull the code.
   - Test the code.
   - Build the code.
   - Create docker image.
   - Push docker image into AWS ECR.
   - Deploy the App in Fargate.

Deployment & Rollback Strategy:
we will be using ALB Target Groups for Manual Blue/Green as the following:

1. Setup:

  - ALB has two Target Groups:
      -Blue TG → current stable version.
      - Green TG → new version (running in parallel).

  - Both target groups are registered under the same ALB Listener.

2. Gradual Traffic Shift (Manual):
   - Update the ALB Listener Rules → Weighted Target Groups:

aws elbv2 modify-listener \
  --listener-arn <listener-arn> \
  --default-actions Type=forward,ForwardConfig='{
    "TargetGroups":[
      {"TargetGroupArn":"<blue-tg-arn>","Weight":95},
      {"TargetGroupArn":"<green-tg-arn>","Weight":5}
    ]
  }'

- Start with 5% → 10% → 50% → 100%, checking metrics (CloudWatch, logs, APM) between steps.

3. Rollback (Easy):
  - If Green has issues, just switch traffic back to Blue TG:

     aws elbv2 modify-listener \
  --listener-arn <listener-arn> \
  --default-actions Type=forward,ForwardConfig='{
    "TargetGroups":[
      {"TargetGroupArn":"<blue-tg-arn>","Weight":100}
    ]
  }'

- Green containers stay alive (but idle), so you can debug them.


