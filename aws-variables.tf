######################## AWS Provider Begin ############################################
provider "aws" {
  region     = "us-east-2"
  access_key = var.access_key
  secret_key = var.secret_key
  version    = "~> 3.6.0"
}
######################## AWS Provider Begin ############################################

######################## AWS Cpmmectopm Variables Begin ############################################
variable "access_key" {}
variable "secret_key" {}
######################## AWS Cpmmectopm Variables End   ############################################



