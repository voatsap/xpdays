#  Sample2. Creating ubuntu instance using set of files
  
1.  AMI selection moved to separate ami.tf
2.  Instance settings parametized by terraform variables
3.  Created variable files: terraform.tfvars, variables.tf
4.  Example for list element selection in *vpc_security_group_ids*
5.  Example for map element lookup in *instance_type*
6.  Add metadata variable count
```
# setup your AMS access parameters in ~/.aws

# Init terraform 
terraform init
# Create instance
terraform apply
```
