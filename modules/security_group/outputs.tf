output "webserver_sg" {
    value = aws_security_group.webserver.id
}
output "mysql_sg" {
    value = aws_security_group.mysql_rds_sg.id
}