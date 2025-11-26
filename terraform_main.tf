provider "aws" {
  region = "ap-south-1"  # Mumbai
}

resource "aws_instance" "web" {
  ami           = "ami-xxxxxxxx"   # any valid Linux AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "demo-ec2"
  }
}


# How to explain in interview (very short):

# provider "aws" – tells Terraform we’re working with AWS and which region.

# resource "aws_instance" "web" – declares an EC2 instance named web.

# ami / instance_type – defines the OS image and size of the machine.

# tags – adds metadata to the instance (good for cost and management).

# Then I would say:
# “To use this, I’d run: terraform init, terraform plan, terraform apply.”