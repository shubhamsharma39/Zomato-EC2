data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] 

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-*-24.04-amd64-server-*"]
  }
}

resource "aws_instance" "jenkins_ec2" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_all.id]
  user_data              = file("${path.module}/install_tools.sh")

  tags = {
    Name = "Zomato-Jenkins"
  }

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }
}
