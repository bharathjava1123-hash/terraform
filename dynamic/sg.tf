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

    dynamic "ingress" {
        for_each = var.ingress_rules
        content{
        from_port        = ingress.value["from_port"]
        to_port          = ingress.value["to_port"]
        protocol         = ingress.value["protocol"]
        cidr_blocks      = ingress.value["cidr_blocks"]
        ipv6_cidr_blocks = ["::/0"]
        }
    }

    tags = merge(
        var.common_tags,
        {
        Name = var.allow_ssh
        } 
    )

}