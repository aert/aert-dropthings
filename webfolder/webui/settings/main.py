import os
from ConfigParser import RawConfigParser

config = RawConfigParser()
config_file = os.environ['AERT_WEBFOLDER_CONFIG']
config.read(config_file)

DEVELOP = config.getboolean('main', 'DEVELOP')

if DEVELOP:
    from .develop import *
else:
    from .release import *

# [main]
ALLOWED_HOSTS = config.get('main', 'ALLOWED_HOSTS').split()
if not DEVELOP:
    STATIC_ROOT = config.get('main', 'STATIC_ROOT')
    STATIC_URL = config.get('main', 'STATIC_URL')
    MEDIA_ROOT = config.get('main', 'MEDIA_ROOT')
    MEDIA_URL = config.get('main', 'MEDIA_URL')

# [database]
DATABASE_USER = config.get('database', 'DATABASE_USER')
DATABASE_PASSWORD = config.get('database', 'DATABASE_PASSWORD')
DATABASE_HOST = config.get('database', 'DATABASE_HOST')
DATABASE_PORT = config.get('database', 'DATABASE_PORT')
DATABASE_ENGINE = config.get('database', 'DATABASE_ENGINE')
DATABASE_NAME = config.get('database', 'DATABASE_NAME')
TEST_DATABASE_NAME = config.get('database', 'TESTSUITE_DATABASE_NAME')

# [secrets]
SECRET_KEY = config.get('secrets', 'SECRET_KEY')
CSRF_MIDDLEWARE_SECRET = config.get('secrets', 'CSRF_MIDDLEWARE_SECRET')

# [cookies]
SESSION_COOKIE_DOMAIN = config.get('cookies', 'SESSION_COOKIE_DOMAIN')

# [debug]
DEBUG = config.getboolean('debug', 'DEBUG')
TEMPLATE_DEBUG = config.getboolean('debug', 'TEMPLATE_DEBUG')
VIEW_TEST = config.getboolean('debug', 'VIEW_TEST')
INTERNAL_IPS = tuple(config.get('debug', 'INTERNAL_IPS').split())
if config.getboolean('debug', 'SKIP_CSRF_MIDDLEWARE'):
    MIDDLEWARE_CLASSES = tuple([x for x in list(MIDDLEWARE_CLASSES)
                               if not x.endswith('CsrfMiddleware')])

# [email]
SERVER_EMAIL = config.get('email', 'SERVER_EMAIL')
EMAIL_HOST = config.get('email', 'EMAIL_HOST')

# [admins]
ADMINS = tuple(config.items('admins'))

# [managers]
MANAGERS = tuple(config.items('managers'))
