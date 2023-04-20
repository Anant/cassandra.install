variable "instances" {}

variable "ami_id" {
    type = string
    default = "ami-02eb7a4783e7e9317" #Ubuntu-22 in ap-south-1
}

variable "instance_type" {
    type = string
    default = "t3.micro"
}

variable "subnet" {}