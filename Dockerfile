# Prepare the base environment.
FROM python:3.7.2-slim-stretch as builder_base
MAINTAINER asi@dbca.wa.gov.au
RUN apt-get update -y \
  && apt-get install --no-install-recommends -y wget git libmagic-dev gcc binutils libproj-dev gdal-bin python3-dev \
  && rm -rf /var/lib/apt/lists/*

# Install Python libs from requirements.txt.
FROM builder_base as python_libs_prs
WORKDIR /app
COPY requirements.txt ./
RUN pip install --upgrade pip \
  && pip install --no-cache-dir -r requirements.txt

# Install the project.
FROM python_libs_prs
COPY gunicorn.ini manage.py requirements.txt ./
COPY prs2 ./prs2
RUN pip install --no-cache-dir -r requirements.txt \
  && python manage.py collectstatic --noinput
EXPOSE 8080
HEALTHCHECK --interval=1m --timeout=5s --start-period=10s --retries=3 CMD ["wget", "-q", "-O", "-", "http://localhost:8080/healthcheck/"]
CMD ["gunicorn", "prs2.wsgi", "--config", "gunicorn.ini"]
