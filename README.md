## Inroduction
SmartOS unites four extraordinary technologies to revolutionize the datacenter:

ZFS + DTrace + Zones + KVM

These technologies are combined into a single operating system, providing an arbitrarily-observable, highly multi-tenant environment built on a reliable, enterprise-grade storage stack.

### VMware workstation 11
In oder to test this hypervisor I want to run this in vmware workstation 11. Before we can do this we need to alter some rights on the vmware interfaces. We need to enable promiscuous mode on /dev/vmnet0 (the bridged interface).

    sudo chgrp <you group> /dev/vmnet*
    sudo chmod g+rw /dev/vmnet*

### SmartOs
After installing smartos for the latest iso we need to alter a couple of things

#### auhtorized keys
    cd /usbkey
    mkdir config.inc
    vi config.inc/authorized_keys
      - place your keys in this file
    echo "root_authorized_keys_file=authorized_keys" >> /usbkey/config

#### Networking
After installing smartos in vmware there could an issue with bridging. run `dladm show-link` if there's no vmwarebr0 we need to place the folling scripts.

    vi /opt/custom/methods/vmwarebr-smf.ksh
      - place the korn shell script here
    vi /opt/custom/smf/vmwarebr-smf.xml
      - place the xml file here
    /usr/sbin/svccfg validate /opt/custom/smf/vmwarebr-smf.xml
    /usr/sbin/svccfg import /opt/custom/smf/vmwarebr-smf.xml
    /usr/bin/svcs -l vmwarebr-smf

### lx zone configuration
    {
   	"alias": "lx zone template",
   	"brand": "lx",
    	"kernel_version": "3.13.0",
    	"image_uuid": "<ubuntu uuid>",
    	"quota": 20,
    	"max_physical_memory": 1024,
    	"resolvers": ["8.8.8.8", "8.8.4.4"],
    	"nics": [{
    		"nic_tag": "admin",
    		"ip": "10.0.0.100",
    		"netmask": "255.255.255.0",
    		"gateway": "10.0.0.1",
    		"allow_ip_spoofing": true,
    		"primary": true
    	}]
    }
