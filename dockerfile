FROM python:3.8-buster

# install nginx
RUN apt-get update && apt-get install nginx vim -y --no-install-recommends


# copy source and install dependencies
RUN mkdir -p /opt/app
RUN mkdir -p /opt/app/pip_cache
RUN mkdir -p /opt/app


COPY ./running /opt/app


WORKDIR /opt/app
RUN pip install -r requirements.txt --cache-dir /opt/app/pip_cache
RUN chown -R www-data:www-data /opt/app

# start server
EXPOSE 8000
