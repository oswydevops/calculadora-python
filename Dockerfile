FROM python:3.13

WORKDIR /src

# 1. Instalar dependencias del sistema (incluyendo tkinter)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3-tk \
    gcc && \
    rm -rf /var/lib/apt/lists/*

# 2. Copiar requirements.txt (elimina la línea de tkinter primero)
COPY ./requirements.txt .

# 3. Instalar dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# 4. Limpiar dependencias de compilación
RUN apt-get purge -y gcc && \
    apt-get autoremove -y && \
    apt-get clean

# 5. Copiar el código fuente
COPY ./src .