# AWS Lambda Slack Chat

Generic chat handler for Slack.

## Quickstart

```hcl
module slackbot {
  source      = "amancevice/slackbot/aws"
  version     = "~> 18.0"
  secret_name = "<secretsmanager-secret-name>"
  # ...
}

module slackbot_chat {
  source         = "amancevice/slackbot-chat/aws"
  version        = "~> 1.0"
  api_name       = module.slackbot.api.name
  chat_method    = "postMessage | postEphemeral"
  role_arn       = module.slackbot.role.arn
  secret_name    = "<secretsmanager-secret-name>"
  topic_arn      = module.slackbot.topic.arn
}
```
