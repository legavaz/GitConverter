# Оглавление / Индекс

> **Дата составления:** 05.09.2026  
> **Окружение:** Windows (win32) | Cline 4.1.17 | 1С 8.3.27.2325

---

## Файлы саммарии

| Файл | Описание |
|---|---|
| [`sammar.md`](sammar.md) | Главная сводка: обзор всех категорий, конфигурация Cline |
| [`tools.md`](tools.md) | Инструменты: 1С платформа, Git, Node.js, VS Code, прочие утилиты |
| [`plugins.md`](plugins.md) | Плагины: VS Code расширения, MCP серверы |
| [`skills.md`](skills.md) | Скиллы: 75 активных + 12 дополнительных Cline skills |
| [`rules.md`](rules.md) | Правила: .clinerules, 40 rule-файлов, 13 агентов, 17 команд, 11 адаптеров |

---

## Содержание

### 1. Инструменты (Tools) — [tools.md](tools.md)

- **1.1. 1С:Предприятие**
  - Версии: 8.3.27.1989, 8.3.27.2325
  - Ключевые exe: 1cv8, 1cv8c, 1cv8s, dumper, webinst, instmng, chdbfl, cnvdbfl, clsvm64, dbgs
  - Конфиг: `conf.cfg` (SystemLanguage=System)
- **1.2. Git** — `C:\Program Files\Git\`
- **1.3. Node.js** — v24.20.0, `C:\Program Files\nodejs\`
- **1.4. VS Code** — v1.136.1, `C:\Program Files\Microsoft VS Code\`
- **1.5. Другие инструменты** — 7-Zip, Notepad++, Total Commander, .NET, MSBuild, Intel, Yandex, Google, DAUM, Reg Organizer, TecnoPcManager, qBittorrent
- **1.6. Отсутствует** — OneScript (oscript), ibcmd, Python

### 2. Плагины (Plugins) — [plugins.md](plugins.md)

- **2.1. VS Code Extensions (3)**
  - `1c-syntax.language-1c-bsl@2.1.1` — Поддержка BSL для 1С
  - `ms-ceintl.vscode-language-pack-ru@1.131.2026090407` — Русский язык
  - `saoudrizwan.claude-dev@4.1.17` — Claude Dev (Cline) AI агент
- **2.2. MCP Серверы (9)**
  - **Активный:** `mcp-VA` (Vanessa Automation) — `http://127.0.0.1:8080/mcp` — 44 функции
  - **Настроенные (из Скилы_220826/.ai-agent/mcp.json):**
    1. `1c-code-metadata-mcp` (порт 8000) — Метаданные, навигация, XSD
    2. `1c-syntax-checker-mcp` (порт 8002) — BSL-синтаксис
    3. `1C-docs-mcp` (порт 8003) — Документация 1С
    4. `1c-templates-mcp` (порт 8004) — Шаблоны кода
    5. `1c-graph-metadata-mcp` (порт 8006) — Граф-запросы (Neo4j/Cypher)
    6. `1c-code-check-mcp` (порт 8007) — Code review (1С:Напарник)
    7. `1c-ssl-mcp` (порт 8008) — Стандартные подсистемы (БСП/SSL)
    8. `1c-data-mcp` — Управление данными (URL из .dev.env)
- **2.3. MCP Marketplace** — каталог в globalStorage
- **2.4. Иерархия плагинов** — дерево расположения

### 3. Скиллы (Skills) — [skills.md](skills.md)

- **3.1. Источники навыков**
  - 75 активных в `~/.cline/skills/`
  - 11 доп. из `_ai_rules_1c/content/skills/`
  - 12 в `Скилы_220826/.ai-agent/skills/`
  - 71 исходных в `Скиллы/`
  - 1 в `скилы_220826_2/.claude/skills/`

- **3.2. Структура навыка** — SKILL.md + agents/openai.yaml + scripts/
- **3.3. 75 активных навыков** (по группам):
  - 🔧 Конфигурация (CF) — 6: cf-add-object, cf-edit, cf-info, cf-init, cf-new-project, cf-validate
  - 🔧 Расширения (CFE) — 6: cfe-borrow, cfe-diff, cfe-full-cycle, cfe-init, cfe-patch-method, cfe-validate
  - 🔧 Внешние обработки (EPF) — 8: epf, epf-bsp-add-command, epf-bsp-init, epf-build, epf-dump, epf-full-cycle, epf-init, epf-validate
  - 🔧 Внешние отчёты (ERF) — 2: erf, erf-init
  - 📋 Формы — 7: form-add, form-compile, form-edit, form-info, form-patterns, form-remove, form-validate
  - 📋 Метаданные — 5: meta-compile, meta-edit, meta-info, meta-remove, meta-validate
  - 📊 СКД — 5: skd-compile, skd-decompile, skd-edit, skd-info, skd-validate
  - 📑 Макеты (MXL) — 5: mxl, mxl-compile, mxl-decompile, mxl-info, mxl-validate
  - 📁 Подсистемы — 5: subsystem, subsystem-compile, subsystem-edit, subsystem-info, subsystem-validate
  - 🔐 Роли — 3: role-compile, role-info, role-validate
  - 🖥️ Интерфейсы — 2: interface-edit, interface-validate
  - 📄 Шаблоны — 2: template-add, template-remove
  - 🗄️ База данных — 9: db-create, db-dump-cf, db-dump-xml, db-list, db-load-cf, db-load-git, db-load-xml, db-run, db-update
  - 🌐 Веб — 6: web-info, web-publish, web-session, web-stop, web-test, web-unpublish
  - ✅ Валидация + запросы — 4: validate, 1c-query-language, query-optimization, inspect
  - 🧪 Тестирование — 3: test-databases, playwright-test, codex-test-bridge
  - 🔧 Прочее — 3: ibcmd-1c-builds, help-add, repo-update

