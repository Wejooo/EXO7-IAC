provider "aws" {
  region = var.aws_region
}

# Le Learner Lab fournit deja une key pair "vockey" dont le .pem est
# telechargeable depuis AWS Academy -> AWS Details -> Download PEM.
# On la reference via un data source plutot que de la recreer.
data "aws_key_pair" "deployer" {
  key_name = var.key_name
}
