resource "aws_instance" "example" {
  ami                    =  "ami-0533f2ba8a1995cf9"
  instance_type          = "t2.micro"

  vpc_security_group_ids = [aws_security_group.SGDenyseEC2.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "Denyse-ec2-example"
  }
}


resource "aws_security_group" "SGDenyseEC2" {
  name = "terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value       = aws_instance.example.public_ip
  description = "The public IP address of the web server"
}