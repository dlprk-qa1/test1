variable "public" {
  default = "public-read"
}

variable "private"{
  default = "private"
}

variable "unrestricted" {
  default = "public-read-write"
}


variable "name" {
  default = "edu"
}


variable "class" {
  default = "db.t3.micro"
}

variable "storage" {
  default = 10
}
variable "az" {
  default = "us-west-2a"
}
variable "size" {
  default = 40
}
variable "bucketname"{
  default="examplebucketfest"
