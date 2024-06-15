FROM python:3.9-slim

WORKDIR /app

COPY app /app

RUN pip install --no-cache-dir fastapi uvicorn python-dotenv

ENV SERVICE_VERSION=1.0

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
