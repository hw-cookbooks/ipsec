Description
===========

Installs and configures [strongSwan IPsec](http://strongswan.org/). By
default it creates a meshed, host-to-host network with a single,
shared secret.

*Warning*: This cookbook is a proof-of-concept. It has not been
validated to provide _any_ actual security and may damage your
network beyond repair. Use at your own risk!

Requirements
============

* Tested on Ubuntu 10.04

Attributes
==========

* `node[:ipsec][:shared_secret]` - defaults to "my_insecure_secret"

Usage
=====

By including the default recipe this cookbook will search for all
nodes with the ipsec recipe in their run list and configure
host-to-host connections between each.

All nodes use the same shared secret for simplicity. You may want to
investigate different authentication implementations if a more
complete security system is important for your organization.
