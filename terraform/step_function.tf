resource "aws_sfn_state_machine" "main" {
  name       = "${var.prefix}-state-machine"
  role_arn   = aws_iam_role.state_machine_assume_role.arn
  definition = file("${path.module}/../definitions/${var.definition_file_path}")
}

# IAM role for Step Functions with no policy
resource "aws_iam_role" "state_machine_assume_role" {
  name = "${var.prefix}-dfa-state-machine-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "states.amazonaws.com"
        }
      }
    ]
  })
}
