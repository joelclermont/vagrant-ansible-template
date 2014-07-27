vagrant-ansible-template
========================

Starter template for a single box with nginx/mysql/php

Assumes local development with parallels and production is a Digital Ocean virtual machine.

It is very easy to switch out parallels with virtualbox for local development if you prefer.
See the comments in the Vagrantfile for more information.

Make sure to use some other mechanism to push your project files to test and production.
I disabled vagrant synced folders in these environments.