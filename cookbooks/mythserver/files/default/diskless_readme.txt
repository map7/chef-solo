Diskless Mythtv TODO
--------------------

1. Make your network IP static (Uncomment lines in /etc/network/interfaces)
2. Enable DHCP server (Add you eth device to /etc/default/isc-dhcp3-server)
3. Enable NFS Service through services.
   $ sudo dpkg-reconfigure mythbuntu-diskless-server
   	 NFS activate overlay? YES
	 Hosts allowed: *
