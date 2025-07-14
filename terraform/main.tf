provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "existing" {
  # Placeholder configuration – must match existing instance
  ami                         = "ami-042b4708b1d05f512"   # Must match your instance
  instance_type               = "t3.micro"                # Must match
  availability_zone           = "eu-north-1c"              # Must match
  associate_public_ip_address = true

  tags = {
    Name = "FlaskApp"
  }

  # Skip creation (used for import)
  lifecycle {
    prevent_destroy = true
  }
}

