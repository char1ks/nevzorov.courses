# 02-index-slowdown-pg — Замедление при избыточных индексах PostgreSQL

Этот стенд демонстрирует негативное влияние избыточных индексов на производительность INSERT-операций.

## Что делает стенд

1. Создаёт таблицу с несколькими индексами
2. Замеряет время вставки пакетов данных С индексами
3. Удаляет все индексы
4. Замеряет время вставки тех же данных БЕЗ индексов
5. Сравнивает результаты

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
Creating table with indexes...
Inserting 100000 rows with indexes...
Time: 5.234 seconds
Dropping indexes...
Inserting 100000 rows without indexes...
Time: 1.123 seconds
```

Индексы замедляют вставку данных в несколько раз!

## Файлы

- `docker-compose.yml` — конфигурация PostgreSQL
- `index_slowdown.py` — скрипт benchmark'а
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
