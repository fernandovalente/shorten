FROM python:3.6.3-stretch

ARG release=undefined
ENV RELEASE=$release

ENV DJANGO_COLORS="dark"

# Creating workspace
ENV WORKSPACE=/usr/src/app
RUN mkdir -p $WORKSPACE
WORKDIR $WORKSPACE

# Project dependency
COPY requirements.txt requirements.txt
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . $WORKSPACE

# RUN python manage.py collectstatic --noinput

CMD ["./cmd.sh"]
