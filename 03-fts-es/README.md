# 03-fts-es — Полнотекстовый поиск с Elasticsearch

Этот стенд демонстрирует полнотекстовый поиск с использованием Elasticsearch.

## Что делает стенд

1. Запускает Elasticsearch в Docker
2. Создаёт индекс с документами
3. Индексирует тестовые данные
4. Выполняет полнотекстовый поиск
5. Демонстрирует возможности ES для поиска текста

## Как запустить

```bash
./run.sh
```

Скрипт автоматически:
- Установит Python-зависимости
- Запустит Elasticsearch в Docker
- Дождётся готовности ES (healthcheck)
- Выполнит демонстрацию поиска
- Остановит контейнеры

## Требования

- Docker
- Python 3.7+
- pip

## Результат

Вы увидите вывод примерно такого вида:

```
Creating index...
Indexing documents...
Searching for 'python'...
Found X results in Y seconds
...
```

Elasticsearch обеспечивает быстрый полнотекстовый поиск!

## Файлы

- `docker-compose.yml` — конфигурация Elasticsearch
- `fts.py` — скрипт демонстрации поиска
- `requirements.txt` — Python-зависимости
- `run.sh` — скрипт запуска

## Очистка

Для удаления Docker-образов:
```bash
docker compose down
```

Для удаления данных (включая volumes):
```bash
docker compose down -v
```
