#!/bin/sh
set -e

echo "Waiting for PostgreSQL ($DB_HOST)..."
while ! pg_isready -h "$DB_HOST" -U "$DB_USER" -p "$DB_PORT" > /dev/null 2>&1; do
  sleep 1
done
echo "PostgreSQL is ready!"

echo "Applying database migrations..."
python manage.py migrate --noinput

echo "Creating superuser..."
python manage.py createuser --noinput --username admin --email admin@admin.com --password admin || echo "Superuser already exists"

echo "Seeding database..."
python manage.py seed_db

echo "Starting server..."
exec python manage.py runserver 0.0.0.0:8000

