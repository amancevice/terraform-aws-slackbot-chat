# AWS Lambda Slack Chat

Generic chat handler for Slack.

## Quickstart

```hcl
module slackbot_chat {
  source         = "amancevice/slack-chat/aws"
  version        = "~> 0.1"
  api_name       = "<api-gateway-rest-api-name>"
  lambda_handler = "index.postMessage | index.postEphemeral"
  role_name      = "<iam-role-name>"
  secret_name    = "<secretsmanager-secret-name>"
}
```
