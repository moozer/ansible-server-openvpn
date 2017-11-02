Tests
==========

Current test environment is to start three virtual machines

* `server-int` which is the internal machine to be connected to
* `server-ext` chich is the external machine that connects to the vpn server and tries to connect to the onternal machine afterwards
* `server-vpn` which is the actual vpnserver

The internal machine has internet connection throught some unspecified router. The VPN server has two interfaces, one external and one internal - In a production environment, external would either be a public IP or in DMZ.

To run machines
-------------

This is a vagrant test setup. To use

Change the box config to fit your setup. Do this by changing the box name

    config.vm.box = "deb8-base"

Suggested value is `debian/jessie64`, but it currently fails with vagrant and libvirt  when setting hostnames (sorry, cannot find bug report)


Start vagrant

    vagrant up
  
Everything should be green.


To do tests only
------------------

To do a self test on the system, use ansible

    ansible-playbook -t tests test.yml 
