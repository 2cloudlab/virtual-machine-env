variable "key_name" {
  type = string
  default = "for_you" # change to you pem file name without .pem
}

variable "size_in_GB" {
  type = number
  default = 80 # volume size in bytes for virtual machine
}

variable "pem_file" {
  type = string
  default = "~/Downloads/for_you.pem" # change to you pem file
}

variable "remote_path" {
  type = string
  default = "~/" # The virtual machine location to which local file will upload
}

variable "vms" {
  type = list(
    object({
      ami = string
      instance_type = string
      login_name = string # login name for this virtual machine
      local_file = string # the file you would like to upload to this virtual machine
      user_data = string # customize shell commands to install dependencies for ths virtual machine when luanched it
      os_description = string # a description about the OS running on this virtual machine
    })
  )
  default = [
    # config for each virtual machine
    {
      ami = "ami-02b658ac34935766f"
      instance_type = "t2.micro"
      login_name = "ubuntu"
      local_file = "handle_input.py"
      user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF
      os_description = "Ubuntu Server 18.04 LTS (HVM), SSD Volume Type - ami-02b658ac34935766f (64-bit x86)"
    },
    # Add more config for other virtual machine
  ]
}