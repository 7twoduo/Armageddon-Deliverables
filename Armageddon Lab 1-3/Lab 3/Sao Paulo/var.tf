#                                           Local Blocks
locals {
  EC2_SG_Traffic = aws_security_group.EC2_SG.id


  ec2_ami_local = data.aws_ami.amazon_linux.id
  vpc_id        = aws_vpc.Star.id
  account_id    = data.aws_caller_identity.current.account_id
  name_prefix   = var.Environment
  Environment   = aws_vpc.Star.tags["Name"]


}
#                                           Variable Blocks

#                         Regions
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "sa-east-1"
}
variable "aws_region2" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}
variable "secret_region"{
  description = "This Is the Aws region for the secret"
  type = string
  default = "ap-northeast-1"
}
#                         VPC
variable "Environment" {
  description = "VPC ID, this is best to be a locals variable"
  type        = string
  default     = "star" #lower case is just better when writing code Remember that!!!!!!
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.200.0.0/16"
}
# Self Explanatory
variable "public_access_cidr" {
  description = "The CIDR block for public access"
  type        = string
  default     = "0.0.0.0/0"
}
#                         Subnets
variable "public_subnet" {
  description = "The subnet deploys resources with public ips."
  type        = bool
  default     = true
}
variable "private_subnet" {
  description = "The subnet deploys resources without public ips, making them private."
  type        = bool
  default     = false
}
#                         Subnet Cidrs
variable "public_subnet_cidr1" {
  description = "The CIDR block for the first public subnet."
  type        = string
  default     = "10.200.1.0/24"
}
variable "public_subnet_cidr2" {
  description = "The CIDR block for the second public subnet."
  type        = string
  default     = "10.200.2.0/24"
}
variable "private_subnet_cidr1" {
  description = "The CIDR block for the first private subnet."
  type        = string
  default     = "10.200.11.0/24"
}
variable "private_subnet_cidr2" {
  description = "The CIDR block for the second private subnet."
  type        = string
  default     = "10.200.12.0/24"
}

#                   Database
variable "db_username" {
  description = "The username for the RDS database"
  type        = string
  default     = "admin"
}

#          Secrets Manager and Parameter Store
variable "secret_location" {
  description = "The location in Secrets Manager to store the RDS credentials"
  type        = string
  default     = "lab/rds/mysqv17"
}
variable "parameter_location" {
  description = "The location in Parameter Store for some RDS details"
  type        = string
  default     = "/lab/db/"
}
#            SNS Email
variable "sns_email" {
  description = "Put Your email below"
  type        = string
  default     = "markedsync@gmail.com"
  #Remember you have to confirm your subscription for this to work
}
#                S3 Access
variable "s3_bucket_no_access" {
  description = "No public access to bucket"
  type        = bool
  default     = true
}
#               Route 53 Domain
variable "root_domain_name" {
  description = "The domain name for the ALB"
  type        = string
  default     = "unshieldedhollow.click" # Replace with Your own domain
}
#              Route 53 ALB for Cloudfront
variable "root_alb" {
  description = "The is the name for alb origin domain"
  type        = string
  default     = "origin" # Replace with Your own domain
}
# This is just a subdomain
variable "alb_domain_name" {
  description = "This is a sub-domain for the root domain"
  type        = string
  default     = "www"
}
variable "route53_domain_name" {
  description = "value"
  type        = string
  default     = "www.unshieldedhollow.click" # Replace with your own domain and sub-domain
}
variable "certificate_validation_method" {
  description = "ACM validation method. Students can do DNS (Route53) or EMAIL."
  type        = string
  default     = "DNS"
}

# This is the Ec2 Instance Profile name and Ec2 instance to 
variable "ec2_instance_profile_name" {
  description = "This is to store credential database variables"
  type        = string
  default     = "EC2_RDS"
}
variable "ec2_instance_profile_name2" {
  description = "This is to store non credential database variables"
  type        = string
  default     = "EC2-ssm"
}
#                           Enable WAF- Web Application Firewall
variable "enable_waf" {
  description = "Toggle WAF creation."
  type        = bool
  default     = true
}
variable "waf_log_destination" {
  description = "This enables waf logs to go  to cloudwatch"
  type        = string
  default     = "cloudwatch"
}
variable "waf_log_dest" {
  description = "This enables waf logs to go to s3"
  type        = string
  default     = "s3"
}
#   WAF Logs
variable "waf_log_retention_days" {
  description = "The amount of days waf logs will be retained."
  type        = string
  default     = "14"
}
#                            ALB Stuff
variable "alb_5xx_threshold" {
  description = "Alarm threshold for ALB 5xx count."
  type        = number
  default     = 10
}

variable "alb_5xx_period_seconds" {
  description = "CloudWatch alarm period."
  type        = number
  default     = 300
}

variable "alb_5xx_evaluation_periods" {
  description = "Evaluation periods for alarm."
  type        = number
  default     = 1
}

variable "alb_access_logs_prefix" {
  description = ""
  type        = string
  default     = "alb"
}
#                               Firehose Logs
variable "firehose_log" {
  description = "This enables waf logs to go to s3"
  type        = string
  default     = "firehose"
}
#                              Cloudwatch Logs
variable "cloudwatch_log_retention_days" {
  description = "The amount of days waf logs will be retained."
  type        = string
  default     = "7"
}
#                                       Enable Cloudfront

variable "enable_cloudfront" {
  description = "Toggle CloudFront CDN creation (Lab 2). When enabled, traffic flows through CloudFront to ALB with origin cloaking."
  type        = bool
  default     = true # Set to true to enable Lab 2 CloudFront features
}

#                                           Data Blocks

#Data Block to pull AMI for Amazon Linux 2023
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_elb_service_account" "main" {}
data "aws_availability_zones" "available" {
  state = "available"
}
