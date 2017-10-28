# String
region = "eu-central-1"

# List
vpc_security_group_ids = [ "sg-84e649ed", "sg-90ea45fa" ]

# Map
instance_type = {
     production = "t2.micro"
     development = "m3.medium"
}

# Map of Lists
default_db_subnet_group_subnet_ids = {
     eu-central-1 = [ "subnet-f1e92d8a", "subnet-304b7f7a" ]
     eu-west-1 = [ "subnet-f1e92d8a", "subnet-304b7f7a"  ]
}

