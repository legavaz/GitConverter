# Саммария: Инструменты, Плагины, Скиллы и Правила

> **Дата составления:** 05.09.2026  
> **Окружение:** Windows (win32)  
> **Рабочий каталог:** `C:\project\0509`  
> **Пользователь:** lega (Влад Дани, legavaz@gmail.com)

---

## Краткая статистика

| Категория | Количество | Местоположение |
|---|---|---|
| **Инструменты** (софт) | 10+ | `C:\Program Files\*` |
| **Плагины** (VS Code + MCP) | 3 расширения + 9 MCP серверов | `~/.vscode/extensions`, `~/.cline/data/settings/` |
| **Скиллы** (Cline skills) | 75 активных + 12 дополнительных | `C:\Users\lega\.cline\skills\` |
| **Правила** (rules + agents + commands) | 40 правил + 13 агентов + 17 команд + 11 адаптеров | `c:\va\AI\_ai_rules_1c\` |

---

## Инструменты (Tools)

| Инструмент | Версия | Путь |
|---|---|---|
| **1С:Предприятие** | 8.3.27.1989 + 8.3.27.2325 | `C:\Program Files\1cv8\` |
| **Git** | 2.x | `C:\Program Files\Git\` |
| **Node.js** | 24.20.0 | `C:\Program Files\nodejs\` |
| **npm** | — | `C:\Program Files\nodejs\` |
| **VS Code** | 1.136.1 | `C:\Program Files\Microsoft VS Code\` |
| **7-Zip** | — | `C:\Program Files\7-Zip\` |
| **Notepad++** | — | `C:\Program Files\Notepad++\` |
| **Total Commander** | — | `C:\Program Files\totalcmd\` |
| **.NET runtime** | — | `C:\Program Files\dotnet\` |
| **MSBuild** | — | `C:\Program Files\MSBuild\` |


---

## Плагины (Plugins)

### VS Code Extensions (3)

| Расширение | Версия | Описание |
|---|---|---|
| `1c-syntax.language-1c-bsl` | 2.1.1 | Поддержка языка BSL для 1С:Предприятие |
| `ms-ceintl.vscode-language-pack-ru` | 1.131.2026090407 | Русский язык для VS Code |
| `saoudrizwan.claude-dev` | 4.1.17 | Claude Dev (Cline) — AI агент |

### MCP Серверы (9)

| MCP Server | URL/Порт | Описание |
|---|---|---|
| **mcp-VA** (активный) | `http://127.0.0.1:8080/mcp` | Vanessa Automation — тестирование, автоматизация, скриншоты |
| **1c-code-metadata-mcp** | `http://localhost:8000/mcp` | Метаданные, навигация, XSD, формы |
| **1c-syntax-checker-mcp** | `http://localhost:8002/mcp` | Валидация BSL-синтаксиса |
| **1C-docs-mcp** | `http://localhost:8003/mcp` | Документация платформы 1С |
| **1c-templates-mcp** | `http://localhost:8004/mcp` | Библиотека шаблонов кода |
| **1c-graph-metadata-mcp** | `http://localhost:8006/mcp` | Граф-запросы метаданных (Neo4j/Cypher) |
| **1c-code-check-mcp** | `http://localhost:8007/mcp` | Code review и quality check (1С:Напарник) |
| **1c-ssl-mcp** | `http://localhost:8008/mcp` | Поиск по Стандартным подсистемам (БСП/SSL) |
| **1c-data-mcp** | `{INFOBASE_PUBLISH_URL}/hs/mcp` | Управление данными 1С |

**Подробности:** [plugins.md](plugins.md)

---

## Скиллы (Skills)

**75 активных навыков** установлено в `C:\Users\lega\.cline\skills\` (Cline).  
**12 дополнительных навыков** в `c:\va\AI\_ai_rules_1c\content\skills\`.

Скиллы сгруппированы по функциональным областям:

| Группа | Кол-во |
|---|---|
| Конфигурация (CF) | 6 |
| Расширения (CFE) | 6 |
| Внешние обработки (EPF) | 8 |
| Внешние отчёты (ERF) | 2 |
| Формы | 7 |
| Метаданные | 5 |
| СКД | 5 |
| Макеты (MXL) | 5 |
| Подсистемы | 5 |
| Роли | 3 |
| Интерфейсы | 2 |
| Шаблоны | 2 |
| База данных | 9 |
| Веб | 6 |
| Валидация + запросы | 4 |
| Тестирование | 3 |
| Прочее | 4 |

**Подробности:** [skills.md](skills.md)

---

## Правила (Rules)

| Компонент | Кол-во | Местоположение |
|---|---|---|
| **Cline rules** (`.clinerules`) | 1 файл (13,9 КБ) | `c:\va\AI\тест1\.clinerules` |
| **Rule-файлы** (on-demand) | 40 файлов | `_ai_rules_1c\content\rules\` |
| **AGENTS.md** | 1 файл (58,7 КБ) | `_ai_rules_1c\AGENTS.md` |
| **Агенты (subagents)** | 13 | `_ai_rules_1c\content\agents\` |
| **Команды (slash-commands)** | 17 | `_ai_rules_1c\content\commands\` |
| **Адаптеры** | 11 | `_ai_rules_1c\adapters\` |

**Подробности:** [rules.md](rules.md)

---

## Конфигурация Cline / Claude Dev

| Параметр | Значение |
|---|---|
| **Версия** | 4.1.17 (claude-dev) |
| **Режим** | act |
| **Язык** | Russian - Русский |
| **Модель** | `z-ai/glm-5.3-flash` / `deepseek/deepseek-v4-flash` |
| **Провайдеры** | cline (poolside/laguna-s-2.1:free), sapaicore (claude-3.5-sonnet) |
| **Автоодобрение** | ✅ включено |
| **Терминал** | cmd |

---

_Сводка создана на основе исследования окружения 05.09.2026._
