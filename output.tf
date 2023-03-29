output "endpoint" {
  value = aws_db_instance.mysqlref.endpoint
}
output "ubuntu_ami_id" {
  value = data.aws_ami_ids.ubuntu_2204.ids[0]
}

output "web_ip" {
  value = aws_instance.web.public_ip
}