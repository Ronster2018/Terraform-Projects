Provisioning ECR (Elastic Container Repository), Pushing Image to ECR, Provisioning ECS (Elastic Container Service), VPC (Virtual Private Cloud), ELB (Elastic Load Balancer), ECS Tasks and Service on Fargate Cluster

    This sample shows:
        how to create Flask-app Docker image,
        how to provision ECR and push to image to this ECR,
        how to provision VPC, Internet Gateway, Route Table, 3 Public Subnets,
        how to provision ALB (Application Load Balancer), Listener, Target Group,
        how to provision ECS Fargate Cluster, Task and Service (running container as Service).

There are 5 main parts:

    0_ecr.tf: includes private ECR code
    1_vpc.tf: includes VPC, IGW, Route Table, Subnets code
    2_ecs.tf: includes ECS Cluster, Task Definition, Role and Policy code
    3_elb.tf: includes to ALB, Listener, Target Group, Security Group code
    4_ecs_service.tf: includes ECS Fargate Service code with linking to loadbalancer, subnets, task definition.