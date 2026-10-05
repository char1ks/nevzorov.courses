# 01-index-speedup-pg — Ускорение запросов с индексами PostgreSQL

Этот стенд демонстрирует, как индексы значительно ускоряют поиск данных в PostgreSQL.

## Что делает стенд

1. Создаёт таблицу `test` с 1 миллионом записей
2. Замеряет среднее время поиска 100 случайных значений БЕЗ индекса
3. Создаёт индекс `idx_value` на поле `value`
4. Замеряет среднее время поиска С индексом
5. Выводит сравнение результатов

## Как запустить

```bash
./run.sh
```

Скрипт автоматически:
- Установит Python-зависимости
- Запустит PostgreSQL в Docker
- Дождётся готовности базы (healthcheck)
- Выполнит benchmark
- Остановит контейнеры

## Требования

- Docker
- Python 3.7+
- pip

## Результат

Вы увидите вывод примерно такого вида:

```
Inserting 1M rows...
Inserted 100000 rows...
Inserted 200000 rows...
...
Inserted 1000000 rows...
Benchmarking without index...
Avg search time (no index): 0.123456 sec
Creating index...
Benchmarking with index...
Avg search time (with index): 0.000123 sec
```

Индекс ускоряет поиск в сотни раз!

## Файлы

- `docker-compose.yml` — конфигурация PostgreSQL
- `index_speedup.py` — скрипт benchmark'а
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
