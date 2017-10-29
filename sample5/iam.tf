## Define a policy to RO
resource "aws_iam_policy" "ec2-ro-policy" {
    name        = "ec2-ro-policy"
    path        = "/"
    description = "Autocreated Policy to read tags from ec2 instance"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1506366968000",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:DescribeTags"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

## STS AssumeRole Data
data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
  actions = ["sts:AssumeRole"]
      principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
                  }
     }
}

## Add EC2 instance role
resource "aws_iam_role" "ec2-instance-role" {
     name               = "ec2-instance-role"
     path               = "/"
     assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy.json}"
      }

## Attach policy to role
resource "aws_iam_policy_attachment" "ec2-policy-attachemnt" {
    name       = "ec2-policy-attachemnt"
    roles      = ["${aws_iam_role.ec2-instance-role.name}"]
    policy_arn = "${aws_iam_policy.ec2-ro-policy.arn}"
  }

## Create instance profile and attah the role
resource "aws_iam_instance_profile" "ec2-instance-profile" {
          name  = "ec2-instance-profile"
          role = "${aws_iam_role.ec2-instance-role.name}"
}

