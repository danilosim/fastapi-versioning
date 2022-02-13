FROM python:3.9
WORKDIR /src
COPY requirements.txt /src/requirements.txt
RUN pip install -r requirements.txt
COPY . /src
EXPOSE 8080
CMD ddtrace-run gunicorn src.app:app --workers 2 --worker-class uvicorn.workers.UvicornWorker --bind 0.0.0.0:8080
