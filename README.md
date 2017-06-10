# BLESS

This repo contains the structure needed to:

- Deploy the BLESS CA as a Lambda Function
- Allow users in designated IAM groups to invoke it
- Sync users in designated IAM groups to EC2 instances (or any other Linux server that has the proper IAM permissions)
- Build an AMI that trusts the cert used by your BLESS lambda
