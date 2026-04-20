resource "aws_instance" "expense" {
    count = length(var.instance_names)
    ami = data.aws_ami.web.id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
    tags = merge(
        var.common_tags,
        {
        Name = var.instance_names[count.index]
        } 
    )

}

resource "aws_security_group" "allow_ssh_terraform" {
    name        = "allow_ssh"
    description = "Allow port number 22 for SSH access"

    # usually we allow everything in egress
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    ingress {
        from_port        = var.port
        to_port          = var.port
        protocol         = var.protocol
        cidr_blocks      = ["0.0.0.0/0"] #allow from everyone
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = merge(
        var.common_tags,
        {
        Name = var.allow_ssh
        } 
    )

}

