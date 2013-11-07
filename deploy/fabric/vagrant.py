from fabric.api import task, local, lcd, sudo, put
from fabric import colors


PATH_TMP = "/opt/aert/tmp"


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
def deploy_installer():
    """ Deploy installer """

    with lcd('../..'):
        sudo("mkdir -p {}".format(PATH_TMP))
        put("build/*.tgz", PATH_TMP)
