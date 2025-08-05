FROM python:3.12-slim

WORKDIR /app

COPY ./app/backend .

RUN pip install .

EXPOSE 8080

CMD ["python", "./app/main.py"]
