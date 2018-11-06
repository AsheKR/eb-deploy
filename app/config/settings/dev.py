from .base import *

DEBUG = True


WSGI_APPLICATION = 'config.wsgi.application'

DEV_JSON = json.load(open(os.path.join(SECRET_DIR, 'dev.json')))

DATABASES = DEV_JSON['DATABASES']

# Amazon S3
AWS_STORAGE_BUCKET_NAME = 'm41d-dev'
