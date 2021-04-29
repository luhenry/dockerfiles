FROM base:latest

RUN apt-get -y install \
        qemu \
        qemu-kvm \
        libvirt-clients \
        libvirt-daemon-system \
        virtinst \
        bridge-utils

CMD virsh create win10.xml --console
