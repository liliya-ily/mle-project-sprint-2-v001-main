#!/usr/bin/env bash
# Запуск MLflow Tracking Server и Model Registry.
# Параметры подключения читаются из файла .env в корне проекта (см. .env.example).
set -euo pipefail

cd "$(dirname "$0")"

set -a
source .env
set +a

: "${MLFLOW_S3_ENDPOINT_URL:?переменная не задана в .env}"
: "${AWS_ACCESS_KEY_ID:?переменная не задана в .env}"
: "${AWS_SECRET_ACCESS_KEY:?переменная не задана в .env}"
: "${S3_BUCKET_NAME:?переменная не задана в .env}"
: "${DB_DESTINATION_HOST:?переменная не задана в .env}"
: "${DB_DESTINATION_PORT:?переменная не задана в .env}"
: "${DB_DESTINATION_NAME:?переменная не задана в .env}"
: "${DB_DESTINATION_USER:?переменная не задана в .env}"
: "${DB_DESTINATION_PASSWORD:?переменная не задана в .env}"

DB_URI="postgresql://${DB_DESTINATION_USER}:${DB_DESTINATION_PASSWORD}@${DB_DESTINATION_HOST}:${DB_DESTINATION_PORT}/${DB_DESTINATION_NAME}"

mlflow server \
    --registry-store-uri "${DB_URI}" \
    --backend-store-uri "${DB_URI}" \
    --default-artifact-root "s3://${S3_BUCKET_NAME}" \
    --host 0.0.0.0 \
    --port 5000 \
    --no-serve-artifacts
