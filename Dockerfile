FROM python:3.8.1-slim-buster as base
WORKDIR /app
EXPOSE 8000
RUN apt-get update --yes --quiet && apt-get install --yes --quiet --no-install-recommends \
    build-essential \
    libpq-dev \
    libmariadbclient-dev \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    libwebp-dev \
 && rm -rf /var/lib/apt/lists/*
COPY requirements.txt /
RUN pip install -r /requirements.txt
COPY . .

FROM base as dev
# Install git
RUN apt-get update
RUN apt-get install -y git
CMD ["tail", "-f", "/dev/null"]

FROM base as prod
CMD ["tail", "-f", "/dev/null"]
# RUN pip install "gunicorn==20.0.4"
# RUN python manage.py collectstatic --noinput --clear
# CMD set -xe; python manage.py migrate --noinput; gunicorn tennis.wsgi:application
