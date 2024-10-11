# terraform
Scraps and tryout things to share

Here be dragons.

YMMV

Use at your own risk!!

I'm not responsible for anything negative that occurs after using this repo.

Note on Talos: Use the Talos Factory to create a metal-<arch>.iso as you need it.

https://factory.talos.dev

When you get to the system extension selection (example: https://factory.talos.dev/?arch=amd64&platform=metal&target=metal&version=1.8.1)

I've added:
- siderolabs/qemu-guest-agent (for kvm/qemu guests)
- siderolabs/util-linux-tools

See: https://github.com/siderolabs/extensions

Note on DHCP and MAC address:

Added static mac address generated with /tools/macgen.py to the terraform vars.
This keeps the mac addressess constant accross destroy/apply so you can create a dhcpd.conf and
don't have to update the DNS/DHCP on each destroy/apply.
