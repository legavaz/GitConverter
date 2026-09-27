# Инструменты (Tools)

> **Дата составления:** 05.09.2026  
> **Окружение:** Windows (win32)

---

## 1. 1С:Предприятие

**Путь:** `C:\Program Files\1cv8\`

### Версии платформы

| Версия | Дата установки | Кол-во файлов | Описание |
|---|---|---|---|
| **8.3.27.2325** | 03.08.2026 | ~2052 | Активная (новее) |
| **8.3.27.1989** | 16.01.2026 | ~2041 | Резервная |

Обе версии находятся в `C:\Program Files\1cv8\8.3.27.2325\` и `C:\Program Files\1cv8\8.3.27.1989\`.

### Конфигурация платформы

Файл конфигурации: `C:\Program Files\1cv8\conf\conf.cfg`  
Содержит: `SystemLanguage=System`

### Ключевые исполняемые файлы (bin)

| Файл | Описание |
|---|---|
| `1cv8.exe` | Главный исполняемый файл (клиент + сервер) |
| `1cv8c.exe` | Клиент (thin client / thick client) |
| `1cv8s.exe` | Сервер 1С:Предприятия |
| `1cv8p64.bin` | 64-битный движок платформы |
| `dumper.exe` | Экспорт/импорт БД (dump) |
| `webinst.exe` | Веб-публикация (настройка Apache/IIS) |
| `instmng.exe` | Менеджер установки |
| `chdbfl.exe` | Проверка файловой БД |
| `cnvdbfl.exe` | Конвертация файловой БД |
| `clsvm64.exe` | Кластерный сервис (64-бит) |
| `dbgs.exe` | Сервис отладки |
| `addnhost64.exe` | Хост внешних компонент (64-бит) |
| `addnhost32.exe` | Хост внешних компонент (32-бит) |

### Установленные компоненты

- `C:\Program Files\1cv8\common\` — общие компоненты
- `C:\Program Files\1cv8\conf\` — конфигурация платформы
- `8.3.27.2325\bin\conf\` — конфигурация bin
- `8.3.27.2325\bin\ExtDst\` — внешние компоненты
- `8.3.27.2325\bin\JavaScriptCore.resources\` — JS движок
- `8.3.27.2325\bin\WebKit.resources\` — WebKit движок
- `8.3.27.2325\licenses\` — лицензии
- `8.3.27.2325\docs\` — документация

---

## 2. Git

**Путь:** `C:\Program Files\Git\`

| Компонент | Путь |
|---|---|
| `git.exe` | `C:\Program Files\Git\cmd\git.exe` |
| bin | `C:\Program Files\Git\bin` |
| dev | `C:\Program Files\Git\dev` |
| mingw64 | `C:\Program Files\Git\mingw64` |

---

## 3. Node.js

**Путь:** `C:\Program Files\nodejs\`

| Компонент | Версия |
|---|---|
| `node.exe` | 24.20.0 |
| `npm` | (через `npm.ps1`) |

---

## 4. Visual Studio Code

**Путь:** `C:\Program Files\Microsoft VS Code\`

| Свойство | Значение |
|---|---|
| Версия | 1.136.1 |
| Commit | a44adf7f53e00964ab890f9f8758a334f1fc15bc |
| Архитектура | x64 |

### Пользовательские настройки

Файл: `C:\Users\lega\AppData\Roaming\Code\User\settings.json`

```json
{
    "files.autoSave": "afterDelay"
}
```

---

## 5. Другие инструменты

| Инструмент | Путь | Примечание |
|---|---|---|
| **7-Zip** | `C:\Program Files\7-Zip\` | Архиватор |
| **Notepad++** | `C:\Program Files\Notepad++\` | Текстовый редактор |
| **Total Commander** | `C:\Program Files\totalcmd\` | Файловый менеджер |
| **.NET runtime** | `C:\Program Files\dotnet\` | .NET Framework/Runtime |
| **MSBuild** | `C:\Program Files\MSBuild\` и `C:\Program Files (x86)\MSBuild\` | Сборка .NET |
| **Intel Management Engine** | `C:\Program Files (x86)\Intel\` | Интеллектуектл. управление |
| **Yandex** | `C:\Program Files\Yandex\` | Браузер/утилиты Яндекс |
| **Google** | `C:\Program Files\Google\` | Сервисы Google |
| **DAUM** | `C:\Program Files\DAUM\` | Мессенджер |
| **Reg Organizer** | `C:\Program Files\Reg Organizer\` | Управление реестром |
| **TecnoPcManager** | `C:\Program Files\TecnoPcManager\` | Управление ПК |
| **qBittorrent** | `C:\Program Files\qBittorrent\` | Торрент-клиент |

---

## 6. Отсутствует

Следующие инструменты **не найдены** в системе:

| Инструмент | Статус |
|---|---|
| **OneScript (oscript)** | ❌ Не установлен |
| **ibcmd** | ❌ Не найден в PATH (упоминается в skill `ibcmd-1c-builds`) |
| **Python** | ❌ Не установлен |

---

## Иерархия установок

```
C:\Program Files\
├── 1cv8/                          ← 1С:Предприятие (2 версии)
│   ├── 8.3.27.2325/
│   ├── 8.3.27.1989/
│   ├── common/
│   └── conf/
├── Git/
├── nodejs/                       ← Node.js 24.20.0 + npm
├── Microsoft VS Code/            ← VS Code 1.136.1
├── 7-Zip/
├── Notepad++/
├── totalcmd/
├── dotnet/
├── MSBuild/
├── Intel/
├── Yandex/
├── Google/
├── DAUM/
├── Reg Organizer/
├── TecnoPcManager/
└── qBittorrent/
```
