data "sops_file" "secrets" {
  source_file = "secrets.enc.yaml"
}

resource "aws_ssm_parameter" "dev_slack_webhook" {
  name        = "/eks-sandbox/dev/alertmanager/slack-webhook"
  description = "Slack Webhook URL for Prometheus Alertmanager for Dev Environment"
  type        = "SecureString"
  key_id      = "alias/aws/ssm"
  value       = data.sops_file.secrets.data["dev_slack_webhook_url"]
}

resource "aws_ssm_parameter" "prod_slack_webhook" {
  name        = "/eks-sandbox/prod/alertmanager/slack-webhook"
  description = "Slack Webhook URL for Prometheus Alertmanager for Prod Environment"
  type        = "SecureString"
  key_id      = "alias/aws/ssm"
  value       = data.sops_file.secrets.data["prod_slack_webhook_url"]
}

resource "aws_ssm_parameter" "dev_grafana_admin_password" {
  name        = "/eks-sandbox/dev/grafana/admin-password"
  description = "Admin password for Grafana in Dev Environment"
  type        = "SecureString"
  key_id      = "alias/aws/ssm"
  value       = data.sops_file.secrets.data["dev_admin_password"]
}

resource "aws_ssm_parameter" "prod_grafana_admin_password" {
  name        = "/eks-sandbox/prod/grafana/admin-password"
  description = "Admin password for Grafana in Prod Environment"
  type        = "SecureString"
  key_id      = "alias/aws/ssm"
  value       = data.sops_file.secrets.data["prod_admin_password"]
}