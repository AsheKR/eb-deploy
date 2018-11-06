from .base import *

DEBUG = False


WSGI_APPLICATION = 'config.wsgi.application'

PRODUCTION_JSON = json.load(open(os.path.join(SECRET_DIR, 'production.json')))

DATABASES = PRODUCTION_JSON['DATABASES']

# Amazon S3
AWS_STORAGE_BUCKET_NAME = 'm41d'
