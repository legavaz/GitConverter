# Правила (Rules)

> **Дата составления:** 05.09.2026  
> **Базовый репозиторий:** `c:\va\AI\_ai_rules_1c` (https://github.com/comol/ai_rules_1c)  
> **Поставщик:** comol / 1c-rules

---

## Иерархия правил

```
c:\va\AI\
├── _ai_rules_1c/                          ← Источник (база)
│   ├── AGENTS.md                          ← always-on контекст (58,7 КБ)
│   ├── LLM-RULES.md                       ← Agent-поддерживаемые правила
│   ├── USER-RULES.md                      ← Пользовательские правила
│   ├── memory.md                          ← Долговременная память проекта
│   ├── README.md (6,2 КБ)                 ← Обзор репозитория
│   ├── AGENT-INSTALL.md (52,5 КБ)         ← Инструкция установки
│   ├── install.ps1 (235 КБ)               ← PowerShell-установщик
│   ├── .dev.env.example (49 КБ)           ← Шаблон конфигурации
│   ├── adapters/                          ← 11 адаптеров для ИИ-агентов
│   │   ├── cline.yaml, claude-code.yaml, cursor.yaml, codex.yaml
│   │   ├── kilocode.yaml, kimi.yaml, qwen.yaml, command-code.yaml
│   │   ├── opencode.yaml, pi.yaml, other.yaml
│   ├── content/
│   │   ├── rules/                         ← 40 rule-файлов (on-demand)
│   │   ├── agents/                        ← 13 агентов (subagents)
│   │   ├── commands/                      ← 17 slash-команд
│   │   ├── skills/                        ← 11 доп. навыков
│   │   └── openspec/                      ← Спецификации (specs, changes)
│   └── tools/
│       ├── refresh-openspec-bundle.ps1    ← Обновление openspec
│       └── validate-rules.ps1             ← Валидация правил (20,8 КБ)
│
├── Скилы_220826/                          ← Установленный набор (8.22.2026)

---

## 1. Cline Rules (`.clinerules`)

**Файл:** `c:\va\AI\тест1\.clinerules`  
**Размер:** 13 932 байт  
**Статус:** ✅ Активен (в `localClineRulesToggles` workspace `f12b3ab`)

Это **Cline-специфичные правила** для проекта `тест1`. Правила загружаются Cline автоматически для этого workspace.

### Ключевые правила

#### Работа со скриншотами (обязательно!)
- При получении результата с ссылкой на файл — немедленно читать через `read_file`
- Скриншоты клиентов тестирования (.png из `features/png/`) читать НЕМЕДЛЕННО
- Перед любым изменением кода — анализировать скриншоты и логи
- Никогда не вносить исправления на основе предположений

#### КРИТИЧЕСКОЕ: проверка скриншотами после КАЖДОГО действия с формой
1. Сделать скриншот через `get_window_screenshot_os`
2. Прочитать скриншот через `read_file`
3. Проанализировать скриншот
4. ТОЛЬКО после анализа — переход к следующему шагу

**Без скриншота НЕЛЬЗЯ:**
- Переходить к следующему шагу сценария
- Считать действие выполненным
- Менять состояние формы
- Вызывать `attempt_completion`

#### Запрет на самостоятельные решения о порядке выполнения
- **НЕЛЬЗЯ** отклоняться от явных инструкций (InstructionsResearch.md, InstructionsWriteScenario.md)
- **НЕЛЬЗЯ** использовать упрощённые параметры (например, `format=short_info`)
- **НЕЛЬЗЯ** пропускать шаги инструкции

#### Запрет на самостоятельное прекращение выполнения сценариев
- **НЕЛЬЗЯ** завершать задачу после частичного выполнения
- **НЕЛЬЗЯ** вызывать `attempt_completion` если план содержит невыполненные сценарии
- Продолжать выполнение ВСЕХ сценариев из плана

#### Запрет на закрытие клиента тестирования без разрешения
- **КАТЕГОРИЧЕСКИ НЕЛЬЗЯ** вызывать `close_test_client` без прямой команды пользователя
- Клиент остаётся подключенным до явной команды на закрытие

### Загруженные файлы в проекте `тест1`
| Файл | Размер | Описание |
|---|---|---|
| `InstructionsResearch.md` | 21 549 байт | Инструкции по исследованию |
| `InstructionsWriteScenario.md` | 19 353 байт | Инструкции по написанию сценариев |
| `1.Исследование.md` | 592 байт | План исследования |
| `2.Сценарий.md` | 633 байт | Сценарий выполнения |
| `ОписаниеЗадачи.md` | 1 406 байт | Описание задачи |

---

## 2. Rule-файлы (on-demand) — 40 файлов

**Местоположение:**
- Источник: `c:\va\AI\_ai_rules_1c\content\rules\`
- Установлено: `c:\va\AI\Скилы_220826\.ai-agent\rules\` (40 файлов, версия 410951e)

On-demand правила — загружаются по необходимости через роутинг из `AGENTS.md`. Не загружаются все сразу, чтобы не перегружать контекст.

### Категории правил

| Категория | Кол-во | Файлы |
|---|---|---|
| Стандарты разработки | 6 | coding-standards, dev-standards-core, dev-standards-architecture, dev-standards-code-style, dev-standards-change-markers, dev-standards-env |
| Формы | 5 | forms, forms-add, form-patterns, form-module, async-methods |
| Запросы и данные | 4 | query-design, registers-design, dcs-design, dcs-advanced-composition |
| Метаданные и расширения | 3 | extension-patterns, metadata-xml-workarounds, getconfigfiles |
| Модели | 5 | model-adaptation, model-fable5, model-gpt56, model-opus5, model-sonnet5 |
| Верификация | 4 | verification-checklist, verification-gates, verification-policy, verification-delivery |
| Subagents | 2 | subagents, subagent-pipeline |
| Инструменты и отладка | 4 | tooling-playbooks, systematic-debugging, mcp-first-search, ui-testing-tools |
| Дополнительно | 7 | anti-patterns, bsp-access-rights, locks-and-transactions, logging-strategy, integrations-add, platform-solutions, orchestrator-economy, module-structure, web-client-driving |

### Полный список (40 файлов в content/rules/)

| № | Файл | Категория | Кратко |
|---|---|---|---|
| 1 | `coding-standards.md` | Стандарты | Coding standards, forbidden constructs, code review, queries |
| 2 | `dev-standards-core.md` | Стандарты | Роутер: направляет на companion rules |
| 3 | `dev-standards-architecture.md` | Стандарты | Архитектурные паттерны, extensions, platform standards |
| 4 | `dev-standards-code-style.md` | Стандарты | BSL code style, formatting, naming, public API, forbidden constructs |
| 5 | `dev-standards-change-markers.md` | Стандарты | Модификационные маркеры, naming conventions |
| 6 | `dev-standards-env.md` | Стандарты | Параметры проекта из .dev.env |
| 7 | `forms.md` | Формы | Точка входа для работы с формами |
| 8 | `forms-add.md` | Формы | Создание/изменение Form.xml + Form.Module.bsl |
| 9 | `form-patterns.md` | Формы | Паттерны layout: document, list, catalog, wizard |
| 10 | `form-module.md` | Формы | Form-module code: client-server, event wiring |
| 11 | `async-methods.md` | Формы | Асинхронные методы (Асинх/Ждать) 8.3.18+ |
| 12 | `query-design.md` | Запросы | Точка входа для запросов, роутер на companions |
| 13 | `registers-design.md` | Запросы | Проектирование регистров |
| 14 | `dcs-design.md` | Запросы | СКД/DCS: data sets, parameters, variants |
| 15 | `dcs-advanced-composition.md` | Запросы | Двухпроходная обработка, direct composition |
| 16 | `extension-patterns.md` | Метаданные | Паттерны CFE: interceptors, adopted objects |
| 17 | `metadata-xml-workarounds.md` | Метаданные | Обходные пути для XML метаданных |
| 18 | `getconfigfiles.md` | Метаданные | Экспорт конфигурации из ИБ |
| 19 | `model-adaptation.md` | Модели | Выбор модели по AGENT_MODEL, profiles |
| 20 | `model-fable5.md` | Модели | Профиль модели fable5 |
| 21 | `model-gpt56.md` | Модели | Профиль модели gpt56 |
| 22 | `model-opus5.md` | Модели | Профиль Claude Opus 5 |
| 23 | `model-sonnet5.md` | Модели | Профиль Claude Sonnet 5 |
| 24 | `orchestrator-economy.md` | Модели | Economy mode: делегирование на cheaper subagents |
| 25 | `verification-checklist.md` | Верификация | Роутер: triage, hard gates, delivery |
| 26 | `verification-gates.md` | Верификация | Верификационные ворота: syntax, logic, style, XML |
| 27 | `verification-policy.md` | Верификация | Политика: depth levels, quick-fix eligibility |

---

## 3. AGENTS.md — основной always-on контекст

**Файл:** `c:\va\AI\_ai_rules_1c\AGENTS.md`  
**Размер:** 58 748 байт  
**Статус:** ✅ Всегда загружается агентом

AGENTS.md — корневой файл, содержащий персонажа, процесс разработки, принципы, MCP-инструменты, стандарты кода и дисциплину вызовов инструментов. Для Cline это always-on контекст (читается из корня проекта).

### Структура AGENTS.md

| Раздел | Содержание |
|---|---|
| **Persona** | Senior 1C developer (10+ лет), BSL + платформа + БСП |
| **Core Principles** | Step-by-step, ask when unsure, production-safe, platform-first, templates-first, DRY |
| **Process** | 5 шагов: Think → Simple → Validate → Deliver → Learn |
| **MCP Tool Calling** | Жёсткие обязательства: A.1-A.9 (metadata, templates, syntax, queries, deployment) |
| **Rules routing** | Как загружать on-demand правила через routing tables |
| **Verification** | 5 gates: syntax → logic → style → impact → XML |
| **Delivery report** | Обязательные секции в финальном отчёте |
| **Rules self-improvement** | Как правила эволюционируют (`/evolve`) |
| **Project memory** | Маршрутизация между `memory.md` и `1c-templates-mcp recall` |

---

## 4. LLM-RULES.md, USER-RULES.md, memory.md

| Файл | Размер | Описание |
|---|---|---|
| `LLM-RULES.md` | 329 байт | Agent-поддерживаемые behavior rules. Пишутся командой `/evolve` с approval. Последний запуск: Never. |
| `USER-RULES.md` | 131 байт | Пользовательские правила (пусто — мигрированный контент пуст) |
| `memory.md` | 851 байт | Долговременная память проекта. Entry format: дата, scope, rule, why, source |

---

## 5. Агенты (subagents) — 13

**Местоположение:** `c:\va\AI\_ai_rules_1c\content\agents\` (источник) + `c:\va\AI\Скилы_220826\.ai-agent\agents/` (установлено)

| # | Агент | Описание |
|---|---|---|
| 1 | `analytic` | Expert 1C business analyst. Analyzes code/metadata, writes PRD, specifications. Creates docs without writing code. |
| 2 | `arch-reviewer` | Expert 1C architecture reviewer. Reviews design patterns, scalability, best practices. Confidence-scored feedback. |
| 3 | `architect` | Expert 1C solution architect. Designs architecture, analyzes patterns, defines boundaries/data flows. |
| 4 | `code-reviewer` | Expert 1C code reviewer. Reviews for bugs, readability, standards. Confidence-based filtering. |
| 5 | `developer` | Expert 1C code developer. Creates modules, procedures, queries, forms. Uses MCP tools. |
| 6 | `doc-writer` | Expert 1C documentation specialist. User guides, admin manuals, tutorials, API references. |
| 7 | `error-fixer` | Expert 1C error resolution. Fixes syntax/runtime errors with minimal changes. |
| 8 | `explorer` | Read-only codebase exploration. MCP-first chain: graph → metadata → templates → SSL → docs → ITS → grep. |
| 9 | `metadata-manager` | 1C metadata management. Creates/edits/validates configuration objects, forms, СКД, MXL, roles, EPF/ERF, CFE, CF. |
| 10 | `performance-optimizer` | Expert 1C performance. Analyzes slow code, optimizes queries, identifies bottlenecks. |
| 11 | `planner` | Expert 1C planning. Creates implementation plans for complex features/refactoring. |
| 12 | `refactoring` | Expert 1C refactoring. Dead code cleanup, consolidation, technical debt reduction. |
| 13 | `tester` | Expert 1C testing. Web browser automation, /deploy-and-test, UI testing. |

---

## 6. Slash-команды (commands) — 17

**Местоположение:** `c:\va\AI\_ai_rules_1c\content\commands/` (источник) + `c:\va\AI\Скилы_220826\.ai-agent\commands/` (установлено)

| # | Команда | Описание |
|---|---|---|
| 1 | `caveman` | Переключить стиль «пещерного» ответа (CAVEMAN в .dev.env) |
| 2 | `check-uuid` | Проверка дубликатов UUID в XML конфигурации |
| 3 | `checkmcp` | Проверка доступности 1C MCP серверов и установка недостающих |
| 4 | `deploy-and-test` | Загрузка конфигурации в тестовую ИБ + UI-тесты в веб-клиенте |
| 5 | `doctor` | Диагностика установки 1c-rules в проекте |
| 6 | `economymode` | Переключить orchestrator economy mode (ORCHESTRATION) |
| 7 | `evolve` | Агрегация сигналов правил → user-approved rules в LLM-RULES.md |

---

## 7. Адаптеры (adapters) — 11

Адаптеры описывают, как копировать и адаптировать файлы из `content/` для каждого ИИ-агента.

| # | Адаптер | Целевой инструмент | Путь установки |
|---|---|---|---|
| 1 | `cline.yaml` | Cline | `.cline/rules-1c/`, `.cline/agents/`, `.cline/skills/` |
| 2 | `claude-code.yaml` | Claude Code | `.claude/rules-1c/`, `.claude/agents/`, `.claude/commands/` |
| 3 | `cursor.yaml` | Cursor | `.cursor/rules/`, `.cursor/agents/`, `.cursor/commands/`, `.cursor/skills/` |
| 4 | `codex.yaml` | OpenAI Codex CLI | `.codex/rules/`, `.codex/agents/`, `.codex/skills/`, `.codex/config.toml` |
| 5 | `kilocode.yaml` | Kilo Code | `.kilo/rules-1c/`, `.kilo/commands/`, `.kilo/agents/`, `.kilo/skills/` |
| 6 | `kimi.yaml` | Kimi Code CLI | `.kimi-code/rules-1c/`, `.kimi-code/agents/`, `.kimi-code/skills/`, `.kimi-code/mcp.json` |
| 7 | `qwen.yaml` | Qwen Code | `.qwen/rules-1c/`, `.qwen/agents/`, `.qwen/commands/`, `.qwen/skills/` |
| 8 | `command-code.yaml` | Command Code | `.commandcode/rules-1c/`, `.commandcode/agents/`, `.commandcode/commands/`, `.commandcode/skills/` |
| 9 | `opencode.yaml` | OpenCode | `.opencode/command/` |
| 10 | `pi.yaml` | Pi | `.pi/rules-1c/`, `.pi/prompts/` для команд |
| 11 | `other.yaml` | Aider/Continue/Cody и др. | `.ai-agent/rules/`, `.ai-agent/agents/`, `.ai-agent/commands/`, `.ai-agent/skills/`, `.ai-agent/mcp.json` |

### Ключевые принципы адаптеров

- **Always-on контекст:** root `AGENTS.md` (для Cline, Claude Code, Cursor, Codex)
- **On-demand правила:** `.cline/rules-1c/{name}.md` (для Cline) — НЕ в `.clinerules/` чтобы не перегружать контекст
- **MCP:** только глобальный для Cline (`~/.cline/data/settings/cline_mcp_settings.json`), проектный не пишется
- **Назад совместимость:** detection принимает `.cline/` и `.clinerules/`

---

## 8. Манифест (.ai-rules.json)

**Файл:** `c:\va\AI\Скилы_220826\.ai-rules.json`

| Поле | Значение |
|---|---|
| `protocol` | 1.1 |
| `source` | `C:\Users\lega\AppData\Local\Temp\1c-rules` |
| `version` | 410951e |
| `installedAt` | 2026-08-22T13:07:12Z |
| `updatedAt` | 2026-08-22T13:07:12Z |
| `lastChannel` | powershell |
| `language` | en |

### MCP серверы (из манифеста)

8 MCP серверов зарегистрированы в манифесте:
`1c-code-metadata-mcp`, `1c-syntax-checker-mcp`, `1C-docs-mcp`, `1c-templates-mcp`, `1c-graph-metadata-mcp`, `1c-code-check-mcp`, `1c-ssl-mcp`, `1c-data-mcp`

### Структура манифеста
```
.ai-agent/
├── rules/           ← 40 rule-файлов (все alwaysApply: false)
├── agents/          ← 13 агентов
├── commands/        ← 17 команд
├── skills/          ← 12 навыков
└── mcp.json         ← 8 MCP серверов
```

---

## 9. Ключевые параметры .dev.env

Из `c:\va\AI\Скилы_220826\.dev.env`:

| Параметр | Значение | Описание |
|---|---|---|
| `COMPANY` | `кст` | Компания для маркеров доработки |
| `DEVELOPER` | `dvi` | Разработчик для маркеров |
| `PLATFORM_VERSION` | `8.3.27` | Минимальная версия платформы |
| `CAVEMAN` | (on/auto/off) | Режим кратких ответов |
| `VERIFICATION_DEPTH` | (full/standard/lite) | Глубина проверки |
| `UI_TESTING` | (on/off) | UI тестирование |
| `ORCHESTRATION` | (economy) | Режим оркестровки |
| `AGENT_MODEL` | — | Выбор профиля модели |
| `INFOBASE_PUBLISH_URL` | — | URL для 1c-data-mcp |
| `V8PATH` | — | Путь к платформе 1С |

> Полный файл `.dev.env` — 50 КБ, содержит параметры для: code-generation, infobase operations, UI testing, subagent models, verification, MCP, orchestration.

---

## 10. Связь между компонентами

```
_ai_rules_1c/              ← Источник (GitHub: comol/ai_rules_1c)
    │
    ├── install.ps1 ──────► Скилы_220826/.ai-agent/  (универсальный формат other)
    │                           ├── rules/         (40 правил)
    │                           ├── agents/        (13 агентов)
    │                           ├── commands/      (17 команд)
    │                           ├── skills/        (12 навыков)
    │                           └── mcp.json       (8 MCP серверов)
    │
    ├── cline.yaml ───────► C:\Users\lega\.cline\     (Cline format)
    │                           ├── skills/          (75 активных навыков)
    │                           └── data/settings/   (cline_mcp_settings.json)
    │
    └── adapters/*.yaml   ← Адаптеры для 11 ИИ-инструментов

c:\va\AI\тест1\.clinerules  ← Cline-specific rules для тестового проекта
```

| 8 | `getconfigfiles` | Экспорт конфигурации из ИБ в файлы |
| 9 | `install-agent-browser` | Установка agent-browser для UI тестирования |
| 10 | `install-windows-mcp` | Установка Windows-MCP (desktop UI automation) |
| 11 | `installmcp` | Скачивание и установка 1C MCP серверов с vibecoding1c.ru |
| 12 | `litemode` | Переключить VERIFICATION_DEPTH (full/standard/lite) |
| 13 | `loadfrom1cbase` | Dump конфигурации из ИБ в репозиторий |
| 14 | `rulesmodel` | Адаптировать ruleset к используемой модели (AGENT_MODEL) |
| 15 | `update1cbase` | Загрузка файлов в ИБ + обновление структуры БД |
| 16 | `updatemcp` | Обновление 1C MCP серверов и перезапуск |
| 17 | `updaterules` | Обновление 1c-rules ruleset с GitHub |

| 28 | `verification-delivery.md` | Верификация | Delivery gates: repro, review, UI testing |
| 29 | `subagents.md` | Subagents | Когда делегировать subagent vs выполнять напрямую |
| 30 | `subagent-pipeline.md` | Subagents | Конвейер: planner → developer → reviewer → verifier |
| 31 | `tooling-playbooks.md` | Инструменты | MCP tool playbooks: code, review, refactor |
| 32 | `systematic-debugging.md` | Инструменты | 4-фазная отладка |
| 33 | `mcp-first-search.md` | Инструменты | MCP-first поиск: graph → metadata → templates |
| 34 | `ui-testing-tools.md` | Инструменты | UI testing: agent-browser, Windows-MCP |
| 35 | `anti-patterns.md` | Доп. | Анти-паттерны и severity catalog |
| 36 | `bsp-access-rights.md` | Доп. | БСП профили доступа, права, RLS |
| 37 | `locks-and-transactions.md` | Доп. | Блокировки, транзакции, deadlock prevention |
| 38 | `logging-strategy.md` | Доп. | Стратегия логирования |
| 39 | `integrations-add.md` | Доп. | Интеграции: HTTP, REST, очереди |
| 40 | `platform-solutions.md` | Доп. | Кейсы типичных проблем платформы и fix templates |

> Также присутствуют: `module-structure.md` (шаблоны регионов модулей), `web-client-driving.md` (управление веб-клиентом). Всего в `content/rules/` — 42 файла.

| `РегистрыСведений.md` | 6 808 байт | Справка о регистрах |
| `*.feature` (3 файла) | 592+4 733+16 278 байт | Cucumber-сценарии |

│   ├── .ai-agent/                         ← Универсальный формат (other адаптер)
│   │   ├── rules/                         ← 40 скопированных rule-файлов
│   │   ├── agents/                        ← 13 агентов
│   │   ├── commands/                      ← 17 команд (без deploy-and-test)
│   │   ├── skills/                        ← 12 доп. навыков
│   │   └── mcp.json                       ← 8 MCP серверов
│   ├── AGENTS.md, LLM-RULES.md            ← Скопированы из источника
│   ├── USER-RULES.md, memory.md           ← Скопированы из источника
│   ├── .dev.env                           ← Параметры проекта
│   └── .ai-rules.json                     ← Манифест (version 410951e)
│
└── тест1/                                 ← Тестовый проект
    └── .clinerules                        ← Cline-specific rules (13,9 КБ)
```
