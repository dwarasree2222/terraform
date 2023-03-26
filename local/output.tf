output "filecreated" {
  value = local_file.file.filename
}
output "content" {
  value = local_file.file.content
}