FROM ppc64le/fedora:28

MAINTAINER "The KubeVirt Project" <kubevirt-dev@googlegroups.com>
ENV container docker

#ENV LIBVIRT_VERSION

RUN dnf install -y dnf-plugins-core && \
  dnf copr enable -y @virtmaint-sig/virt-preview && \
  dnf install -y \
    libvirt-daemon-kvm \
    libvirt-client \
    socat \
    genisoimage \
    selinux-policy selinux-policy-targeted \
    yajl-devel \
    augeas && \
  dnf clean all

COPY augconf /augconf
RUN augtool -f /augconf

COPY libvirtd.sh /libvirtd.sh
RUN chmod a+x /libvirtd.sh
RUN cp /usr/bin/qemu-system-ppc64 /usr/bin/qemu-system-ppc64le
RUN setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/qemu-system-ppc64le

CMD ["/libvirtd.sh"]
