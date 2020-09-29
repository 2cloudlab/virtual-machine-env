import sys
import json
import time
from subprocess import call

ouput = json.loads(sys.stdin.read())
vms = ouput["my_vms"]["value"]
remote_path = ouput["remote_path"]["value"]
pem_file = ouput["pem_file"]["value"]
time.sleep(10) # wait 10 seconds to let virtual machine start ssh service
for vm in vms:
    login_name = vm["login_name"]
    public_ip = vm["public_ip"]
    local_file = vm["local_file"]
    cmd = f"scp -i {pem_file} {local_file} {login_name}@{public_ip}:{remote_path}"
    call(cmd.split(" "), cwd=".")