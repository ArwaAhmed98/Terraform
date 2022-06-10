resource "tls_private_key" "private_key_pair" { # da eli m3aya -- private key 
 algorithm = "RSA"
 rsa_bits = 4096 
}
resource "aws_key_pair" "public_key_pair" { # b create hena public key men private eli fo2 , keda m3yaa public key w privte key 
 key_name = "pub-key"
 public_key = tls_private_key.private_key_pair.public_key_openssh
} 
resource "aws_secretsmanager_secret" "private_key" { 
 name = "priv-key" #create folder on the service
 recovery_window_in_days = 0 # ZERO ---> NEVER EXPIRE
}
 #############################################################
resource "aws_secretsmanager_secret" "public_key" { #create folder on the services
 name = "pub-key"
 recovery_window_in_days = 0
}
######################################################################
resource "aws_secretsmanager_secret_version" "secret_key_value" { #store private in secret manager secret manager 
 secret_id = aws_secretsmanager_secret.private_key.id
 secret_string = tls_private_key.private_key_pair.private_key_pem 
}
 
resource "aws_secretsmanager_secret_version" "public_key_value" { #store pubkey in secret manager secret manager 
 secret_id = aws_secretsmanager_secret.public_key.id
 secret_string = aws_key_pair.public_key_pair.public_key
}