Diskless Mythtv TODO
--------------------

1. Make your network IP static (Uncomment lines in /etc/network/interfaces)

2. Enable DHCP server (Add you eth device to /etc/default/isc-dhcp3-server)

3. Enable NFS Service through services.
   $ sudo dpkg-reconfigure mythbuntu-diskless-server
   	 NFS activate overlay? YES
	 Hosts allowed: *

4. Setup mythtv backend to work over the network
      Setup Local Backend IP as: 10.1.1.10  (was 127.0.0.1)
	  Master Backend IP as: 10.1.1.10       (was 127.0.0.1)
	  Pin: 0000    (required)  (Must be set, can be anything you want)

