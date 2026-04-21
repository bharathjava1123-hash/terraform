resource "aws_instance" "expense" {
    
    ami = data.aws_ami.web.id
    instance_type = "t3.micro"
    vpc_security_group_ids = [aws_security_group.allow_ssh_terraform.id]
    tags = merge(
        var.common_tags,
        {
        Name = "frontend"
        } 
    )

    provisioner "local-exec" {
        command = "echo ${self.public_ip} > public_ip.txt"
    }

    connection {
        type     = "ssh"
        user     = "ec2-user"
        password = "DevOps321"
        host     = self.public_ip
    }
   
    provisioner "remote-exec" {
        inline = [
            "sudo dnf install ansible -y",
            "sudo dnf install nginx -y",
            "sudo systemctl start nginx",
        ]
    }
    
    provisioner "remote-exec" {
        when    = destroy
        inline = [
            "sudo systemctl stop nginx",
        ]
    }

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

    ingress {
        from_port        = 80
        to_port          = 80
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

