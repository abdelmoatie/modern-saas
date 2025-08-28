This CICD will do the following:
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