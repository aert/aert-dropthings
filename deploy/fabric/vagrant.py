from fabric.api import task, local, lcd, sudo, env
from fabric import colors


@task
def setup():
    """ Setup Vagrant """
    print colors.yellow("[ Vagrant : setup ]")

    #if 'wheezy64' not in local('vagrant box list', capture=True):
    #    _download_box()

    _destroy_up()


def _destroy_up():
    """ Destroy and restart vagrant """
    print colors.green(" - destroy and restart vagrant ")
    with lcd('..'):
        local('vagrant destroy')
        local('vagrant up')


@task
def h_vagrant():
    "Use Vagrant for testing"
    env.user = 'vagrant'
    env.hosts = ['192.168.111.222']

    # retrieve the IdentityFile:
    result = local('vagrant ssh-config | grep IdentityFile', capture=True)
    env.key_filename = result.split()[1].replace('"', '')  # parse IdentityFile


@task
def setup_ssh():
    "Set up vagrant"
    sudo("echo 'root:root' | chpasswd")
    sudo("apt-get update")
    local("sshpass -p root ssh-copy-id root@192.168.111.222")
