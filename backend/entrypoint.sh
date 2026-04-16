#!/bin/sh
set -e

echo "Applying database migrations..."
python manage.py migrate --noinput

echo "Creating superuser..."
python manage.py createuser --noinput --username admin --email admin@admin.com --password admin || echo "Superuser already exists"

echo "Seeding database..."
python manage.py seed_db

echo "Starting server..."
exec python manage.py runserver 0.0.0.0:8000

