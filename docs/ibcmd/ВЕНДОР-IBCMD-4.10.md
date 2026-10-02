# ibcmd по вендорской документации (1С:Предприятие 8.3.27, Приложение 4, разд. 4.10)

Выжимка для практического использования. Источник и метод извлечения — в [README.md](README.md).

## 1. Общий синтаксис

```
ibcmd mode command [command] [--parameter[=value]] [--parameter[=value]]
ibcmd --version
ibcmd --help
```

| Элемент | Смысл |
|---|---|
| `mode` | режим работы утилиты |
| `command` | команда режима; бывают **многословные** — `ibcmd infobase config load` |
| `--parameter[=value]` | параметр команды; в строке их может быть несколько, разделитель — **пробел** |

Ключевые свойства:

- **приоритет**: параметры командной строки важнее значений конфигурационного файла автономного сервера;
- **формат справки**: параметры упорядочены по алфавиту, обязательные подчёркнуты (`--req-param`);
- `ibcmd` пишет **UTF-8** (проверено на 8.3.24 / 8.3.27 / 8.5 — совпадает с поведением скиллов).

## 2. Подключение: две группы параметров

### 2.1. Работающий автономный сервер (только эти параметры)

| Параметр | Смысл |
|---|---|
| `--pid=<pid>`, `-p <pid>` | подключиться к автономному серверу **на этом же компьютере** |
| `--remote=<url>`, `-r <url>` | сетевой адрес шлюза администрирования — сервер может быть **на другой машине** |

Параметров базы данных здесь нет намеренно: работающий автономный сервер сам знает, с какой СУБД и базой работает.

### 2.2. Offline-режим (сервер не запущен)

Много больше параметров — команды работают с информационной базой напрямую.

| Параметр | Смысл |
|---|---|
| `--config=<path>`, `-c` | конфигурационный файл автономного сервера |
| `--data=<path>`, `-d` | каталог данных сервера (ОС Linux: `~/.1cv8/standalone-server`; Windows: `%LOCALAPPDATA%\1C\1cv8\standalone-server`) |
| `--dbms=<kind>` | тип СУБД: `MSSQLServer` \| `PostgreSQL` \| `IBMDB2` \| `OracleDatabase`. **Не задан → файловая БД** |
| `--database-name=<name>` / `--db-name=<name>` | имя базы данных |
| `--database-server=<address>` / `--db-server=<address>` | имя сервера СУБД |
| `--database-user=<name>` / `--db-user=<name>` | имя пользователя сервера СУБД |
| `--database-password=<password>` / `--db-pwd=<password>` | пароль пользователя сервера СУБД |
| `--request-database-password` / `--request-db-pwd` / `-W` | запросить пароль СУБД через **stdin** |
| `--database-path=<path>` / `--db-path=<path>` | каталог файловой БД (относительный путь — от каталога данных сервера; по умолчанию `db-data`) |
| `--user=<name>`, `-u` | пользователь информационной базы |
| `--password=<password>`, `-P` | пароль пользователя информационной базы |
| `--temp=<path>`, `-t` | каталог временных файлов (по умолчанию `temp`) |
| `--system=<path>` | системный конфигурационный файл |
| `--log-data=<path>` | каталог данных журнала регистрации (по умолчанию `log-data`) |
| `--users-data=<path>` | конфигурационные данные пользователей (по умолчанию `users-data`) |
| `--session-data=<path>` | каталог сеансовых данных |
| `--lock=<path>` | файл блокировки каталога данных (по умолчанию `lock.pid`) |
| `--ftext-data=<path>`, `--ftext2-data=<path>` | данные полнотекстового поиска |
| `--openid-data=<path>`, `--stt-data=<path>` | данные OpenID-аутентификации / распознавания речи |

**Важно:** в offline-режиме **недоступны режимы `session` и `lock`** — у неработающего сервера нет ни сеансов, ни блокировок.

## 3. Режимы работы

