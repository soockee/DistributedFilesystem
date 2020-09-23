################################################
#  AWS Terraform For BeeGFS 
#  by Simon Stockhause 
################################################

provider "aws" {
  profile = "${var.aws_profile}"
  region = "${var.region}"
}
# Searching And Selecting The Graphic AMI Which Was Build By Packer 
data "aws_ami" "beeGFS-client-img"{
    name_regex="^beeGFS-pointcloud.*"
    most_recent = true
    owners = ["self"]
}
# Searching And Selecting The Graphic AMI Which Was Build By Packer 
data "aws_ami" "beeGFS-managment-img"{
    name_regex="^beeGFS-pointcloud.*"
    most_recent = true
    owners = ["self"]
}
data "aws_ami" "beeGFS-metadata-img"{
    name_regex="^beeGFS-pointcloud.*"
    most_recent = true
    owners = ["self"]
}
data "aws_ami" "beeGFS-storage-img"{
    name_regex="^beeGFS-pointcloud.*"
    most_recent = true
    owners = ["self"]
}
# beeGFS-managment server
resource "aws_instance" "beeGFS-managment" {
  ami          = "${data.aws_ami.beeGFS-managment-img.id}"
  instance_type = "${var.beeGFS_managment_instance_type}"
  key_name = "${var.keypair}"
  tags = {
    Name = "BeeGFS Managment"
  } 
  root_block_device {
    volume_type = "standard"
    volume_size = 20
    delete_on_termination = true
  }
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.ssh.id}","${aws_security_group.http.id}"]
  subnet_id = "${aws_subnet.beeGFS-public-subnet.id}"
}
# beeGFS-metadata server
resource "aws_instance" "beeGFS-metadata" {
  ami          = "${data.aws_ami.beeGFS-metadata-img.id}"
  instance_type = "${var.beeGFS_metadata_instance_type}"
  key_name = "${var.keypair}"
  tags = {
    Name = "BeeGFS Metadata"
  } 
  root_block_device {
    volume_type = "standard"
    volume_size = 20
    delete_on_termination = true
  }
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.ssh.id}","${aws_security_group.http.id}"]
  subnet_id = "${aws_subnet.beeGFS-public-subnet.id}"
}
# beeGFS-storage server
resource "aws_instance" "beeGFS-storage" {
  ami          = "${data.aws_ami.beeGFS-storage-img.id}"
  instance_type = "${var.beeGFS_storage_instance_type}"
  key_name = "${var.keypair}"
  tags = {
    Name = "BeeGFS Storage"
  } 
  root_block_device {
    volume_type = "standard"
    volume_size = 20
    delete_on_termination = true
  }
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.ssh.id}","${aws_security_group.http.id}"]
  subnet_id = "${aws_subnet.beeGFS-public-subnet.id}"
}
# beeGFS-storage server
resource "aws_instance" "beeGFS-client" {
  ami          = "${data.aws_ami.beeGFS-client-img.id}"
  instance_type = "${var.beeGFS_client_instance_type}"
  key_name = "${var.keypair}"
  tags = {
    Name = "BeeGFS Client"
  } 
  root_block_device {
    volume_type = "standard"
    volume_size = 20
    delete_on_termination = true
  }
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.ssh.id}","${aws_security_group.http.id}"]
  subnet_id = "${aws_subnet.beeGFS-public-subnet.id}"
}