Loaded cached credentials.
# Gemini CLI Configuration

# Gemini CLI 配置

Gemini CLI offers several ways to configure its behavior, including environment variables, command-line arguments, and settings files. This document outlines the different configuration methods and available settings.

Gemini CLI 提供了多种方式来配置其行为，包括环境变量、命令行参数和设置文件。本文档概述了不同的配置方法和可用的设置。

## Configuration layers

## 配置层级

Configuration is applied in the following order of precedence (lower numbers are overridden by higher numbers):

配置按以下优先级顺序应用（序号小的会被序号大的覆盖）：

1.  **Default values:** Hardcoded defaults within the application.
2.  **User settings file:** Global settings for the current user.
3.  **Project settings file:** Project-specific settings.
4.  **System settings file:** System-wide settings.
5.  **Environment variables:** System-wide or session-specific variables, potentially loaded from `.env` files.
6.  **Command-line arguments:** Values passed when launching the CLI.

1.  **默认值：** 应用中硬编码的默认值。
2.  **用户设置文件：** 当前用户的全局设置。
3.  **项目设置文件：** 项目特定的设置。
4.  **系统设置文件：** 系统范围的设置。
5.  **环境变量：** 系统范围或会话特定的变量，可能从 `.env` 文件加载。
6.  **命令行参数：** 启动 CLI 时传递的值。

## Settings files

## 设置文件

Gemini CLI uses `settings.json` files for persistent configuration. There are three locations for these files:

Gemini CLI 使用 `settings.json` 文件进行持久化配置。这些文件有三个位置：

- **User settings file:**
  - **Location:** `~/.gemini/settings.json` (where `~` is your home directory).
  - **Scope:** Applies to all Gemini CLI sessions for the current user.
- **Project settings file:**
  - **Location:** `.gemini/settings.json` within your project's root directory.
  - **Scope:** Applies only when running Gemini CLI from that specific project. Project settings override user settings.
- **System settings file:**
  - **Location:** `/etc/gemini-cli/settings.json` (Linux), `C:\ProgramData\gemini-cli\settings.json` (Windows) or `/Library/Application Support/GeminiCli/settings.json` (macOS).
  - **Scope:** Applies to all Gemini CLI sessions on the system, for all users. System settings override user and project settings. May be useful for system administrators at enterprises to have controls over users' Gemini CLI setups.

- **用户设置文件：**
  - **位置：** `~/.gemini/settings.json` (其中 `~` 是您的主目录)。
  - **范围：** 应用于当前用户的所有 Gemini CLI 会话。
- **项目设置文件：**
  - **位置：** 项目根目录下的 `.gemini/settings.json`。
  - **范围：** 仅在从该特定项目运行 Gemini CLI 时应用。项目设置会覆盖用户设置。
- **系统设置文件：**
  - **位置：** `/etc/gemini-cli/settings.json` (Linux)、`C:\ProgramData\gemini-cli\settings.json` (Windows) 或 `/Library/Application Support/GeminiCli/settings.json` (macOS)。
  - **范围：** 应用于系统上所有用户的所有 Gemini CLI 会话。系统设置会覆盖用户和项目设置。对于希望控制用户 Gemini CLI 设置的企业系统管理员可能很有用。

**Note on environment variables in settings:** String values within your `settings.json` files can reference environment variables using either `$VAR_NAME` or `${VAR_NAME}` syntax. These variables will be automatically resolved when the settings are loaded. For example, if you have an environment variable `MY_API_TOKEN`, you could use it in `settings.json` like this: `"apiKey": "$MY_API_TOKEN"`.

**关于设置中环境变量的说明：** `settings.json` 文件中的字符串值可以使用 `$VAR_NAME` 或 `${VAR_NAME}` 语法引用环境变量。这些变量在加载设置时会自动解析。例如，如果您有一个环境变量 `MY_API_TOKEN`，您可以在 `settings.json` 中这样使用它：`"apiKey": "$MY_API_TOKEN"`。

### The `.gemini` directory in your project

### 项目中的 `.gemini` 目录

In addition to a project settings file, a project's `.gemini` directory can contain other project-specific files related to Gemini CLI's operation, such as:

除了项目设置文件，项目的 `.gemini` 目录还可以包含与 Gemini CLI 操作相关的其他项目特定文件，例如：

