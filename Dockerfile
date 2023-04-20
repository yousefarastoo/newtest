FROM python:slim
ENV PYTHONDNOTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DJANGO_SUPERUSER_PASSWORD mahan100
RUN mkdir /app
WORKDIR /app
RUN pip install --upgrade pip
COPY req.txt .
COPY .env .
RUN export $DJANGO_SUPERUSER_PASSWORD 
RUN pip install -r req.txt
CMD python manage.py makemigrations --noinput && \
python manage.py migrate --noinput && \
python manage.py collectstatic --noinput && \
python manage.py createsuperuser --noinput --user admin --email yousef@yousef.com ;\
gunicorn -b 0.0.0.0:8000 config.wsgi
