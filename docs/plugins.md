# Плагины (Plugins)

> **Дата составления:** 05.09.2026  
> **Окружение:** Windows (win32)

---

## 1. VS Code Extensions (3)

**Местоположение:** `C:\Users\lega\.vscode\extensions\` (3 директории)

### 1.1. 1c-syntax.language-1c-bsl

| Свойство | Значение |
|---|---|
| **ID** | `1c-syntax.language-1c-bsl` |
| **Версия** | 2.1.1 |
| **Назначение** | Поддержка языка BSL (1С:Предприятие) в VS Code |
| **Функции** | Синтаксис, подсветка, автодополнение, LSP |

---

### 1.2. ms-ceintl.vscode-language-pack-ru

| Свойство | Значение |
|---|---|
| **ID** | `ms-ceintl.vscode-language-pack-ru` |
| **Версия** | 1.131.2026090407 |
| **Назначение** | Перевод интерфейса VS Code на русский язык |

---

### 1.3. saoudrizwan.claude-dev

| Свойство | Значение |
|---|---|
| **ID** | `saoudrizwan.claude-dev` |
| **Версия** | 4.1.17 |
| **Назначение** | AI-агент Claude Dev (переименован в Cline) |
| **Расположение** | `C:\Program Files\Microsoft VS Code\` + `C:\Users\lega\AppData\Roaming\Code\User\globalStorage\saoudrizwan.claude-dev\` |
| **Функции** | AI помощь в IDE, навыки, MCP, задачи |

---

## 2. MCP Серверы (9)

MCP (Model Context Protocol) серверы расширяют возможности AI-агентов за счёт доступа к внешним системам.

### 2.1. mcp-VA (активный)

**Статус:** ✅ Активен (авто-одобрение включено)  
**Транспорт:** streamableHttp  
**URL:** `http://127.0.0.1:8080/mcp`  
**Назначение:** Vanessa Automation — автоматизация тестирования 1С

**Местоположение конфигурации:**
- Глобальная: `C:\Users\lega\AppData\Roaming\Code\User\globalStorage\saoudrizwan.claude-dev\settings\cline_mcp_settings.json`
- Cline: `C:\Users\lega\.cline\data\settings\cline_mcp_settings.json`

**Авто-одобренные функции (44):**

| Категория | Функции |
|---|---|
| **ИБ** | `infobase_info` |
| **Тест-клиент** | `manage_test_client_profiles`, `get_form_analysis`, `manage_breakpoints`, `get_window_list_testclient`, `get_editor_state`, `connect_test_client`, `close_test_client` |
| **Сценарии** | `search_for_steps_by_keywords`, `select_scenario`, `get_active_window_data`, `execute_feature_step`, `get_info_about_line_scenario`, `stop_scenario`, `run_scenario`, `select_step`, `get_VanessaAutomation_state` |
| **UI** | `get_window_screenshot_os`, `manage_command_interface`, `execute_form_actions`, `window_management`, `voice_notification`, `user_actions_recording` |
| **Данные** | `get_form_element_data`, `manage_variables`, `get_object_attributes` |
| **Файлы** | `save_table_document_to_file`, `get_table_data`, `get_data_from_knowledge_base` |
| **Работа с проектом** | `open_feature_file`, `load_features`, `frequently_used_steps`, `get_environment_data`, `get_extension_list`, `manage_form_elements`, `check_syntax` |

**Ошибка подключения:** `Unable to connect. Is the computer able to access the url?` (записана в конфигурации)

---

### 2.2. Остальные MCP серверы (из `Скилы_220826\.ai-agent\mcp.json`)

Эти 8 MCP серверов **настроены** в конфигурационном файле проекта `c:\va\AI\Скилы_220826\.ai-agent\mcp.json`, но являются **локальными** (localhost:8000-8008) и, вероятно, не все активны в данный момент:

| # | MCP Server | URL | Порт | Описание |
|---|---|---|---|---|
| 1 | `1c-code-metadata-mcp` | `http://localhost:8000/mcp` | 8000 | Метаданные, навигация, XSD, формы |
| 2 | `1c-syntax-checker-mcp` | `http://localhost:8002/mcp` | 8002 | BSL-синтаксис (через BSL Language Server) |
| 3 | `1C-docs-mcp` | `http://localhost:8003/mcp` | 8003 | Документация платформы 1С |
| 4 | `1c-templates-mcp` | `http://localhost:8004/mcp` | 8004 | Библиотека шаблонов кода |
| 5 | `1c-graph-metadata-mcp` | `http://localhost:8006/mcp` | 8006 | Граф-запросы метаданных (Neo4j/Cypher) |
| 6 | `1c-code-check-mcp` | `http://localhost:8007/mcp` | 8007 | Code review, 1С:Напарник |
| 7 | `1c-ssl-mcp` | `http://localhost:8008/mcp` | 8008 | Стандартные подсистемы (БСП/SSL) |
| 8 | `1c-data-mcp` | `{INFOBASE_PUBLISH_URL}/hs/mcp` | — | Управление данными 1С |

**Особенности `1c-data-mcp`:** URL выводится из переменной `INFOBASE_PUBLISH_URL` в `.dev.env`. Точка доступа должна быть без пароля (анонимный доступ через `default.vrd`).

---

## 3. MCP Marketplace (каталог доступных MCP)

Файл каталога: `C:\Users\lega\AppData\Roaming\Code\User\globalStorage\saoudrizwan.claude-dev\cache\mcp_marketplace_catalog.json`

Содержит каталог доступных MCP серверов, включая:
- Postman API Tools (`github.com/postmanlabs/postman-mcp-server`)
- И другие сервисы

## 4. Иерархия плагинов

```
VS Code Extensions:
C:\Users\lega\.vscode\extensions\
├── 1c-syntax.language-1c-bsl-2.1.1/
├── ms-ceintl.vscode-language-pack-ru-1.131.2026090407/
└── saoudrizwan.claude-dev-4.1.17/

MCP Servers (глобальные настройки Cline):
C:\Users\lega\.cline\data\settings\cline_mcp_settings.json
    └── mcp-VA (http://127.0.0.1:8080/mcp)

MCP Servers (проектные настройки):
c:\va\AI\Скилы_220826\.ai-agent\mcp.json
    ├── 1c-code-metadata-mcp (localhost:8000)
    ├── 1c-syntax-checker-mcp (localhost:8002)
    ├── 1C-docs-mcp (localhost:8003)
    ├── 1c-templates-mcp (localhost:8004)
    ├── 1c-graph-metadata-mcp (localhost:8006)
    ├── 1c-code-check-mcp (localhost:8007)
    ├── 1c-ssl-mcp (localhost:8008)
    └── 1c-data-mcp ({INFOBASE_PUBLISH_URL}/hs/mcp)
```
