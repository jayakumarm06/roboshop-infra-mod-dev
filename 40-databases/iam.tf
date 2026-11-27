resource "aws_iam_role" "mysql" {
  name = "${var.project}-${var.environment}-mysql"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-mysql"
    }
  )
}
#mysql_root_password is ssm system managerr and  policy from iam 
resource "aws_iam_policy" "mysql" {
  name        = "${var.project}-${var.environment}-mysql"
  description = "IAM Policy to attach roboshop MYSQL instances "

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = templatefile("${path.module}/mysql-policy.json.tftpl",
    {
      account_id  = local.account_id
      project     = var.project
      environment = var.environment
  })
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-mysql"
    }
  )

}


resource "aws_iam_role_policy_attachment" "mysql" {
  role       = aws_iam_role.mysql.name
  policy_arn = aws_iam_policy.mysql.arn
}

# 3. Create the IAM Instance Profile (This links to the role)
resource "aws_iam_instance_profile" "mysql" {
  name = "${var.project}-${var.environment}-mysql"
  role = aws_iam_role.mysql.name
}

#rabbitmq

resource "aws_iam_role" "rabbitmq" {
  name = "${var.project}-${var.environment}-rabbitmq"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-rabbitmq"
    }
  )
}
#rabbitmq_password,rabbitmq_user is using system manager policy  from iam and create role
resource "aws_iam_policy" "rabbitmq" {
  name        = "${var.project}-${var.environment}-rabbitmq"
  description = "IAM Policy to attach roboshop rabbitmq instances "

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = templatefile("${path.module}/rabbitmq-policy.json.tftpl",
    {
      account_id  = local.account_id
      project     = var.project
      environment = var.environment
  })
  tags = merge(
    local.common_tags,
    {
      Name = "${var.project}-${var.environment}-rabbitmq"
    }
  )

}


resource "aws_iam_role_policy_attachment" "rabbitmq" {
  role       = aws_iam_role.rabbitmq.name
  policy_arn = aws_iam_policy.rabbitmq.arn
}

# 3. Create the IAM Instance Profile (This links to the role)
resource "aws_iam_instance_profile" "rabbitmq" {
  name = "${var.project}-${var.environment}-rabbitmq"
  role = aws_iam_role.rabbitmq.name
}

