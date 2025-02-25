BASE_BOX_IMAGE = "ubuntu/jammy64"
CPUS_MASTER = 2
MEMORY_MASTER = 2048
CPUS_WORKER = 1
MEMORY_WORKER = 1024

# Change to increase the number of workers
WORKER_NODE_COUNT = 1

Vagrant.configure("2") do |config|
  config.vm.provision "shell", path: "common.sh"

  # Master node

  config.vm.define "master" do |master|
    master.vm.box = BASE_BOX_IMAGE
    master.vm.hostname = "master.example.com"
    master.vm.network "private_network", ip: "192.168.56.105"
    master.vm.network "forwarded_port", guest: 6443, host: 6443
    master.vm.provider "virtualbox" do |vb|
      vb.name = "master"
      vb.cpus = CPUS_MASTER
      vb.memory = MEMORY_MASTER
    end

    master.vm.provision "shell", path: "master.sh"
  end

    # Worker node

    (1..WORKER_NODE_COUNT).each do |i|
      config.vm.define "worker#{i}" do |worker|
        worker.vm.box = BASE_BOX_IMAGE
        worker.vm.hostname = "worker#{i}.example.com"
        worker.vm.network "private_network", ip: "192.168.56.11#{i}"
        worker.vm.provider "virtualbox" do |vb|
          vb.name = "worker#{i}"
          vb.cpus = CPUS_WORKER
          vb.memory = MEMORY_WORKER
        end
        worker.vm.provision "shell", path: "worker.sh"
      end
  end

  config.vm.define "master" do |master|
    master.vm.provision "shell", path: "apply-tests.sh"
  end
end
