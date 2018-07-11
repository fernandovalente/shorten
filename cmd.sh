#!/bin/bash

set -e

echo "Running manage.py runserver"
python manage.py migrate --noinput

echo "Running manage.py runserver"
exec python manage.py runserver 0:8000
