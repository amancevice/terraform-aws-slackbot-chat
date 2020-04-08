terraform {
  required_version = ">= 0.12.0"

  required_providers {
    aws = ">= 2.7.0"
  }
}

locals {
  api_name                    = var.api_name
  chat_method                 = var.chat_method
  debug                       = var.debug
  kms_key_arn                 = var.kms_key_arn
  lambda_description          = coalesce(var.lambda_description, "Slack handler for slack.chat.${local.chat_method}")
  lambda_function_name        = coalesce(var.lambda_function_name, "slack-${var.api_name}-chat-${local.chat_method}")
  lambda_handler              = "index.${local.chat_method}"
  lambda_memory_size          = var.lambda_memory_size
  lambda_tags                 = var.lambda_tags
  lambda_timeout              = var.lambda_timeout
  log_group_retention_in_days = var.log_group_retention_in_days
  log_group_tags              = var.log_group_tags
  role_arn                    = var.role_arn
  secret_name                 = var.secret_name
  topic_arn                   = var.topic_arn

  filter_policy = {
    id   = [local.chat_method]
    type = ["chat"]
  }
}

resource aws_cloudwatch_log_group logs {
  name              = "/aws/lambda/${aws_lambda_function.lambda.function_name}"
  retention_in_days = local.log_group_retention_in_days
  tags              = local.log_group_tags
}

resource aws_lambda_function lambda {
  description      = local.lambda_description
  filename         = "${path.module}/package.zip"
  function_name    = local.lambda_function_name
  handler          = local.lambda_handler
  kms_key_arn      = local.kms_key_arn
  memory_size      = local.lambda_memory_size
  role             = local.role_arn
  runtime          = "nodejs12.x"
  source_code_hash = filebase64sha256("${path.module}/package.zip")
  tags             = local.lambda_tags
  timeout          = local.lambda_timeout

  environment {
    variables = {
      AWS_SECRET = local.secret_name
      DEBUG      = local.debug
    }
  }
}

resource aws_lambda_permission invoke {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = local.topic_arn
}

resource aws_sns_topic_subscription subscription {
  endpoint      = aws_lambda_function.lambda.arn
  filter_policy = jsonencode(local.filter_policy)
  protocol      = "lambda"
  topic_arn     = local.topic_arn
}
