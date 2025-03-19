# rhel-microlabs-deployment

RHEL microworkshop Connect 2024

Several laptops will be used.

Each laptop will have several users, each user will be used to perform a different lab:

* [Image mode microlab](https://github.com/redhat-iberia/microlab-image_mode)
* [Openscap microlab](https://github.com/redhat-iberia/microlab-openscap)
* [Podman microlab](https://github.com/redhat-iberia/microlab-podman)

This repository contains an ansible playbook that will configure the laptops to run those microlabs.

Each microlab will be configured in a virtual machine.

## Configuring the laptops

To configure the laptops you will need to have ansible installed on the laptod, clone this repository and using a user with passwordless sudo privileges and execute:

```bash
$ ansible-playbook -i hosts configure-laptops.yml
```

where the file **hosts** will be the ansible inventory file:

```bash
$ cat hosts
localhost ansible_user=admin
$
```

So the **admin** user will have to be configured with a public key to be able to perform a SSH login and will need to have passwordless sudo configured to be able to execute commands as root.

This ansible playbook will perform the following:

1. File [roles/connect/tasks/10-users.yml](roles/connect/tasks/10-users.yml): It will create the users included in the **users** list in the [roles/connect/vars/mail.yml](roles/connect/vars/mail.yml) file. The user's password is **redhat** and can be changed in the **passwd** variable on the same file.
1. File [roles/connect/tasks/20-req-general.yml](roles/connect/tasks/20-req-general.yml): It will configure some aspects for the virtual machines. The **/etc/hosts** file will be modified to include the virtual machines ip and names, so you will probably need to modify this.
1. File [roles/connect/tasks/30-nfs-server.yml](roles/connect/tasks/30-nfs-server.yml): A NFS server will be configured and a NFS shared will be configured. In this NFS share the image mode microlab will store the vm disk that will be created so the KVM in the laptop will be able to boot a VM from that qcow2 disk.
1. File [roles/connect/tasks/40-restore.yml](roles/connect/tasks/40-restore.yml): This will create the scripts that will start/stop the microlab's VMs and restore them when the users perform login and logout.
1. File [roles/connect/tasks/50-launchers.yml](roles/connect/tasks/50-launchers.yml): This will add the sudo privileges needed to start the VM that was created with image mode.
