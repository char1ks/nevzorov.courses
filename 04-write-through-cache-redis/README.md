# 04-write-through-cache-redis — Кэширование Write-Through с Redis

Этот стенд демонстрирует паттерн кэширования Write-Through с использованием Redis и PostgreSQL.

## Что делает стенд

1. Запускает PostgreSQL и Redis в Docker
2. Реализует паттерн Write-Through:
   - При записи данные сохраняются одновременно в БД и в кэш
   - При чтении данные берутся из кэша (если есть)
3. Демонстрирует ускорение чтения из кэша по сравнению с чтением из БД

## Как запустить

```bash
./run.sh
```

Скрипт автоматически:
- Установит Python-зависимости
- Запустит PostgreSQL и Redis в Docker
- Дождётся готовности сервисов (healthcheck)
- Выполнит демонстрацию кэширования
- Остановит контейнеры

## Требования

- Docker
- Python 3.7+
- pip

## Результат

Вы увидите вывод примерно такого вида:

```
Writing data to DB and cache...
Reading from cache: 0.001 seconds
Reading from DB: 0.023 seconds
Cache speedup: 23x
```

Кэш Redis значительно ускоряет чтение данных!

## Файлы

- `docker-compose.yml` — конфигурация PostgreSQL и Redis
- `write_through_cache.py` — скрипт демонстрации кэширования
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
