# AWS Lambda Slack Chat

[![terraform](https://img.shields.io/github/v/tag/amancevice/terraform-aws-slackbot-chat?color=62f&label=version&logo=terraform&style=flat-square)](https://registry.terraform.io/modules/amancevice/serverless-pypi/aws)
[![build](https://img.shields.io/github/workflow/status/amancevice/terraform-aws-slackbot-chat/Test?logo=github&style=flat-square)](https://github.com/amancevice/terraform-aws-slackbot-chat/actions)

Generic chat handler for Slack.

## Quickstart

```hcl
module slackbot {
  source      = "amancevice/slackbot/aws"
  version     = "~> 18.1"
  secret_name = "<secretsmanager-secret-name>"
  # ...
}

module slackbot_chat {
  source         = "amancevice/slackbot-chat/aws"
  version        = "~> 1.1"
  api_name       = module.slackbot.api.name
  chat_method    = "postMessage | postEphemeral"
  role_arn       = module.slackbot.role.arn
  secret_name    = "<secretsmanager-secret-name>"
  topic_arn      = module.slackbot.topic.arn
}
```
