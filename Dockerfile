FROM python:3.13

WORKDIR /src

# Instalar dependencias del sistema primero
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-tk \
    gcc && \
    rm -rf /var/lib/apt/lists/*

COPY ./requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Limpiar dependencias de compilación si ya no son necesarias
RUN apt-get purge -y gcc && \
    apt-get autoremove -y && \
    apt-get clean

COPY ./src .