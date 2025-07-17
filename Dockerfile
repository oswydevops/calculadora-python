FROM python:3.13-slim

WORKDIR /app
COPY ./app/requirements.txt .
RUN apt-get update && apt-get upgrade -y && pip install --no-cache-dir -r requirements.txt && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app .

CMD ["python", "main.py"]