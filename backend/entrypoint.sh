#!/bin/sh
set -e

echo "Applying database migrations..."
python manage.py migrate --noinput

echo "Starting server..."
exec python manage.py runserver 0.0.0.0:8000
exec python manage.py createuser --noinput --username admin --email admin@admin.com --password admin

