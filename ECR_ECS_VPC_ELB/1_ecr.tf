# Creating the Elastic Container Repo for the application
resource "aws_ecr_repository" "flask_app" {
  name = "flask-app"
}

#Linux: aws ecr get-login-password --region REGION | docker login --username AWS --password-stdin ID.dkr.ecr.REGION.amazonaws.com

# Windows: (Get-ECRLoginCommand).Password | docker login --username AWS --password-stdin ID.dkr.ecr.REGION.amazonaws.com
# docker build -t flask-app .
# docker tag flask-app:latest ID.dkr.REGION.amazonaws.com/flask-app:latest
# docker push ID.dkr.REGION.amazonaws.com/flask-app:latest
