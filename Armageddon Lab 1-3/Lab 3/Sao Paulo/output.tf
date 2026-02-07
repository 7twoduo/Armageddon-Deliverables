#                            Output Blocks
# Explanation: These outputs prove Chewbacca built private hyperspace lanes (endpoints) instead of public chaos.
output "star_vpce_ssm_id" {
  value = aws_vpc_endpoint.ssm.id
}

output "star_vpce_logs_id" {
  value = aws_vpc_endpoint.logs.id
}

output "star_vpce_secrets_id" {
  value = aws_vpc_endpoint.secrets_manager.id
}

output "star_vpce_s3_id" {
  value = aws_vpc_endpoint.s3_gateway_endpoint.id
}

# Can't extract Instance Id, I did an autoscaling group

output "chewbacca_alb_dns_name" {
  value = aws_lb.hidden_alb.dns_name
}

output "chewbacca_app_fqdn" {
  value = "${var.app_subdomain}.${var.root_domain_name}"
}

output "chewbacca_target_group_arn" {
  value = aws_lb_target_group.hidden_target_group.arn
}

output "chewbacca_acm_cert_arn" {
  value = aws_acm_certificate.hidden_target_group2.arn
}

output "chewbacca_waf_arn" {
  value = var.enable_waf ? aws_wafv2_web_acl.alb_waf[0].arn : null
}

output "chewbacca_dashboard_name" {
  value = aws_cloudwatch_dashboard.chewbacca_dashboard01.dashboard_name
}



output "vpc_cidr" {
  value = aws_vpc.Star.cidr_block
}
output "region" {
  value = data.aws_region.current.region
}
output "ami" {
  value = data.aws_ami.amazon_linux.id
}

#####################################################################################################################
#                                           Outputs
#####################################################################################################################

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = var.enable_cloudfront ? aws_cloudfront_distribution.main[0].id : null
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = var.enable_cloudfront ? aws_cloudfront_distribution.main[0].domain_name : null
}