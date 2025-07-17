FROM python:3.13-slim

WORKDIR /src
COPY ./src/requirements.txt .
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends gcc && pip install --no-cache-dir -r requirements.txt && apt-get remove -y gcc && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./app .

CMD ["python", "main.py"]