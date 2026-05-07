resource "aws_wafv2_web_acl" "main" {
  name  = "eks-waf"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "eksWaf"
    sampled_requests_enabled   = true
  }
}
