virtualenv .venv
source .venv/bin/activate
pip install -r req.txt
django-admin startproject config
mv config/ app
cp .env app/
cp settings.py app/config
cp urls.py app/config
cd app/
export DJANGO_SUPERUSER_PASSWORD="mahan100" DJANGO_SUPERUSER_USERNAME="admin" DJANGO_SUPERUSER_EMAIL="yousef@yousef.com"
python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py createsuperuser --noinput
python manage.py collectstatic --noinput
gunicorn -b 127.0.0.1:8000 config.wsgi