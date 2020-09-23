################################################
#  AWS Terraform For BeeGFS         
#  by Simon Stockhause 
################################################

# Create A File Which Contains The Created Hosts From AWS
# Contains:
# - 
data  "template_file" "aws" {
    template = "${file("./templates/hosts.tpl")}"
    vars = {
        ansible_ssh_private_key_file= "${var.ssh_private_key_file_path}"
        beeGFS_managment = aws_instance.beeGFS-managment.public_dns
        beeGFS_metadata = aws_instance.beeGFS-metadata.public_dns
        beeGFS_storage = aws_instance.beeGFS-storage.public_dns
        beeGFS_client = aws_instance.beeGFS-client.public_dns

    }
}

resource "local_file" "aws_file" {
  content  = "${data.template_file.aws.rendered}"
  filename = "./ansible-provisioning/aws-hosts"
}