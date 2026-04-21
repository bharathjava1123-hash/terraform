data "aws_ami" "web" {

	owners = ["973714476881"] 
	
	filter {
		name   = "name"
		values = ["Redhat-9-DevOps-Practice"]
	}
	
	filter {
		name   = "root-device-type"
		values = ["ebs"]
	}

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    most_recent = true

}