terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
resource "aws_s3_bucket" "log_bucket"  {
   bucket = var.bucketname
}
resource "aws_s3_bucket" "logging" {
  bucket = "examplebuckettftest"
}

resource "aws_s3_bucket" "mfadelete" {
  bucket = $(aws_s3_bucket.logging[0].id}
  acl    = var.private
  versioning {
    mfa_delete = false
  }
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
    }
}

resource "aws_s3_bucket" "publicread" {
  bucket = "examplebuckettftest"
  acl    = var.public
  versioning {
    enabled = true
  }
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
    }
}
resource "aws_s3_bucket" "statictwebhosting" {
  bucket = "examplebuckettftest"
  acl    = var.private
  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}
resource "aws_s3_bucket" "unestrictedaccess" {
  bucket = "examplebuckettftest"
  acl    = var.unrestricted
  versioning {
    enabled = true
  }
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
    }
}
resource "aws_s3_bucket" "versioning" {
  bucket = "examplebuckettftest"
  acl    = var.private
  versioning {
    enabled = false
  }
}
resource "aws_db_instance" "education" {
    name                      = var.name
    instance_class            = var.class
    allocated_storage         = var.storage
    backup_retention_period   = -1
    storage_encrypted         = false
    #kms_key_id = aws_kms_key.mykey.arn
}
resource "aws_ebs_volume" "example" {
  availability_zone = var.az
  size              = var.size
  encrypted         = false
  tags = {
    Name = "HelloWorld"
  }
}
