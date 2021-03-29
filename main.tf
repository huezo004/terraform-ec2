resource "aws_instance" "example" {
  ami                    =  "ami-0533f2ba8a1995cf9"
  instance_type          = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    Name = "Denyse-ec2-example"
  }
}