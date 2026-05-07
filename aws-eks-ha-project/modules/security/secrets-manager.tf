resource "aws_secretsmanager_secret" "app_secret" {
  name = "${var.environment}-application-secret"

  tags = {
    Environment = var.environment
  }
}
