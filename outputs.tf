output "my_vms" {
  value = [
    for vm in var.vms:
    {
      ami = vm.ami
      instance_id = aws_instance.web[vm.ami].id
      login_name = vm.login_name
      public_ip = aws_instance.web[vm.ami].public_ip
      os_description = vm.os_description
      local_file = vm.local_file
    }
  ]
}

output "pem_file" {
  value = var.pem_file
}

output "remote_path" {
  value = var.remote_path
}