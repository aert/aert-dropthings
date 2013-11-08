from os.path import dirname, abspath, join, splitext
from fabric.api import task, lcd, sudo, put, cd


REMOTE_TMP = "/opt/aert/tmp"
DJANGO_ROOT = dirname(dirname(dirname(abspath(__file__))))

with open(join(DJANGO_ROOT, "RELEASE-VERSION"), "r") as f:
    VERSION = f.readlines()[0].rstrip()


@task
def push():
    """ Deploy installer """
    archive_name = "setup_aert-webfolder_{}.tgz".format(VERSION)
    installer_path = join(DJANGO_ROOT, "build/{}".format(archive_name))

    # send installer
    with lcd('../..'):
        sudo("mkdir -p {}".format(REMOTE_TMP))
        put(installer_path, REMOTE_TMP)

    # unarchive installer
    with cd(REMOTE_TMP):
        sudo("tar zxf {}".format(archive_name))

    # install
    with cd(join(REMOTE_TMP, splitext(archive_name)[0])):
        sudo("make install")
