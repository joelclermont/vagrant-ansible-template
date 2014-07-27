vagrant-ansible-template
========================

Starter template for a single box with nginx/mysql/php

Assumes local development with parallels and production is a Digital Ocean virtual machine.

It is very easy to switch out parallels with virtualbox for local development if you prefer.
See the comments in the Vagrantfile for more information.

Make sure to use some other mechanism to push your project files to test and production.
I disabled vagrant synced folders in these environments.

Steps to use:
* Clone the repo
* Enter the values for variables at the top of Vagrantfile
* Enter the values for variables toward the top of playbook.yml
* Enter your public key in public_keys
* Put a mysqldump in data/seed-database.sql if you want seed data