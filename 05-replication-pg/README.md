# 05-replication-pg — Репликация PostgreSQL

Этот стенд демонстрирует мастер-слейв репликацию в PostgreSQL с использованием Docker Compose.

## Что делает стенд

1. Настраивает master-узел PostgreSQL (порт 5432)
2. Настраивает slave-узел с репликацией (порт 5433)
3. Настраивает асинхронную репликацию данных
4. Демонстрирует состояние репликации

## Как запустить

```bash
docker compose up -d
```

Контейнеры запустятся в фоновом режиме. Master и slave уже имеют настроенные healthcheck'и.

## Как проверить репликацию

### Вариант 1: Через docker exec (рекомендуется, не требует установки psql)

#### Подключение к Master

```bash
docker exec -it 05-replication-pg-postgresql-master-1 psql -U postgres -d my_database
```

Пароль: `mysecretpassword`

Внутри psql выполните:
```sql
-- Проверить, что это master (выводит false)
SELECT pg_is_in_recovery();

-- Создать тестовую таблицу
CREATE TABLE test_replication (id SERIAL PRIMARY KEY, data TEXT);

-- Вставить данные
INSERT INTO test_replication (data) VALUES ('test data 1'), ('test data 2');

-- Проверить статус репликации
SELECT pid, client_addr, state, sync_state, sent_lsn, write_lsn, flush_lsn, replay_lsn FROM pg_stat_replication;
```

#### Подключение к Slave

```bash
docker exec -it 05-replication-pg-postgresql-slave-1 psql -U postgres -d my_database
```

Пароль: `mysecretpassword`

### Вариант 2: Через локальный psql (требует установки)

#### Установка psql

**macOS:**
```bash
brew install postgresql
```

**Ubuntu/Debian:**
```bash
sudo apt-get install postgresql-client
```

#### Подключение к Master

```bash
PGPASSWORD=mysecretpassword psql -h 127.0.0.1 -p 5432 -U postgres -d my_database
```

#### Подключение к Slave

```bash
PGPASSWORD=mysecretpassword psql -h 127.0.0.1 -p 5433 -U postgres -d my_database
```

Внутри psql выполните:
```sql
-- Проверить, что это slave (выводит true)
SELECT pg_is_in_recovery();

-- Проверить состояние репликации
SELECT pg_last_wal_receive_lsn(), pg_last_wal_replay_lsn(), pg_last_xact_replay_timestamp();

-- Проверить, что данные реплицировались (только чтение!)
SELECT * FROM test_replication;
```

## Требования

- Docker
- Docker Compose

## Архитектура

- **postgresql-master** — основной узел, принимает записи
- **postgresql-slave** — реплика, только чтение, данные реплицируются асинхронно

## Очистка

Для остановки контейнеров:
```bash
docker compose down
```

Для удаления данных (включая volumes):
```bash
docker compose down -v
```

## Примечания

- Slave работает в режиме read-only
- Репликация асинхронная — возможна небольшая задержка
- Для проверки задержки репликации используйте `pg_last_xact_replay_timestamp()` на slave
