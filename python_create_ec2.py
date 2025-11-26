import boto3

def create_ec2_instance():
    ec2 = boto3.resource('ec2', region_name='ap-south-1')

    instance = ec2.create_instances(
        ImageId='ami-0c55b159cbfafe1f0',  # Example Amazon Linux 2 AMI (Mumbai)
        InstanceType='t2.micro',
        MinCount=1,
        MaxCount=1,
        KeyName='my-keypair',             # Replace with your key pair
        TagSpecifications=[
            {
                'ResourceType': 'instance',
                'Tags': [{'Key': 'Name', 'Value': 'MyPythonEC2'}]
            }
        ]
    )

    print("EC2 Instance Created! ID:", instance[0].id)

if __name__ == "__main__":
    create_ec2_instance()
