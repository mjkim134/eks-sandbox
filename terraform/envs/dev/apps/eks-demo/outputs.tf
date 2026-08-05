output "queue_arn" {
  value = module.sqs.queue_arn
}

output "dead_letter_queue_arn" {
  value = module.sqs.dead_letter_queue_arn
}