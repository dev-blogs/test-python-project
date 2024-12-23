FROM python:latest

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY main.py /usr/src/app
COPY requirements.txt /usr/src/app
COPY db_health_check.sh /usr/src/app

RUN chmod +x /usr/src/app/db_health_check.sh
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

CMD ["python", "main.py"]