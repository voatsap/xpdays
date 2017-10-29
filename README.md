## XPDays 2017 Building with Terraform code samples

The presentation could be found [here](https://docs.google.com/presentation/d/1ZYWxuzoPwWyzmrM-GJvCnP8DurLZqGRLg-xYMHO4JIw/edit?usp=sharing)

### Sample1. Creating Ubuntu instance using one file

1.  Init the Terrarorm
2.  Starting our first instance
3.  Terraform produce the state file *terraform.tfstate*

### Sample2. Creating ubuntu instance using set of files
  
1.  AMI selection moved to separate ami.tf
2.  Instance settings parametized by terraform variables
3.  Created variable files: *terraform.tfvars, variables.tf*
4.  Example for list element selection in *vpc_security_group_ids*
5.  Example for map element lookup in *instance_type*
6.  Add metadata variable count

### Sample3. Deploy a sample application, using RDS
  
1.  Build custom image using packer. Build/redeploy workflow
2.  Deploy a sample application using *user_data*
3.  Create RDS MySQL database, pass db endpoint to application
4.  Adding outputs

### Sample4. Using funtions and count hints
  
1.  Moving deployment script into temlplate provider
2.  Using *length()* function to get size and create multiple resources

### Sample5. Scaling our applications, adding scaling policies
  
1.  Add IAM profile for instance
2.  Creating launch configuration, autoscaling grops
3.  Building module
4.  Dealing with LoadBalancers and http

### AppendixA.  Upgrading applications environment
1.  Blue/Green deployment
2.  Cannary upgrade
