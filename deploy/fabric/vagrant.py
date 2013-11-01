from fabric.api import task, local, lcd
from fabric import colors


@task
def setup():
    """ Setup Vagrant """
    print colors.yellow("[ Vagrant : setup ]")

    if 'wheezy64' not in local('vagrant box list', capture=True):
        _download_box()

    _destroy_up()


def _download_box():
    print colors.green("  - download box ]")
    box_url = "https://dl.dropboxusercontent.com/s/xymcvez85i29lym/" \
              "vagrant-debian-wheezy64.box"
    cmd = "vagrant box add wheezy64 {url}"

    with lcd('..'):
        local(cmd.format(url=box_url))


def _destroy_up():
    print colors.green(" - destroy and restart vagrant ]")
    with lcd('..'):
        local('vagrant destroy')
        local('vagrant up')
