# Boost a bucket of EC2 instances to prepare test environments in a minute.

Prerequisites for using the scripts:

* Terraform, version 0.12.19
* Python, version 3.x
* git

Before you use the script, make sure to change the following variables

1. Change the region in region variable at main.tf
2. Config OS info in vms at variables.tf, if you want to yum or apt-get dependencies when EC2 instances launch, consider writting shell script in user_data variable
3. Change your pem file name in key_name at variables.tf
4. Tune volume size in size_in_GB at variables.tf
5. Specific pem file in pem_file which is used for uploading local file to the created virtual machine at variables.tf
6. Specific the location in remote_path to which local file upload at variables.tf

Run the following commands to provision EC2 instances:

```bash
terraform init
terraform apply
```

After successfully provisioned, the outputs will be shown like below:

```bash
Outputs:

my_vms = [
  {
    "ami" = "ami-02b658ac34935766f"
    "instance_id" = "i-0de32907e290e6af2"
    "login_name" = "ubuntu"
    "local_file" = "handle_input.py"
    "os_description" = "Ubuntu Server 18.04 LTS (HVM), SSD Volume Type - ami-02b658ac34935766f (64-bit x86)"
    "public_ip" = "3.112.173.199"
  },
]
```

If you want to upload local file, you can run the following command:

```bash
terraform output -json | python handle_input.py
```

If test jobs are done, make sure run the following command to destroy EC2 instances:

```bash
terraform destroy
```