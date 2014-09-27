# all the variables you need to set are listed here
box_name                = "" # an arbitrary name to call your local VM
local_host_name         = ""
test_host_name          = ""
test_ip                 = ""
prod_host_name          = ""
prod_ip                 = ""
digital_ocean_token     = "" # V2 API
#digital_ocean_client_id = "" #for V1 API
#digital_ocean_api_key   = "" #for V1 API

# previous comment is not really true
# you will likely want to set the box type/image types below too
# you may also want to control the Digital Ocean region or VM sizes too
Vagrant.configure("2") do |config|

    # parallels is optional, feel free to use virtualbox for local dev
    config.vm.provider "parallels" do |v|
        v.name = box_name
    end

    config.vm.define "local", primary: true do |local|

        local.vm.box = "parallels/ubuntu-12.04" # change this to any box you want
        local.vm.hostname = local_host_name

        local.vm.network :private_network, ip: "192.168.33.102"

        local.vm.synced_folder "./", "/vagrant", owner: "www-data", group: "www-data"

        config.vm.provision "ansible" do |ansible|
            ansible.extra_vars = {
                server_name: "192.168.33.102",
                application_env: "development",
                host_name: local_host_name
            }
            ansible.playbook = "ansible/playbook.yml"
        end
    end

    config.vm.define "test" do |test|

        test.vm.box = "digital_ocean"
        test.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
        test.vm.hostname = test_host_name

        # do not allow vagrant to sync files
        # use some other mechanism (like git) to deploy files
        test.vm.synced_folder "./", "/vagrant", disabled: true

        test.vm.provider :digital_ocean do |provider, override|
            override.ssh.private_key_path = "~/.ssh/id_rsa"
            #provider.client_id = digital_ocean_client_id
            #provider.api_key = digital_ocean_api_key
            provider.token = digital_ocean_token
            provider.image = "Ubuntu 14.04 x64"
            provider.region = "sfo1"
            provider.size = "1GB"
        end

        config.vm.provision "ansible" do |ansible|
            ansible.extra_vars = {
                server_name: test_ip,
                application_env: "testing",
                host_name: test_host_name
            }
            ansible.playbook = "ansible/playbook.yml"
        end
    end

    config.vm.define "prod" do |prod|

        prod.vm.box = "digital_ocean"
        prod.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
        prod.vm.hostname = prod_host_name

        # do not allow vagrant to sync files
        # use some other mechanism (like git) to deploy files
        prod.vm.synced_folder "./", "/vagrant", disabled: true

        prod.vm.provider :digital_ocean do |provider, override|
            override.ssh.private_key_path = "~/.ssh/id_rsa"
            #provider.client_id = digital_ocean_client_id
            #provider.api_key = digital_ocean_api_key
            provider.token = digital_ocean_token
            provider.image = "Ubuntu 14.04 x64"
            provider.region = nyc2"
            provider.size = "1GB"
        end

        config.vm.provision "ansible" do |ansible|
            ansible.extra_vars = {
                server_name: prod_ip,
                application_env: "prod",
                host_name: prod_host_name
            }
            ansible.playbook = "ansible/playbook.yml"
        end
    end
end
