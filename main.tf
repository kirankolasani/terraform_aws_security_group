resource "aws_security_group" "main" {
  name = var.project_name
  description = "Allowing all ports"
  vpc_id = var.vpc_id
  tags = merge(
    {
        Name = "${var.project_name}-${var.env}"
    },
    var.common_tags
  )

  dynamic ingress {
    for_each = var.ingress_rules
    content {
        description      = ingress.value.description
        from_port        = ingress.value.from_port
        to_port          = ingress.value.to_port
        protocol         = ingress.value.protocol
        cidr_blocks      = ingress.value.cidr_blocks
    }
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}