| Режим | Назначение |
|---|---|
| `server` | настройка автономного сервера (`config init`, `config import`) |
| `infobase` | управление информационной базой |
| `config` | сокращение для `ibcmd infobase config …` (полностью эквивалентен) |
| `extension` | сокращение для `ibcmd infobase config extension …` (полностью эквивалентен) |
| `mobile-app` | экспорт конфигурации мобильного приложения |
| `mobile-client` | экспорт и подпись конфигурации мобильного клиента |
| `session` | сеансы информационной базы (только работающий сервер) |
| `lock` | блокировки (только работающий сервер) |
| `eventlog` | журнал регистрации |

Режимы `mobile-app` и `mobile-client` требуют включённого параметра `extended-designer-features`
конфигурационного файла автономного сервера.

## 4. Режим `server`

| Команда | Параметры |
|---|---|
| `server config init` | `--id=<uuid|auto>` (по умолчанию `auto`), `--name/-n`, `--out/-o`, `--address/-a` (`localhost` \| `any` \| IPv4 \| IPv6; по умолчанию `localhost`), `--http-port`/`--port`/`-p` (по умолчанию **8314**), `--http-base`/`--base`/`-b` (по умолчанию `/`), `--publication/-p` (файл `default.vrd`), `--schedule-jobs=<allow\|deny\|yes\|no\|true\|false>` (по умолчанию `allow`), `--distribute-licenses` (по умолчанию `allow`), `-W` |
| `server config import` | импорт конфигурации автономного сервера **из реестра существующего кластера** `1С:Предприятие`: `--cluster-data=<path>` (по умолчанию `%LOCALAPPDATA%/1C/1cv8`), `--manager-port=<port>` (по умолчанию **1541**), `--name/-n`, `--out/-o`, `--port`, `--address/-a`, `--base/-b` |

## 5. Режим `infobase` — операции с базой

| Команда | Параметры | Смысл |
|---|---|---|
| `infobase create` | `--create-database`, `--load=<cf>`, `--import=<dir>` (xml иерархической выгрузки), `--restore=<dt>` (загрузить данные сразу после создания), `--apply` (обновить БД после загрузки конфигурации), `--date-offset=<years>` (только MSSQLServer, по умолчанию 2000), `--force/-F`, `--locale/-l`, `-W` | создать информационную базу |
| `infobase dump <path>` | `--user/-u`, `--password/-P` | выгрузить базу в **dt-файл** (это **не** резервное копирование) |
| `infobase restore <path>` | `--create-database`, `--force/-F` (принудительно завершить сеансы), `--session-terminate-message`, `--user/-u`, `--password/-P` | загрузить базу из dt-файла |
| `infobase clear` | `--user/-u`, `--password/-P` | **очистить** базу |
| `infobase replicate` | `--target-dbms`, `--target-db-name`, `--target-db-server`, `--target-db-user`, `--target-db-pwd`, `--target-db-path`, `--target-create-database`, `--target-date-offset`, `--jobs-count/-j`, `--target-jobs-count/-J`, `--batch-size/-B` (10 000), `--batch-data-size` (10 485 760), `--force`, `--target-request-db-pwd` | конвертация клиент-серверной базы **из одной СУБД в другую без промежуточного dt**. ⚠️ Из **файловой в клиент-серверную — запрещено** из соображений безопасности |

## 6. Режим `infobase config` — конфигурация

### 6.1. Основные команды

| Команда | Параметры |
|---|---|
| `load <path>` | загрузить конфигурацию из cf; `--extension/-e`, `--force/-F` |
| `save <path>` | выгрузить конфигурацию в cf; `--db` (операция над конфигурацией **базы данных**), `--extension/-e` |
| `check` | проверить конфигурацию; `--db`, `--extension/-e` |
| `apply` | обновить конфигурацию БД; `--dynamic=<auto\|disable\|prompt\|force>` (по умолчанию `auto`), `--extension/-e`, `--force/-F`, **`--session-terminate=<disable\|prompt\|force>`** (по умолчанию `disable`), `--session-terminate-message` |
| `reset` | восстановить рабочую конфигурацию из конфигурации БД; `--extension/-e` |
| `repair` | попытка восстановления после незавершённой операции: `--commit`, `--rollback`, `--fix-metadata` |
| `generation-id` | идентификатор поколения конфигурации; `--extension/-e` |
| `sign <path>` | цифровая подпись cf/cfe; `--db`, `--extension/-e`, `--key/-k` (PEM, `.pem`), `--out/-o` |

