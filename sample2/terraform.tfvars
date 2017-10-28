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
vpc_security_group_ids_map = {
     eu-central-1 = [ "sg-84e649ed", "sg-90ea45fa" ]
     eu-west-1 = [ "sg-1d4ab664", "sg-90ea45fa" ]
}