- [Custom sandbox profiles](#sandboxing) (e.g., `.gemini/sandbox-macos-custom.sb`, `.gemini/sandbox.Dockerfile`).

- [自定义沙盒配置文件](#sandboxing) (例如, `.gemini/sandbox-macos-custom.sb`, `.gemini/sandbox.Dockerfile`)。

### Available settings in `settings.json`:

### `settings.json` 中的可用设置：

- **`contextFileName`** (string or array of strings):
  - **Description:** Specifies the filename for context files (e.g., `GEMINI.md`, `AGENTS.md`). Can be a single filename or a list of accepted filenames.
  - **Default:** `GEMINI.md`
  - **Example:** `"contextFileName": "AGENTS.md"`

- **`contextFileName`** (字符串或字符串数​​组):
  - **描述：** 指定上下文文件的文件名（例如 `GEMINI.md`、`AGENTS.md`）。可以使单个文件名或可接受的文件名列表。
  - **默认值：** `GEMINI.md`
  - **示例：** `"contextFileName": "AGENTS.md"`

- **`bugCommand`** (object):
  - **Description:** Overrides the default URL for the `/bug` command.
  - **Default:** `"urlTemplate": "https://github.com/google-gemini/gemini-cli/issues/new?template=bug_report.yml&title={title}&info={info}"`
  - **Properties:**
    - **`urlTemplate`** (string): A URL that can contain `{title}` and `{info}` placeholders.
  - **Example:**
    ```json
    "bugCommand": {
      "urlTemplate": "https://bug.example.com/new?title={title}&info={info}"
    }
    ```

- **`bugCommand`** (对象):
  - **描述：** 覆盖 `/bug` 命令的默认 URL。
  - **默认值：** `"urlTemplate": "https://github.com/google-gemini/gemini-cli/issues/new?template=bug_report.yml&title={title}&info={info}"`
  - **属性：**
    - **`urlTemplate`** (字符串): 一个可以包含 `{title}` 和 `{info}` 占位符的 URL。
  - **示例：**
    ```json
    "bugCommand": {
      "urlTemplate": "https://bug.example.com/new?title={title}&info={info}"
    }
    ```

- **`fileFiltering`** (object):
  - **Description:** Controls git-aware file filtering behavior for @ commands and file discovery tools.
  - **Default:** `"respectGitIgnore": true, "enableRecursiveFileSearch": true`
  - **Properties:**
    - **`respectGitIgnore`** (boolean): Whether to respect .gitignore patterns when discovering files. When set to `true`, git-ignored files (like `node_modules/`, `dist/`, `.env`) are automatically excluded from @ commands and file listing operations.
    - **`enableRecursiveFileSearch`** (boolean): Whether to enable searching recursively for filenames under the current tree when completing @ prefixes in the prompt.
  - **Example:**
    ```json
    "fileFiltering": {
      "respectGitIgnore": true,
      "enableRecursiveFileSearch": false
    }
    ```

- **`fileFiltering`** (对象):
  - **描述：** 控制 @ 命令和文件发现工具的 Git感知文件过滤行为。
  - **默认值：** `"respectGitIgnore": true, "enableRecursiveFileSearch": true`
  - **属性：**
    - **`respectGitIgnore`** (布尔值): 在发现文件时是否遵循 .gitignore 模式。当设置为 `true` 时，被 Git 忽略的文件（如 `node_modules/`、`dist/`、`.env`）会自动从 @ 命令和文件列出操作中排除。
    - **`enableRecursiveFileSearch`** (布尔值): 在提示符中补全 @ 前缀时，是否在当前目录下递归搜索文件名。
  - **示例：**
    ```json
    "fileFiltering": {
      "respectGitIgnore": true,
      "enableRecursiveFileSearch": false
    }
    ```

- **`coreTools`** (array of strings):
  - **Description:** Allows you to specify a list of core tool names that should be made available to the model. This can be used to restrict the set of built-in tools. See [Built-in Tools](../core/tools-api.md#built-in-tools) for a list of core tools. You can also specify command-specific restrictions for tools that support it, like the `ShellTool`. For example, `"coreTools": ["ShellTool(ls -l)"]` will only allow the `ls -l` command to be executed.
  - **Default:** All tools available for use by the Gemini model.
  - **Example:** `"coreTools": ["ReadFileTool", "GlobTool", "ShellTool(ls)"]`.

- **`coreTools`** (字符串数组):
  - **描述：** 允许您指定一个核心工具名称列表，这些工具应该对模型可用。这可以用来限制内置工具的集合。有关核心工具的列表，请参阅[内置工具](../core/tools-api.md#built-in-tools)。您还可以为支持它的工具指定特定于命令的限制，例如 `ShellTool`。例如，`"coreTools": ["ShellTool(ls -l)"]` 将只允许执行 `ls -l` 命令。
  - **默认值：** 所有工具都可供 Gemini 模型使用。
  - **示例：** `"coreTools": ["ReadFileTool", "GlobTool", "ShellTool(ls)"]`。

- **`excludeTools`** (array of strings):
  - **Description:** Allows you to specify a list of core tool names that should be excluded from the model. A tool listed in both `excludeTools` and `coreTools` is excluded. You can also specify command-specific restrictions for tools that support it, like the `ShellTool`. For example, `"excludeTools": ["ShellTool(rm -rf)"]` will block the `rm -rf` command.
  - **Default**: No tools excluded.
  - **Example:** `"excludeTools": ["run_shell_command", "findFiles"]`.
  - **Security Note:** Command-specific restrictions in
    `excludeTools` for `run_shell_command` are based on simple string matching and can be easily bypassed. This feature is **not a security mechanism** and should not be relied upon to safely execute untrusted code. It is recommended to use `coreTools` to explicitly select commands
    that can be executed.

- **`excludeTools`** (字符串数组):
  - **描述：** 允许您指定一个核心工具名称列表，这些工具应该从模型中排除。同时在 `excludeTools` 和 `coreTools` 中列出的工具将被排除。您还可以为支持它的工具指定特定于命令的限制，例如 `ShellTool`。例如，`"excludeTools": ["ShellTool(rm -rf)"]` 将阻止 `rm -rf` 命令。
  - **默认值**：不排除任何工具。
  - **示例：** `"excludeTools": ["run_shell_command", "findFiles"]`。
  - **安全说明：** `excludeTools` 中对 `run_shell_command` 的命令特定限制基于简单的字符串匹配，很容易被绕过。此功能**不是安全机制**，不应依赖它来安全地执行不受信任的代码。建议使用 `coreTools` 明确选择可以执行的命令。

- **`allowMCPServers`** (array of strings):
  - **Description:** Allows you to specify a list of MCP server names that should be made available to the model. This can be used to restrict the set of MCP servers to connect to. Note that this will be ignored if `--allowed-mcp-server-names` is set.
  - **Default:** All MCP servers are available for use by the Gemini model.
  - **Example:** `"allowMCPServers": ["myPythonServer"]`.
  - **Security Note:** This uses simple string matching on MCP server names, which can be modified. If you're a system administrator looking to prevent users from bypassing this, consider configuring the `mcpServers` at the system settings level such that the user will not be able to configure any MCP servers of their own. This should not be used as an airtight security mechanism.

- **`allowMCPServers`** (字符串数组):
  - **描述：** 允许您指定一个 MCP 服务器名称列表，这些服务器应该对模型可用。这可以用来限制要连接的 MCP 服务器集合。请注意，如果设置了 `--allowed-mcp-server-names`，此设置将被忽略。
  - **默认值：** 所有 MCP 服务器都可供 Gemini 模型使用。
  - **示例：** `"allowMCPServers": ["myPythonServer"]`。
  - **安全说明：** 此功能使用对 MCP 服务器名称的简单字符串匹配，可以被修改。如果您是系统管理员，希望防止用户绕过此限制，请考虑在系统设置级别配置 `mcpServers`，这样用户将无法配置自己的任何 MCP 服务器。这不应被用作严密的安全机制。

- **`excludeMCPServers`** (array of strings):
  - **Description:** Allows you to specify a list of MCP server names that should be excluded from the model. A server listed in both `excludeMCPServers` and `allowMCPServers` is excluded. Note that this will be ignored if `--allowed-mcp-server-names` is set.
  - **Default**: No MCP servers excluded.
  - **Example:** `"excludeMCPServers": ["myNodeServer"]`.
  - **Security Note:** This uses simple string matching on MCP server names, which can be modified. If you're a system administrator looking to prevent users from bypassing this, consider configuring the `mcpServers` at the system settings level such that the user will not be able to configure any MCP servers of their own. This should not be used as an airtight security mechanism.

- **`excludeMCPServers`** (字符串数组):
  - **描述：** 允许您指定一个 MCP 服务器名称列表，这些服务器应该从模型中排除。同时在 `excludeMCPServers` 和 `allowMCPServers` 中列出的服务器将被排除。请注意，如果设置了 `--allowed-mcp-server-names`，此设置将被忽略。
  - **默认值**：不排除任何 MCP 服务器。
  - **示例：** `"excludeMCPServers": ["myNodeServer"]`。
  - **安全说明：** 此功能使用对 MCP 服务器名称的简单字符串匹配，可以被修改。如果您是系统管理员，希望防止用户绕过此限制，请考虑在系统设置级别配置 `mcpServers`，这样用户将无法配置自己的任何 MCP 服务器。这不应被用作严密的安全机制。

- **`autoAccept`** (boolean):
  - **Description:** Controls whether the CLI automatically accepts and executes tool calls that are considered safe (e.g., read-only operations) without explicit user confirmation. If set to `true`, the CLI will bypass the confirmation prompt for tools deemed safe.
  - **Default:** `false`
  - **Example:** `"autoAccept": true`

- **`autoAccept`** (布尔值):
  - **描述：** 控制 CLI 是否自动接受并执行被认为是安全的操作（例如，只读操作）的工具调用，而无需用户明确确认。如果设置为 `true`，CLI 将对被认为是安全的工具绕过确认提示。
  - **默认值：** `false`
  - **示例：** `"autoAccept": true`

- **`theme`** (string):
  - **Description:** Sets the visual [theme](./themes.md) for Gemini CLI.
  - **Default:** `"Default"`
  - **Example:** `"theme": "GitHub"`

- **`theme`** (字符串):
  - **描述：** 设置 Gemini CLI 的视觉[主题](./themes.md)。
  - **默认值：** `"Default"`
  - **示例：** `"theme": "GitHub"`

- **`sandbox`** (boolean or string):
  - **Description:** Controls whether and how to use sandboxing for tool execution. If set to `true`, Gemini CLI uses a pre-built `gemini-cli-sandbox` Docker image. For more information, see [Sandboxing](#sandboxing).
  - **Default:** `false`
  - **Example:** `"sandbox": "docker"`

- **`sandbox`** (布尔值或字符串):
  - **描述：** 控制是否以及如何使用沙盒执行工具。如果设置为 `true`，Gemini CLI 将使用预构建的 `gemini-cli-sandbox` Docker 镜像。更多信息，请参阅[沙盒](#sandboxing)。
  - **默认值：** `false`
  - **示例：** `"sandbox": "docker"`

- **`toolDiscoveryCommand`** (string):
  - **Description:** Defines a custom shell command for discovering tools from your project. The shell command must return on `stdout` a JSON array of [function declarations](https://ai.google.dev/gemini-api/docs/function-calling#function-declarations). Tool wrappers are optional.
  - **Default:** Empty
  - **Example:** `"toolDiscoveryCommand": "bin/get_tools"`

- **`toolDiscoveryCommand`** (字符串):
  - **描述：** 定义一个自定义 shell 命令，用于从您的项目中发现工具。该 shell 命令必须在 `stdout` 上返回一个 [函数声明](https://ai.google.dev/gemini-api/docs/function-calling#function-declarations) 的 JSON 数组。工具包装器是可选的。
  - **默认值：** 空
  - **示例：** `"toolDiscoveryCommand": "bin/get_tools"`

- **`toolCallCommand`** (string):
  - **Description:** Defines a custom shell command for calling a specific tool that was discovered using `toolDiscoveryCommand`. The shell command must meet the following criteria:
    - It must take function `name` (exactly as in [function declaration](https://ai.google.dev/gemini-api/docs/function-calling#function-declarations)) as first command line argument.
    - It must read function arguments as JSON on `stdin`, analogous to [`functionCall.args`](https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/inference#functioncall).
    - It must return function output as JSON on `stdout`, analogous to [`functionResponse.response.content`](https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/inference#functionresponse).
  - **Default:** Empty
  - **Example:** `"toolCallCommand": "bin/call_tool"`

- **`toolCallCommand`** (字符串):
  - **描述：** 定义一个自定义 shell 命令，用于调用使用 `toolDiscoveryCommand` 发现的特定工具。该 shell 命令必须满足以下条件：
    - 它必须将函数 `name`（与[函数声明](https://ai.google.dev/gemini-api/docs/function-calling#function-declarations)中完全一样）作为第一个命令行参数。
    - 它必须在 `stdin` 上读取 JSON 格式的函数参数，类似于 [`functionCall.args`](https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/inference#functioncall)。
    - 它必须在 `stdout` 上返回 JSON 格式的函数输出，类似于 [`functionResponse.response.content`](https://cloud.google.com/vertex-ai/generative-ai/docs/model-reference/inference#functionresponse)。
  - **默认值：** 空
  - **示例：** `"toolCallCommand": "bin/call_tool"`

- **`mcpServers`** (object):
  - **Description:** Configures connections to one or more Model-Context Protocol (MCP) servers for discovering and using custom tools. Gemini CLI attempts to connect to each configured MCP server to discover available tools. If multiple MCP servers expose a tool with the same name, the tool names will be prefixed with the server alias you defined in the configuration (e.g., `serverAlias__actualToolName`) to avoid conflicts. Note that the system might strip certain schema properties from MCP tool definitions for compatibility.
  - **Default:** Empty
  - **Properties:**
    - **`<SERVER_NAME>`** (object): The server parameters for the named server.
      - `command` (string, required): The command to execute to start the MCP server.
      - `args` (array of strings, optional): Arguments to pass to the command.
      - `env` (object, optional): Environment variables to set for the server process.
      - `cwd` (string, optional): The working directory in which to start the server.
      - `timeout` (number, optional): Timeout in milliseconds for requests to this MCP server.
      - `trust` (boolean, optional): Trust this server and bypass all tool call confirmations.
      - `includeTools` (array of strings, optional): List of tool names to include from this MCP server. When specified, only the tools listed here will be available from this server (whitelist behavior). If not specified, all tools from the server are enabled by default.
      - `excludeTools` (array of strings, optional): List of tool names to exclude from this MCP server. Tools listed here will not be available to the model, even if they are exposed by the server. **Note:** `excludeTools` takes precedence over `includeTools` - if a tool is in both lists, it will be excluded.
  - **Example:**
    ```json
    "mcpServers": {
      "myPythonServer": {
        "command": "python",
        "args": ["mcp_server.py", "--port", "8080"],
        "cwd": "./mcp_tools/python",
        "timeout": 5000,
        "includeTools": ["safe_tool", "file_reader"],
      },
      "myNodeServer": {
        "command": "node",
        "args": ["mcp_server.js"],
        "cwd": "./mcp_tools/node",
        "excludeTools": ["dangerous_tool", "file_deleter"]
      },
      "myDockerServer": {
        "command": "docker",
        "args": ["run", "-i", "--rm", "-e", "API_KEY", "ghcr.io/foo/bar"],
        "env": {
          "API_KEY": "$MY_API_TOKEN"
        }
      }
    }
    ```

- **`mcpServers`** (对象):
  - **描述：** 配置与一个或多个模型-上下文协议 (MCP) 服务器的连接，以发现和使用自定义工具。Gemini CLI 会尝试连接到每个配置的 MCP 服务器以发现可用的工具。如果多个 MCP 服务器公开了同名工具，工具名称将以您在配置中定义的服务器别名为前缀（例如 `serverAlias__actualToolName`）以避免冲突。请注意，系统可能会为了兼容性而从 MCP 工具定义中剥离某些模式属性。
  - **默认值：** 空
  - **属性：**
    - **`<SERVER_NAME>`** (对象): 命名服务器的服务器参数。
      - `command` (字符串, 必需): 启动 MCP 服务器要执行的命令。
      - `args` (字符串数组, 可选): 传递给命令的参数。
      - `env` (对象, 可选): 为服务器进程设置的环境变量。
      - `cwd` (字符串, 可选): 启动服务器的工作目录。
      - `timeout` (数字, 可选): 对此 MCP 服务器请求的超时时间（毫秒）。
      - `trust` (布尔值, 可选): 信任此服务器并绕过所有工具调用确认。
      - `includeTools` (字符串数组, 可选): 要从此 MCP 服务器包含的工具名称列表。指定后，只有此处列出的工具将从此服务器可用（白名单行为）。如果未指定，则默认启用服务器的所有工具。
      - `excludeTools` (字符串数组, 可选): 要从此 MCP 服务器排除的工具名称列表。此处列出的工具将对模型不可用，即使它们由服务器公开。**注意：** `excludeTools` 优先于 `includeTools` - 如果一个工具同时在两个列表中，它将被排除。
  - **示例：**
    ```json
    "mcpServers": {
      "myPythonServer": {
        "command": "python",
        "args": ["mcp_server.py", "--port", "8080"],
        "cwd": "./mcp_tools/python",
        "timeout": 5000,
        "includeTools": ["safe_tool", "file_reader"],
      },
      "myNodeServer": {
        "command": "node",
        "args": ["mcp_server.js"],
        "cwd": "./mcp_tools/node",
        "excludeTools": ["dangerous_tool", "file_deleter"]
      },
      "myDockerServer": {
        "command": "docker",
        "args": ["run", "-i", "--rm", "-e", "API_KEY", "ghcr.io/foo/bar"],
        "env": {
          "API_KEY": "$MY_API_TOKEN"
        }
      }
    }
    ```

- **`checkpointing`** (object):
  - **Description:** Configures the checkpointing feature, which allows you to save and restore conversation and file states. See the [Checkpointing documentation](../checkpointing.md) for more details.
  - **Default:** `{"enabled": false}`
  - **Properties:**
    - **`enabled`** (boolean): When `true`, the `/restore` command is available.

- **`checkpointing`** (对象):
  - **描述：** 配置检查点功能，该功能允许您保存和恢复对话和文件状态。有关更多详细信息，请参阅[检查点文档](../checkpointing.md)。
  - **默认值：** `{"enabled": false}`
  - **属性：**
    - **`enabled`** (布尔值): 当为 `true` 时，`/restore` 命令可用。

- **`preferredEditor`** (string):
  - **Description:** Specifies the preferred editor to use for viewing diffs.
  - **Default:** `vscode`
  - **Example:** `"preferredEditor": "vscode"`

- **`preferredEditor`** (字符串):
  - **描述：** 指定用于查看差异的首选编辑器。
  - **默认值：** `vscode`
  - **示例：** `"preferredEditor": "vscode"`

- **`telemetry`** (object)
  - **Description:** Configures logging and metrics collection for Gemini CLI. For more information, see [Telemetry](../telemetry.md).
  - **Default:** `{"enabled": false, "target": "local", "otlpEndpoint": "http://localhost:4317", "logPrompts": true}`
  - **Properties:**
    - **`enabled`** (boolean): Whether or not telemetry is enabled.
    - **`target`** (string): The destination for collected telemetry. Supported values are `local` and `gcp`.
    - **`otlpEndpoint`** (string): The endpoint for the OTLP Exporter.
    - **`logPrompts`** (boolean): Whether or not to include the content of user prompts in the logs.
  - **Example:**
    ```json
    "telemetry": {
      "enabled": true,
      "target": "local",
      "otlpEndpoint": "http://localhost:16686",
      "logPrompts": false
    }
    ```
- **`telemetry`** (对象)
  - **描述：** 为 Gemini CLI 配置日志记录和指标收集。更多信息，请参阅[遥测](../telemetry.md)。
  - **默认值：** `{"enabled": false, "target": "local", "otlpEndpoint": "http://localhost:4317", "logPrompts": true}`
  - **属性：**
    - **`enabled`** (布尔值): 遥测是否启用。
    - **`target`** (字符串): 收集的遥测数据的目的地。支持的值为 `local` 和 `gcp`。
    - **`otlpEndpoint`** (字符串): OTLP 导出器的端点。
    - **`logPrompts`** (布尔值): 是否在日志中包含用户提示的内容。
  - **示例：**
    ```json
    "telemetry": {
      "enabled": true,
      "target": "local",
      "otlpEndpoint": "http://localhost:16686",
      "logPrompts": false
    }
    ```
- **`usageStatisticsEnabled`** (boolean):
  - **Description:** Enables or disables the collection of usage statistics. See [Usage Statistics](#usage-statistics) for more information.
  - **Default:** `true`
  - **Example:**
    ```json
    "usageStatisticsEnabled": false
    ```

- **`usageStatisticsEnabled`** (布尔值):
  - **描述：** 启用或禁用使用情况统计信息的收集。有关更多信息，请参阅[使用情况统计](#usage-statistics)。
  - **默认值：** `true`
  - **示例：**
    ```json
    "usageStatisticsEnabled": false
    ```

- **`hideTips`** (boolean):
  - **Description:** Enables or disables helpful tips in the CLI interface.
  - **Default:** `false`
  - **Example:**

    ```json
    "hideTips": true
    ```

- **`hideTips`** (布尔值):
  - **描述：** 在 CLI 界面中启用或禁用有用的提示。
  - **默认值：** `false`
  - **示例：**

    ```json
    "hideTips": true
    ```

- **`hideBanner`** (boolean):
  - **Description:** Enables or disables the startup banner (ASCII art logo) in the CLI interface.
  - **Default:** `false`
  - **Example:**

    ```json
    "hideBanner": true
    ```

- **`hideBanner`** (布尔值):
  - **描述：** 在 CLI 界面中启用或禁用启动横幅（ASCII 艺术徽标）。
  - **默认值：** `false`
  - **示例：**

    ```json
    "hideBanner": true
    ```

- **`maxSessionTurns`** (number):
  - **Description:** Sets the maximum number of turns for a session. If the session exceeds this limit, the CLI will stop processing and start a new chat.
  - **Default:** `-1` (unlimited)
  - **Example:**
    ```json
    "maxSessionTurns": 10
    ```

- **`maxSessionTurns`** (数字):
  - **描述：** 设置会话的最大轮次。如果会话超过此限制，CLI 将停止处理并开始新的聊天。
  - **默认值：** `-1` (无限制)
  - **示例：**
    ```json
    "maxSessionTurns": 10
    ```

- **`summarizeToolOutput`** (object):
  - **Description:** Enables or disables the summarization of tool output. You can specify the token budget for the summarization using the `tokenBudget` setting.
  - Note: Currently only the `run_shell_command` tool is supported.
  - **Default:** `{}` (Disabled by default)
  - **Example:**
    ```json
    "summarizeToolOutput": {
      "run_shell_command": {
        "tokenBudget": 2000
      }
    }
    ```

- **`summarizeToolOutput`** (对象):
  - **描述：** 启用或禁用工具输出的摘要。您可以使用 `tokenBudget` 设置指定摘要的令牌预算。
  - 注意：目前仅支持 `run_shell_command` 工具。
  - **默认值：** `{}` (默认禁用)
  - **示例：**
    ```json
    "summarizeToolOutput": {
      "run_shell_command": {
        "tokenBudget": 2000
      }
    }
    ```

### Example `settings.json`:

### `settings.json` 示例：

```json
{
  "theme": "GitHub",
  "sandbox": "docker",
  "toolDiscoveryCommand": "bin/get_tools",
  "toolCallCommand": "bin/call_tool",
  "mcpServers": {
    "mainServer": {
      "command": "bin/mcp_server.py"
    },
    "anotherServer": {
      "command": "node",
      "args": ["mcp_server.js", "--verbose"]
    }
  },
  "telemetry": {
    "enabled": true,
    "target": "local",
    "otlpEndpoint": "http://localhost:4317",
    "logPrompts": true
  },
  "usageStatisticsEnabled": true,
  "hideTips": false,
  "hideBanner": false,
  "maxSessionTurns": 10,
  "summarizeToolOutput": {
    "run_shell_command": {
      "tokenBudget": 100
    }
  }
}
```

```json
{
  "theme": "GitHub",
  "sandbox": "docker",
  "toolDiscoveryCommand": "bin/get_tools",
  "toolCallCommand": "bin/call_tool",
  "mcpServers": {
    "mainServer": {
      "command": "bin/mcp_server.py"
    },
    "anotherServer": {
      "command": "node",
      "args": ["mcp_server.js", "--verbose"]
    }
  },
  "telemetry": {
    "enabled": true,
    "target": "local",
    "otlpEndpoint": "http://localhost:4317",
    "logPrompts": true
  },
  "usageStatisticsEnabled": true,
  "hideTips": false,
  "hideBanner": false,
  "maxSessionTurns": 10,
  "summarizeToolOutput": {
    "run_shell_command": {
      "tokenBudget": 100
    }
  }
}
```

## Shell History

## Shell 历史记录

The CLI keeps a history of shell commands you run. To avoid conflicts between different projects, this history is stored in a project-specific directory within your user's home folder.

CLI 会保留您运行的 shell 命令的历史记录。为避免不同项目之间的冲突，此历史记录存储在用户主文件夹内的项目特定目录中。

- **Location:** `~/.gemini/tmp/<project_hash>/shell_history`
  - `<project_hash>` is a unique identifier generated from your project's root path.
  - The history is stored in a file named `shell_history`.

- **位置：** `~/.gemini/tmp/<project_hash>/shell_history`
  - `<project_hash>` 是根据项目根路径生成的唯一标识符。
  - 历史记录存储在名为 `shell_history` 的文件中。

## Environment Variables & `.env` Files

## 环境变量和 `.env` 文件

Environment variables are a common way to configure applications, especially for sensitive information like API keys or for settings that might change between environments.

环境变量是配置应用程序的常用方法，特别是对于 API 密钥等敏感信息或可能在不同环境之间变化的设置。

The CLI automatically loads environment variables from an `.env` file. The loading order is:

CLI 会自动从 `.env` 文件加载环境变量。加载顺序如下：

1.  `.env` file in the current working directory.
2.  If not found, it searches upwards in parent directories until it finds an `.env` file or reaches the project root (identified by a `.git` folder) or the home directory.
3.  If still not found, it looks for `~/.env` (in the user's home directory).

1.  当前工作目录中的 `.env` 文件。
2.  如果未找到，它会向上搜索父目录，直到找到 `.env` 文件或到达项目根目录（由 `.git` 文件夹标识）或主目录。
3.  如果仍然找不到，它会查找 `~/.env`（在用户的主目录中）。

- **`GEMINI_API_KEY`** (Required):
  - Your API key for the Gemini API.
  - **Crucial for operation.** The CLI will not function without it.
  - Set this in your shell profile (e.g., `~/.bashrc`, `~/.zshrc`) or an `.env` file.
- **`GEMINI_MODEL`**:
  - Specifies the default Gemini model to use.
  - Overrides the hardcoded default
  - Example: `export GEMINI_MODEL="gemini-2.5-flash"`
- **`GOOGLE_API_KEY`**:
  - Your Google Cloud API key.
  - Required for using Vertex AI in express mode.
  - Ensure you have the necessary permissions.
  - Example: `export GOOGLE_API_KEY="YOUR_GOOGLE_API_KEY"`.
- **`GOOGLE_CLOUD_PROJECT`**:
  - Your Google Cloud Project ID.
  - Required for using Code Assist or Vertex AI.
  - If using Vertex AI, ensure you have the necessary permissions in this project.
  - **Cloud Shell Note:** When running in a Cloud Shell environment, this variable defaults to a special project allocated for Cloud Shell users. If you have `GOOGLE_CLOUD_PROJECT` set in your global environment in Cloud Shell, it will be overridden by this default. To use a different project in Cloud Shell, you must define `GOOGLE_CLOUD_PROJECT` in a `.env` file.
  - Example: `export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"`.
- **`GOOGLE_APPLICATION_CREDENTIALS`** (string):
  - **Description:** The path to your Google Application Credentials JSON file.
  - **Example:** `export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/credentials.json"`
- **`OTLP_GOOGLE_CLOUD_PROJECT`**:
  - Your Google Cloud Project ID for Telemetry in Google Cloud
  - Example: `export OTLP_GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"`.
- **`GOOGLE_CLOUD_LOCATION`**:
  - Your Google Cloud Project Location (e.g., us-central1).
  - Required for using Vertex AI in non express mode.
  - Example: `export GOOGLE_CLOUD_LOCATION="YOUR_PROJECT_LOCATION"`.
- **`GEMINI_SANDBOX`**:
  - Alternative to the `sandbox` setting in `settings.json`.
  - Accepts `true`, `false`, `docker`, `podman`, or a custom command string.
- **`SEATBELT_PROFILE`** (macOS specific):
  - Switches the Seatbelt (`sandbox-exec`) profile on macOS.
  - `permissive-open`: (Default) Restricts writes to the project folder (and a few other folders, see `packages/cli/src/utils/sandbox-macos-permissive-open.sb`) but allows other operations.
  - `strict`: Uses a strict profile that declines operations by default.
  - `<profile_name>`: Uses a custom profile. To define a custom profile, create a file named `sandbox-macos-<profile_name>.sb` in your project's `.gemini/` directory (e.g., `my-project/.gemini/sandbox-macos-custom.sb`).
- **`DEBUG` or `DEBUG_MODE`** (often used by underlying libraries or the CLI itself):
  - Set to `true` or `1` to enable verbose debug logging, which can be helpful for troubleshooting.
- **`NO_COLOR`**:
  - Set to any value to disable all color output in the CLI.
- **`CLI_TITLE`**:
  - Set to a string to customize the title of the CLI.
- **`CODE_ASSIST_ENDPOINT`**:
  - Specifies the endpoint for the code assist server.
  - This is useful for development and testing.

- **`GEMINI_API_KEY`** (必需):
  - 您的 Gemini API 密钥。
  - **操作关键。** 没有它，CLI 将无法运行。
  - 在您的 shell 配置文件（例如 `~/.bashrc`、`~/.zshrc`）或 `.env` 文件中设置此项。
- **`GEMINI_MODEL`**:
  - 指定要使用的默认 Gemini 模型。
  - 覆盖硬编码的默认值。
  - 示例：`export GEMINI_MODEL="gemini-2.5-flash"`
- **`GOOGLE_API_KEY`**:
  - 您的 Google Cloud API 密钥。
  - 在快速模式下使用 Vertex AI 时需要。
  - 确保您具有必要的权限。
  - 示例：`export GOOGLE_API_KEY="YOUR_GOOGLE_API_KEY"`。
- **`GOOGLE_CLOUD_PROJECT`**:
  - 您的 Google Cloud 项目 ID。
  - 使用 Code Assist 或 Vertex AI 时需要。
  - 如果使用 Vertex AI，请确保您在此项目中具有必要的权限。
  - **Cloud Shell 注意：** 在 Cloud Shell 环境中运行时，此变量默认为分配给 Cloud Shell 用户的特殊项目。如果您在 Cloud Shell 的全局环境中设置了 `GOOGLE_CLOUD_PROJECT`，它将被此默认值覆盖。要在 Cloud Shell 中使用不同的项目，您必须在 `.env` 文件中定义 `GOOGLE_CLOUD_PROJECT`。
  - 示例：`export GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"`。
- **`GOOGLE_APPLICATION_CREDENTIALS`** (字符串):
  - **描述：** 您的 Google Application Credentials JSON 文件的路径。
  - **示例：** `export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/credentials.json"`
- **`OTLP_GOOGLE_CLOUD_PROJECT`**:
  - 您用于 Google Cloud 中遥测的 Google Cloud 项目 ID。
  - 示例：`export OTLP_GOOGLE_CLOUD_PROJECT="YOUR_PROJECT_ID"`。
- **`GOOGLE_CLOUD_LOCATION`**:
  - 您的 Google Cloud 项目位置（例如 us-central1）。
  - 在非快速模式下使用 Vertex AI 时需要。
  - 示例：`export GOOGLE_CLOUD_LOCATION="YOUR_PROJECT_LOCATION"`。
- **`GEMINI_SANDBOX`**:
  - `settings.json` 中 `sandbox` 设置的替代方案。
  - 接受 `true`、`false`、`docker`、`podman` 或自定义命令字符串。
- **`SEATBELT_PROFILE`** (macOS 特定):
  - 在 macOS 上切换 Seatbelt (`sandbox-exec`) 配置文件。
  - `permissive-open`: (默认) 限制对项目文件夹（以及其他一些文件夹，请参阅 `packages/cli/src/utils/sandbox-macos-permissive-open.sb`）的写入，但允许其他操作。
  - `strict`: 使用默认拒绝操作的严格配置文件。
  - `<profile_name>`: 使用自定义配置文件。要定义自定义配置文件，请在项目的 `.gemini/` 目录中创建一个名为 `sandbox-macos-<profile_name>.sb` 的文件（例如 `my-project/.gemini/sandbox-macos-custom.sb`）。
- **`DEBUG` 或 `DEBUG_MODE`** (通常由底层库或 CLI 本身使用):
  - 设置为 `true` 或 `1` 以启用详细的调试日志记录，这有助于故障排除。
- **`NO_COLOR`**:
  - 设置为任何值以禁用 CLI 中的所有颜色输出。
- **`CLI_TITLE`**:
  - 设置为字符串以自定义 CLI 的标题。
- **`CODE_ASSIST_ENDPOINT`**:
  - 指定代码辅助服务器的端点。
  - 这对于开发和测试很有用。

## Command-Line Arguments

## 命令行参数

Arguments passed directly when running the CLI can override other configurations for that specific session.

在运行 CLI 时直接传递的参数可以覆盖该特定会话的其他配置。

- **`--model <model_name>`** (**`-m <model_name>`**):
  - Specifies the Gemini model to use for this session.
  - Example: `npm start -- --model gemini-1.5-pro-latest`
- **`--prompt <your_prompt>`** (**`-p <your_prompt>`**):
  - Used to pass a prompt directly to the command. This invokes Gemini CLI in a non-interactive mode.
- **`--sandbox`** (**`-s`**):
  - Enables sandbox mode for this session.
- **`--sandbox-image`**:
  - Sets the sandbox image URI.
- **`--debug`** (**`-d`**):
  - Enables debug mode for this session, providing more verbose output.
- **`--all-files`** (**`-a`**):
  - If set, recursively includes all files within the current directory as context for the prompt.
- **`--help`** (or **`-h`**):
  - Displays help information about command-line arguments.
- **`--show-memory-usage`**:
  - Displays the current memory usage.
- **`--yolo`**:
  - Enables YOLO mode, which automatically approves all tool calls.
- **`--telemetry`**:
  - Enables [telemetry](../telemetry.md).
- **`--telemetry-target`**:
  - Sets the telemetry target. See [telemetry](../telemetry.md) for more information.
- **`--telemetry-otlp-endpoint`**:
  - Sets the OTLP endpoint for telemetry. See [telemetry](../telemetry.md) for more information.
- **`--telemetry-log-prompts`**:
  - Enables logging of prompts for telemetry. See [telemetry](../telemetry.md) for more information.
- **`--checkpointing`**:
  - Enables [checkpointing](../checkpointing.md).
- **`--extensions <extension_name ...>`** (**`-e <extension_name ...>`**):
  - Specifies a list of extensions to use for the session. If not provided, all available extensions are used.
  - Use the special term `gemini -e none` to disable all extensions.
  - Example: `gemini -e my-extension -e my-other-extension`
- **`--list-extensions`** (**`-l`**):
  - Lists all available extensions and exits.
- **`--proxy`**:
  - Sets the proxy for the CLI.
  - Example: `--proxy http://localhost:7890`.
- **`--version`**:
  - Displays the version of the CLI.

- **`--model <model_name>`** (**`-m <model_name>`**):
  - 指定此会话要使用的 Gemini 模型。
  - 示例：`npm start -- --model gemini-1.5-pro-latest`
- **`--prompt <your_prompt>`** (**`-p <your_prompt>`**):
  - 用于直接向命令传递提示。这将以非交互模式调用 Gemini CLI。
- **`--sandbox`** (**`-s`**):
  - 为此会话启用沙盒模式。
- **`--sandbox-image`**:
  - 设置沙盒镜像 URI。
- **`--debug`** (**`-d`**):
  - 为此会话启用调试模式，提供更详细的输出。
- **`--all-files`** (**`-a`**):
  - 如果设置，则递归地将当前目录中的所有文件作为提示的上下文。
- **`--help`** (或 **`-h`**):
  - 显示有关命令行参数的帮助信息。
- **`--show-memory-usage`**:
  - 显示当前内存使用情况。
- **`--yolo`**:
  - 启用 YOLO 模式，该模式会自动批准所有工具调用。
- **`--telemetry`**:
  - 启用[遥测](../telemetry.md)。
- **`--telemetry-target`**:
  - 设置遥测目标。有关更多信息，请参阅[遥测](../telemetry.md)。
- **`--telemetry-otlp-endpoint`**:
  - 设置遥测的 OTLP 端点。有关更多信息，请参阅[遥测](../telemetry.md)。
- **`--telemetry-log-prompts`**:
  - 启用遥测的提示日志记录。有关更多信息，请参阅[遥测](../telemetry.md)。
- **`--checkpointing`**:
  - 启用[检查点](../checkpointing.md)。
- **`--extensions <extension_name ...>`** (**`-e <extension_name ...>`**):
  - 指定会话要使用的扩展列表。如果未提供，则使用所有可用的扩展。
  - 使用特殊术语 `gemini -e none` 禁用所有扩展。
  - 示例：`gemini -e my-extension -e my-other-extension`
- **`--list-extensions`** (**`-l`**):
  - 列出所有可用的扩展并退出。
- **`--proxy`**:
  - 设置 CLI 的代理。
  - 示例：`--proxy http://localhost:7890`。
- **`--version`**:
  - 显示 CLI 的版本。

## Context Files (Hierarchical Instructional Context)

## 上下文文件（分层指令性上下文）

While not strictly configuration for the CLI's _behavior_, context files (defaulting to `GEMINI.md` but configurable via the `contextFileName` setting) are crucial for configuring the _instructional context_ (also referred to as "memory") provided to the Gemini model. This powerful feature allows you to give project-specific instructions, coding style guides, or any relevant background information to the AI, making its responses more tailored and accurate to your needs. The CLI includes UI elements, such as an indicator in the footer showing the number of loaded context files, to keep you informed about the active context.

虽然上下文文件（默认为 `GEMINI.md`，但可通过 `contextFileName` 设置进行配置）并非严格意义上用于配置 CLI 的*行为*，但它们对于配置提供给 Gemini 模型的*指令性上下文*（也称为“记忆”）至关重要。这个强大的功能允许您向 AI 提供项目特定的指令、编码风格指南或任何相关的背景信息，使其响应更贴合您的需求、更准确。CLI 包含 UI 元素，例如页脚中显示已加载上下文文件数量的指示器，让您随时了解活动的上下文。

- **Purpose:** These Markdown files contain instructions, guidelines, or context that you want the Gemini model to be aware of during your interactions. The system is designed to manage this instructional context hierarchically.

- **目的：** 这些 Markdown 文件包含您希望 Gemini 模型在交互过程中了解的指令、指南或上下文。该系统旨在分层管理此指令性上下文。

### Example Context File Content (e.g., `GEMINI.md`)

### 上下文文件内容示例 (例如, `GEMINI.md`)

Here's a conceptual example of what a context file at the root of a TypeScript project might contain:

这是一个概念性示例，展示了 TypeScript 项目根目录下的上下文文件可能包含的内容：

```markdown
# Project: My Awesome TypeScript Library

## General Instructions:

- When generating new TypeScript code, please follow the existing coding style.
- Ensure all new functions and classes have JSDoc comments.
- Prefer functional programming paradigms where appropriate.
- All code should be compatible with TypeScript 5.0 and Node.js 20+.

## Coding Style:

- Use 2 spaces for indentation.
- Interface names should be prefixed with `I` (e.g., `IUserService`).
- Private class members should be prefixed with an underscore (`_`).
- Always use strict equality (`===` and `!==`).

## Specific Component: `src/api/client.ts`

- This file handles all outbound API requests.
- When adding new API call functions, ensure they include robust error handling and logging.
- Use the existing `fetchWithRetry` utility for all GET requests.

## Regarding Dependencies:

- Avoid introducing new external dependencies unless absolutely necessary.
- If a new dependency is required, please state the reason.
```

```markdown
# 项目：我的超棒 TypeScript 库

## 通用指令：

- 生成新的 TypeScript 代码时，请遵循现有的编码风格。
- 确保所有新函数和类都有 JSDoc 注释。
- 在适当的情况下，优先使用函数式编程范式。
- 所有代码都应与 TypeScript 5.0 和 Node.js 20+ 兼容。

## 编码风格：

- 使用 2 个空格进行缩进。
- 接口名称应以 `I` 为前缀（例如 `IUserService`）。
- 私有类成员应以下划线 (`_`) 为前缀。
- 始终使用严格相等 (`===` 和 `!==`)。

## 特定组件：`src/api/client.ts`

- 此文件处理所有出站 API 请求。
- 添加新的 API 调用函数时，请确保它们包含健壮的错误处理和日志记录。
- 对所有 GET 请求使用现有的 `fetchWithRetry` 实用程序。

## 关于依赖：

- 除非绝对必要，否则避免引入新的外部依赖。
- 如果需要新的依赖，请说明原因。
```

This example demonstrates how you can provide general project context, specific coding conventions, and even notes about particular files or components. The more relevant and precise your context files are, the better the AI can assist you. Project-specific context files are highly encouraged to establish conventions and context.

这个例子演示了如何提供常规的项目上下文、特定的编码约定，甚至关于特定文件或组件的说明。您的上下文文件越相关、越精确，AI 就能更好地为您提供帮助。强烈建议使用项目特定的上下文文件来建立约定和上下文。

- **Hierarchical Loading and Precedence:** The CLI implements a sophisticated hierarchical memory system by loading context files (e.g., `GEMINI.md`) from several locations. Content from files lower in this list (more specific) typically overrides or supplements content from files higher up (more general). The exact concatenation order and final context can be inspected using the `/memory show` command. The typical loading order is:
  1.  **Global Context File:**
      - Location: `~/.gemini/<contextFileName>` (e.g., `~/.gemini/GEMINI.md` in your user home directory).
      - Scope: Provides default instructions for all your projects.
  2.  **Project Root & Ancestors Context Files:**
      - Location: The CLI searches for the configured context file in the current working directory and then in each parent directory up to either the project root (identified by a `.git` folder) or your home directory.
      - Scope: Provides context relevant to the entire project or a significant portion of it.
  3.  **Sub-directory Context Files (Contextual/Local):**
      - Location: The CLI also scans for the configured context file in subdirectories _below_ the current working directory (respecting common ignore patterns like `node_modules`, `.git`, etc.).
      - Scope: Allows for highly specific instructions relevant to a particular component, module, or subsection of your project.
- **Concatenation & UI Indication:** The contents of all found context files are concatenated (with separators indicating their origin and path) and provided as part of the system prompt to the Gemini model. The CLI footer displays the count of loaded context files, giving you a quick visual cue about the active instructional context.
- **Commands for Memory Management:**
  - Use `/memory refresh` to force a re-scan and reload of all context files from all configured locations. This updates the AI's instructional context.
  - Use `/memory show` to display the combined instructional context currently loaded, allowing you to verify the hierarchy and content being used by the AI.
  - See the [Commands documentation](./commands.md#memory) for full details on the `/memory` command and its sub-commands (`show` and `refresh`).

- **分层加载和优先级：** CLI 通过从多个位置加载上下文文件（例如 `GEMINI.md`）来实现一个复杂的分层记忆系统。列表中位置较低（更具体）的文件内容通常会覆盖或补充位置较高（更通用）的文件内容。可以使用 `/memory show` 命令检查确切的串联顺序和最终上下文。典型的加载顺序是：
  1.  **全局上下文文件：**
      - 位置：`~/.gemini/<contextFileName>`（例如，用户主目录中的 `~/.gemini/GEMINI.md`）。
      - 范围：为您所有的项目提供默认指令。
  2.  **项目根目录和祖先目录上下文文件：**
      - 位置：CLI 在当前工作目录中搜索配置的上下文文件，然后在每个父目录中向上搜索，直到项目根目录（由 `.git` 文件夹标识）或您的主目录。
      - 范围：提供与整个项目或其重要部分相关的上下文。
  3.  **子目录上下文文件（上下文/本地）：**
      - 位置：CLI 还会扫描当前工作目录*下方*的子目录中配置的上下文文件（遵循常见的忽略模式，如 `node_modules`、`.git` 等）。
      - 范围：允许提供与项目的特定组件、模块或子部分相关的非常具体的指令。
- **串联和 UI 指示：** 所有找到的上下文文件的内容都会被串联起来（带有指示其来源和路径的分隔符），并作为系统提示的一部分提供给 Gemini 模型。CLI 页脚会显示已加载上下文文件的数量，为您提供有关活动指令性上下文的快速视觉提示。
- **记忆管理命令：**
  - 使用 `/memory refresh` 强制从所有配置的位置重新扫描和重新加载所有上下文文件。这将更新 AI 的指令性上下文。
  - 使用 `/memory show` 显示当前加载的组合指令性上下文，让您验证 AI 正在使用的层次结构和内容。
  - 有关 `/memory` 命令及其子命令（`show` 和 `refresh`）的完整详细信息，请参阅[命令文档](./commands.md#memory)。

By understanding and utilizing these configuration layers and the hierarchical nature of context files, you can effectively manage the AI's memory and tailor the Gemini CLI's responses to your specific needs and projects.

通过理解和利用这些配置层以及上下文文件的分层特性，您可以有效地管理 AI 的记忆，并根据您的特定需求和项目定制 Gemini CLI 的响应。

## Sandboxing

## 沙盒

The Gemini CLI can execute potentially unsafe operations (like shell commands and file modifications) within a sandboxed environment to protect your system.

Gemini CLI 可以在沙盒环境中执行潜在不安全的操作（如 shell 命令和文件修改），以保护您的系统。

Sandboxing is disabled by default, but you can enable it in a few ways:

沙盒默认是禁用的，但您可以通过以下几种方式启用它：

- Using `--sandbox` or `-s` flag.
- Setting `GEMINI_SANDBOX` environment variable.
- Sandbox is enabled in `--yolo` mode by default.

- 使用 `--sandbox` 或 `-s` 标志。
- 设置 `GEMINI_SANDBOX` 环境变量。
- 在 `--yolo` 模式下，沙盒默认启用。

By default, it uses a pre-built `gemini-cli-sandbox` Docker image.

默认情况下，它使用一个预构建的 `gemini-cli-sandbox` Docker 镜像。

For project-specific sandboxing needs, you can create a custom Dockerfile at `.gemini/sandbox.Dockerfile` in your project's root directory. This Dockerfile can be based on the base sandbox image:

对于特定于项目的沙盒需求，您可以在项目根目录的 `.gemini/sandbox.Dockerfile` 处创建一个自定义的 Dockerfile。这个 Dockerfile 可以基于基础沙盒镜像：

```dockerfile
FROM gemini-cli-sandbox

# Add your custom dependencies or configurations here
# For example:
# RUN apt-get update && apt-get install -y some-package
# COPY ./my-config /app/my-config
```

```dockerfile
FROM gemini-cli-sandbox

# 在此处添加您的自定义依赖项或配置
# 例如：
# RUN apt-get update && apt-get install -y some-package
# COPY ./my-config /app/my-config
```

When `.gemini/sandbox.Dockerfile` exists, you can use `BUILD_SANDBOX` environment variable when running Gemini CLI to automatically build the custom sandbox image:

当 `.gemini/sandbox.Dockerfile` 存在时，您可以在运行 Gemini CLI 时使用 `BUILD_SANDBOX` 环境变量来自动构建自定义沙盒镜像：

```bash
BUILD_SANDBOX=1 gemini -s
```

```bash
BUILD_SANDBOX=1 gemini -s
```

## Usage Statistics

## 使用情况统计

To help us improve the Gemini CLI, we collect anonymized usage statistics. This data helps us understand how the CLI is used, identify common issues, and prioritize new features.

为了帮助我们改进 Gemini CLI，我们会收集匿名的使用情况统计数据。这些数据有助于我们了解 CLI 的使用方式，识别常见问题，并确定新功能的优先级。

**What we collect:**

**我们收集什么：**

- **Tool Calls:** We log the names of the tools that are called, whether they succeed or fail, and how long they take to execute. We do not collect the arguments passed to the tools or any data returned by them.
- **API Requests:** We log the Gemini model used for each request, the duration of the request, and whether it was successful. We do not collect the content of the prompts or responses.
- **Session Information:** We collect information about the configuration of the CLI, such as the enabled tools and the approval mode.

- **工具调用：** 我们记录被调用的工具名称、它们是成功还是失败，以及执行所需的时间。我们不收集传递给工具的参数或它们返回的任何数据。
- **API 请求：** 我们记录每个请求使用的 Gemini 模型、请求的持续时间以及它是否成功。我们不收集提示或响应的内容。
- **会话信息：** 我们收集有关 CLI 配置的信息，例如启用的工具和批准模式。

**What we DON'T collect:**

**我们不收集什么：**

- **Personally Identifiable Information (PII):** We do not collect any personal information, such as your name, email address, or API keys.
- **Prompt and Response Content:** We do not log the content of your prompts or the responses from the Gemini model.
- **File Content:** We do not log the content of any files that are read or written by the CLI.

- **个人身份信息 (PII):** 我们不收集任何个人信息，例如您的姓名、电子邮件地址或 API 密钥。
- **提示和响应内容：** 我们不记录您的提示内容或 Gemini 模型的响应。
- **文件内容：** 我们不记录 CLI 读取或写入的任何文件的内容。

**How to opt out:**

**如何选择退出：**

You can opt out of usage statistics collection at any time by setting the `usageStatisticsEnabled` property to `false` in your `settings.json` file:

您可以随时通过在 `settings.json` 文件中将 `usageStatisticsEnabled` 属性设置为 `false` 来选择退出使用情况统计信息的收集：

```json
{
  "usageStatisticsEnabled": false
}
```

```json
{
  "usageStatisticsEnabled": false
}
```
