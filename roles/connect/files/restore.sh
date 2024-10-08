#!/bin/bash

/usr/bin/sudo /usr/bin/virsh destroy image-mode
/usr/bin/logger -p local4.info -t "User: "${USER} "Destroying image-mode vm - "$?
/usr/bin/sudo /usr/bin/virsh destroy image-mode-test
/usr/bin/logger -p local4.info -t "User: "${USER} "Destroying image-mode-test vm - "$?
/usr/bin/sudo /usr/bin/virsh destroy podman
/usr/bin/logger -p local4.info -t "User: "${USER} "Destroying podman vm - "$?
/usr/bin/sudo /usr/bin/virsh destroy openscap
/usr/bin/logger -p local4.info -t "User: "${USER} "Destroying openscap vm - "$?

case "${USER}" in

	"imagemode")
	/usr/bin/sudo /usr/bin/qemu-img convert -f qcow2 -O qcow2 -o lazy_refcounts=on /var/lib/libvirt/images/templates/image-mode.qcow2 /imagemode/image-mode.qcow2
	/usr/bin/logger -p local4.info -t "User: "${USER} "Restoring image-mode vm - "$?
	/usr/bin/sudo /usr/bin/qemu-img convert -f qcow2 -O qcow2 -o lazy_refcounts=on /var/lib/libvirt/images/templates/image-mode-test.qcow2 /imagemode/image-mode-test.qcow2
	/usr/bin/logger -p local4.info -t "User: "${USER} "Restoring image-mode-test vm - "$?
	/usr/bin/sudo /usr/bin/virsh start image-mode
	/usr/bin/logger -p local4.info -t "User: "${USER}"Starting image-mode vm - "$?
	/usr/bin/chmod 0664 /imagemode/image-mode-test.qcow2
	;;

esac