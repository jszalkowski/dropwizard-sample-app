provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region = "eu-central-1"
}

resource "aws_security_group" "sample-app" {
    name = "${var.name}-devops-jumpstart-sample-app"
    description = "Security group for web that allows web traffic from internet"

    ingress {
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port   = 22
        protocol  = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_instance" "sample-app" {
    instance_type = "t2.small"
    ami = "${var.ami}"
    key_name = "devops-jumpstart"
    security_groups = ["${aws_security_group.sample-app.name}"]

    tags {
      Name = "${var.name} devops-jumpstart sample-app"
    }
}

output "ip" {
    value = "${aws_instance.sample-app.public_ip}"
}