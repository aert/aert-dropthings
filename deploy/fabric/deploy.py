from os.path import dirname, abspath
from fabric.api import task, lcd, sudo, put, cd


REMOTE_TMP = "/opt/aert/tmp"
DJANGO_ROOT = dirname(dirname(abspath(__file__)))

with open("RELEASE-VERSION", "r") as f:
    VERSION = f.readlines()[0]


@task
def push():
    """ Deploy installer """
    archive_name = "setup_aert-webfolder_{}.tgz".format(VERSION)
    installer_path = "build/{}".format(archive_name)

    # send installer
    with lcd('../..'):
        sudo("mkdir -p {}".format(REMOTE_TMP))
        put(installer_path, REMOTE_TMP)

    # unarchive installer
    with cd(REMOTE_TMP):
        sudo("tar zxf {}".format(archive_name))