- **3.4. Дополнительные навыки (11)** из `_ai_rules_1c/content/skills/`:
  - 1c-metadata-manage, mcp-1c-tools, v8unpack-cf, caveman, mermaid-diagrams, prompt-enhancer, md-to-docx, transcribe, powershell-windows, handoff, img-grid-analysis
- **3.5. Карта навыков по типам объектов 1С** — маршрутизаторы и workflow (compile → edit → info → validate → deploy)
- **3.6. Метрики** — статистика по навыкам (скрипты, eval-тесты, YAML-конфиги)

### 4. Правила (Rules) — [rules.md](rules.md)

- **4.1. Cline Rules (.clinerules)**
  - Файл: `c:\va\AI\тест1\.clinerules` (13,9 КБ)
  - Правила скриншотов, обязательная проверка после каждого действия с формой
  - Запрет самостоятельных решений о порядке выполнения
  - Запрет на самостоятельное прекращение сценариев
  - Запрет на закрытие тестового клиента без команды пользователя
  - Файлы проекта: InstructionsResearch.md, InstructionsWriteScenario.md, *.feature
- **4.2. Rule-файлы (on-demand) — 40**
  - Стандарты разработки (6): coding-standards, dev-standards-core, dev-standards-architecture, dev-standards-code-style, dev-standards-change-markers, dev-standards-env
  - Формы (5): forms, forms-add, form-patterns, form-module, async-methods
  - Запросы и данные (4): query-design, registers-design, dcs-design, dcs-advanced-composition
  - Метаданные и расширения (3): extension-patterns, metadata-xml-workarounds, getconfigfiles
  - Модели (5): model-adaptation, model-fable5, model-gpt56, model-opus5, model-sonnet5
  - Верификация (4): verification-checklist, verification-gates, verification-policy, verification-delivery
  - Subagents (2): subagents, subagent-pipeline
  - Инструменты и отладка (4): tooling-playbooks, systematic-debugging, mcp-first-search, ui-testing-tools
  - Дополнительно (7+): anti-patterns, bsp-access-rights, locks-and-transactions, logging-strategy, integrations-add, platform-solutions, orchestrator-economy, module-structure, web-client-driving
- **4.3. AGENTS.md** (58,7 КБ)
  - Persona (senior 1C developer), Core Principles, Process (5 steps), MCP Tool Calling (A.1-A.9), Verification (5 gates), Delivery report, Rules self-improvement, Project memory
- **4.4. LLM-RULES.md / USER-RULES.md / memory.md**
- **4.5. Агенты (subagents) — 13**
  - analytic, arch-reviewer, architect, code-reviewer, developer, doc-writer, error-fixer, explorer, metadata-manager, performance-optimizer, planner, refactoring, tester
- **4.6. Slash-команды — 17**
  - caveman, check-uuid, checkmcp, deploy-and-test, doctor, economymode, evolve, getconfigfiles, install-agent-browser, install-windows-mcp, installmcp, litemode, loadfrom1cbase, rulesmodel, update1cbase, updatemcp, updaterules
- **4.7. Адаптеры — 11**
  - cline, claude-code, cursor, codex, kilocode, kimi, qwen, command-code, opencode, pi, other
- **4.8. Манифест (.ai-rules.json)** — version 410951e, протокол 1.1
- **4.9. Ключевые параметры .dev.env** — COMPANY, DEVELOPER, PLATFORM_VERSION, CAVEMAN, VERIFICATION_DEPTH, UI_TESTING, ORCHESTRATION, AGENT_MODEL, INFOBASE_PUBLISH_URL, V8PATH
- **4.10. Связь между компонентами** — иерархия репозиториев

### 5. Конфигурация Cline / Claude Dev

| Параметр | Значение |
|---|---|
| Версия | 4.1.17 (claude-dev) |
| Режим | act |
| Язык | Russian - Русский |
| Plan mode модель | z-ai/glm-5.3-flash / deepseek-v4-flash |
| Act mode модель | z-ai/glm-5.3-flash / deepseek-v4-flash |
| Провайдеры | cline (poolside/laguna-s-2.1:free), sapaicore (claude-3.5-sonnet) |
| Автоодобрение | ✅ readFiles, editFiles, executeSafeCommands, useBrowser, useMcp |
| Терминал | cmd |

---

## Иерархия проектов (c:\va\AI\)

```
_ai_rules_1c/                    ← Источник (GitHub: comol/ai_rules_1c)
  ├── AGENTS.md (58,7 КБ)        ← always-on контекст
  ├── content/rules/             ← 40 rule-файлов
  ├── content/agents/            ← 13 агентов
  ├── content/commands/          ← 17 команд
  ├── content/skills/            ← 11 доп. навыков
  ├── adapters/                  ← 11 адаптеров для ИИ-агентов
  └── install.ps1                ← PowerShell-установщик

Скилы_220826/                    ← Установленный набор (8.22.2026, v410951e)
  ├── .ai-agent/                 ← Универсальный формат (other адаптер)
  │   ├── rules/                 ← 40 правил
  │   ├── agents/                ← 13 агентов
  │   ├── commands/              ← 17 команд
  │   ├── skills/                ← 12 доп. навыков
  │   └── mcp.json               ← 8 MCP серверов
  └── .dev.env                   ← Параметры проекта

Скиллы/                          ← Исходные навыки (71 шт.)
тест1/                           ← Тестовый проект
  └── .clinerules                ← Cline-specific правила (13,9 КБ)

C:\Users\lega\.cline/skills/     ← 75 активных навыков Cline
c:\Program Files\1cv8/           ← 1С:Предприятие (8.3.27.1989 + 8.3.27.2325)
```

---

_Индекс создан 05.09.2026_
