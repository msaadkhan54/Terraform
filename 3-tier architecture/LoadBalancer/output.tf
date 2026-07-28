output "lb-sg" {
  value = aws_security_group.lb-sg.id
}

output "target_group_arn" {
  value=aws_lb_target_group.lb-tg.arn
}