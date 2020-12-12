# AWS Lambda Slack Chat

[![terraform](https://img.shields.io/github/v/tag/amancevice/terraform-aws-slackbot-chat?color=62f&label=version&logo=terraform&style=flat-square)](https://registry.terraform.io/modules/amancevice/serverless-pypi/aws)
[![build](https://img.shields.io/github/workflow/status/amancevice/terraform-aws-slackbot-chat/Test?logo=github&style=flat-square)](https://github.com/amancevice/terraform-aws-slackbot-chat/actions)

Add-on for [amancevice/slackbot/aws](https://github.com/amancevice/terraform-aws-slackbot) terraform module to post messages to your Slack workspace via SNS

## Quickstart

```terraform
module "slackbot" {
  source      = "amancevice/slackbot/aws"
  version     = "~> 18.2"
  # …
}

module "slackbot_chat" {
  source  = "amancevice/slackbot-chat/aws"
  version = "~> 2.0"

  # Required

  lambda_function_name = "slack-chat-postMessage"
  lambda_role_arn      = module.slackbot.role.arn
  slack_secret_name    = module.slackbot.secret.name
  slack_topic_arn      = module.slackbot.topic.arn

  # Optional

  lambda_description = "Your Lambda description"
  lambda_kms_key_arn = "<kms-key-arn>"
  lambda_memory_size = 128
  lambda_timeout     = 3

  log_group_retention_in_days = 30

  slack_debug       = "slackend:*"
  slack_chat_method = "postMessage | postEphemeral"

  log_group_tags = {
    # …
  }

  lambda_tags = {
    # …
  }
}
```
