from fabric.api import task, run


@task
def manage_py(command):
    """ Runs a manage.py command on the server """
    cmd = 'django_admin.py {command}'
    run(cmd.format(command=command))


@task
def syncdb():
    """ Django syncdb command."""
    manage_py("syncdb --noinput")


@task
def migrate():
    """ Django South migrate command."""
    manage_py("migrate")