### 6.2. Группа `export` — выгрузка в xml

⚠️ **Только иерархический формат** (`Plain` не поддерживается).

Общие параметры: `<path>` — каталог выгрузки, `--archive/-A` (упаковать в архив), `--base/-b`
(`ConfigDumpInfo.xml`, от которого считаются изменения), `--extension/-e`, `--force` (полная выгрузка при
несовпадении версии формата), `--ignore-unresolved-refs`, `--sync` (синхронизировать имеющиеся xml с конфигурацией),
`--threads/-T`, `--file/-f` (выгрузить в один файл: конфигурация `*.cf`, расширение `*.cfe`,
обработка `*.epf`, отчёт `*.erf`).

| Команда | Своё |
|---|---|
| `export` | полная / изменённая выгрузка каталога |
| `export info` | сформировать `ConfigDumpInfo.xml`; `--out/-o` |
| `export status` | показать изменения относительно выгрузки; `--base/-b`, `--out/-o`, `--short/-s` |
| `export objects <Object1 … ObjectN>` | выгрузить выбранные объекты; `--out/-o`, `--recursive`, `--archive/-A` |
| `export all-extensions <path>` | выгрузить **все расширения**; `--archive/-A`, `--threads/-T` |

### 6.3. Группа `import` — загрузка из xml

Общие параметры: `<path>` — каталог, `--extension/-e`, `--out/-o` (обязателен при импорте обработки/отчёта),
`--partial` (загрузить только перечисленные файлы), `--no-check` (отключить проверку метаданных после загрузки).

| Команда | Своё |
|---|---|
| `import <path>` | загрузка из каталога; допускает `--archive=<path>` (zip-архив выгрузки), `--base-dir=<dir>` |
| `import files <File1 … FileN>` | загрузка перечисленных файлов; `--archive`, `--base-dir` |
| `import all-extensions <path>` | загрузить **все расширения** |

Файлы `--partial` могут быть: файл описания объекта метаданных; файл внешнего свойства (форма и т. п.);
файл модуля формы.

### 6.4. Группа `support`, `data-separation`

| Команда | Параметры | Смысл |
|---|---|---|
| `support disable` | `--force/-F` | снять конфигурацию с поддержки (вне зависимости от возможности редактирования) |
| `data-separation list` | — | список разделителей информационной базы |

### 6.5. Группа `extension` — расширения

| Команда | Параметры |
|---|---|
| `create` | `--name`, `--name-prefix`, `--purpose=<customization\|add-on\|patch>`, `--synonym` (в формате `НСтр()`) |
| `info` | `--name` |
| `list` | — |
| `update` | `--name`, `--active=<yes\|no>`, `--safe-mode=<yes\|no>`, `--scope=<infobase\|data-separation>`, `--security-profile-name`, `--unsafe-action-protection=<yes\|no>`, `--used-in-distributed-infobase=<yes\|no>` |
| `delete` | `--all` \| `--name` |

Имя расширения должно состоять из одного слова, начинаться с буквы и не содержать специальных символов, кроме `_`.

## 7. Режимы `session`, `lock`, `eventlog`

Только при подключении к **работающему** автономному серверу (не в offline-режиме).

| Команда | Параметры |
|---|---|
| `session info` | `--session=<uuid>`, `--licenses` (информация о лицензиях сеанса) |
| `session list` | `--licenses` |
| `session terminate` | `--session=<uuid>`, `--error-message=<string>` |
| `session interrupt-current-server-call` | `--error-message=<string>` |
| `lock list` | — |
| `eventlog export` | параметры в вендорской выжимке не извлечены — уточнить по стр. 68 документа |

## 8. Что НЕ покрывает ibcmd

- **Кластер `1С:Предприятие`** (обычный `1cv8.exe /S server\ib`): `ibcmd` не администрирует кластер; связь с
  кластером возможна только односторонне — `server config import` читает реестр существующего кластера
  (`--cluster-data`, `--manager-port`) для создания конфигурации автономного сервера.
- Режимы `session` и `lock` в offline-режиме.
- Формат выгрузки `Plain` (только иерархический).
- `chdbfl` — только GUI и только 32-разрядная, только файловая БД (в ibcmd не входит).
