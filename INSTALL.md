# Установка и запуск

## Требования

- Python 3.10
- Linux или WSL (часть пакетов из `requirements.txt` не устанавливается на Windows)
- PostgreSQL для backend store и Model Registry MLflow, а также с таблицей признаков `flats_feature` (результат ETL из спринта 1)
- S3-совместимое хранилище для артефактов MLflow
- Baseline-модель и данные из проекта спринта 1 (пути задаются в `train_old_registry.ipynb`)

## Окружение

```bash
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

## Конфигурация

Скопируйте шаблон и заполните значения:

```bash
cp .env.example .env
```

Файл `.env` содержит параметры доступа к S3 и PostgreSQL. В репозиторий он не попадает (указан в `.gitignore`).

## Запуск MLflow

```bash
bash run_mlflow_server_full.sh
```

Интерфейс MLflow: http://localhost:5000

## Порядок работы с ноутбуками

1. `train_old_registry.ipynb`: обучение или загрузка baseline и регистрация модели `real_estate_price_model` (v1). В ячейках `DATA_PATH` и `MODEL_PATH` укажите пути к данным и модели из проекта спринта 1.
2. `model_improvement/model_improvement.ipynb`: последовательно выполняйте этапы EDA, генерации признаков, отбора признаков и подбора гиперпараметров. Модели регистрируются как `real_estate_price_model_v2`, `_v3_fs`, `_v4_optuna`.

Этап отбора признаков (SFS/SBS) занимает много времени; итоговый список признаков сохранён в `model_improvement/FS_ASSETS/final_features_union.txt` и продублирован в ноутбуке, поэтому этап можно не перезапускать.
