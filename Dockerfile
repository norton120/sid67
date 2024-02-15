FROM python:3.11
COPY ./fastapi_test /app
COPY ./MemGPT /packages/MemGPT
COPY ./Sid /packages/Sid
RUN pip install poetry
WORKDIR /packages/MemGPT
RUN poetry config virtualenvs.create false && \
poetry install --no-root -E dev -E postgres
WORKDIR /app/app
RUN pip install --no-cache-dir -r /app/requirements.txt
ENV PYTHONPATH=/app/app:/packages/MemGPT:/packages/Sid
CMD uvicorn main:app --reload --host 0.0.0.0 --port 80