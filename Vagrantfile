Vagrant.configure("2") do |config|

    config.vm.provider "parallels" do |v|
        v.name = "**enter_custom_box_name**"
    end

    config.vm.define "local", primary: true do |local|

        local.vm.box = "parallels/ubuntu-12.04"

        local.vm.network :private_network, ip: "192.168.33.102"

        local.vm.synced_folder "./", "/vagrant", owner: "www-data", group: "www-data"

        config.vm.provision "ansible" do |ansible|
            ansible.extra_vars = {
                server_name: "192.168.33.102",
                application_env: "development"
            }
            ansible.playbook = "ansible/playbook.yml"
        end
    end

    config.vm.define "test" do |test|

        test.vm.box = "digital_ocean"
        test.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
        test.vm.hostname = "**test.domain.com**"

        # do not allow vagrant to sync files
        # use some other mechanism (like git) to deploy files
        test.vm.synced_folder "./", "/vagrant", disabled: true

        test.vm.provider :digital_ocean do |provider, override|
            override.ssh.private_key_path = "~/.ssh/id_rsa"
            provider.client_id = "**enter_your_client_id**"
            provider.api_key = "**enter_your_api_key**"
            provider.image = "Ubuntu 12.04.4 x64"
            provider.region = "San Francisco 1"
            provider.size = "1GB"
        end

        config.vm.provision "ansible" do |ansible|
            ansible.extra_vars = {
                server_name: "**enter_your_public_server_ip**",
                application_env: "testing"
            }
            ansible.playbook = "ansible/playbook.yml"
        end
    end

    config.vm.define "prod" do |prod|

        prod.vm.box = "digital_ocean"
        prod.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
        prod.vm.hostname = "**domain.com**"

        # do not allow vagrant to sync files
        # use some other mechanism (like git) to deploy files
        prod.vm.synced_folder "./", "/vagrant", disabled: true

        prod.vm.provider :digital_ocean do |provider, override|
            override.ssh.private_key_path = "~/.ssh/id_rsa"
            provider.client_id = "**enter_your_client_id**"
            provider.api_key = "**enter_your_api_key**"
            provider.image = "Ubuntu 12.04.4 x64"
            provider.region = "New York 2"
            provider.size = "1GB"
        end

        config.vm.provision "ansible" do |ansible|
            ansible.extra_vars = {
                server_name: "**enter_your_public_server_ip**",
                application_env: "prod"
            }
            ansible.playbook = "ansible/playbook.yml"
        end
    end
end