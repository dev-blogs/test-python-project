FROM python:3.6

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY main.py /usr/src/app
COPY requirements.txt /usr/src/app
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

CMD ['python', 'main.py']