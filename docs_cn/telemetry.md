Loaded cached credentials.
# Gemini CLI Observability Guide

# Gemini CLI 可观测性指南

Telemetry provides data about Gemini CLI's performance, health, and usage. By enabling it, you can monitor operations, debug issues, and optimize tool usage through traces, metrics, and structured logs.

遥测提供了有关 Gemini CLI 性能、健康状况和使用情况的数据。通过启用遥测，您可以通过追踪、指标和结构化日志来监控操作、调试问题并优化工具使用。

Gemini CLI's telemetry system is built on the **[OpenTelemetry] (OTEL)** standard, allowing you to send data to any compatible backend.

Gemini CLI 的遥测系统建立在 **[OpenTelemetry] (OTEL)** 标准之上，允许您将数据发送到任何兼容的后端。

[OpenTelemetry]: https://opentelemetry.io/

[OpenTelemetry]: https://opentelemetry.io/

## Enabling telemetry

## 启用遥测

You can enable telemetry in multiple ways. Configuration is primarily managed via the [`.gemini/settings.json` file](./cli/configuration.md) and environment variables, but CLI flags can override these settings for a specific session.

您可以通过多种方式启用遥测。配置主要通过 [`.gemini/settings.json` 文件](./cli/configuration.md) 和环境变量进行管理，但 CLI 标志可以覆盖特定会话的这些设置。

### Order of precedence

### 优先级顺序

The following lists the precedence for applying telemetry settings, with items listed higher having greater precedence:

以下列表说明了应用遥测设置的优先级，列表中位置越高的项目优先级越高：

1.  **CLI flags (for `gemini` command):**
    - `--telemetry` / `--no-telemetry`: Overrides `telemetry.enabled`.
    - `--telemetry-target <local|gcp>`: Overrides `telemetry.target`.
    - `--telemetry-otlp-endpoint <URL>`: Overrides `telemetry.otlpEndpoint`.
    - `--telemetry-log-prompts` / `--no-telemetry-log-prompts`: Overrides `telemetry.logPrompts`.

1.  **CLI 标志 (用于 `gemini` 命令):**
    - `--telemetry` / `--no-telemetry`: 覆盖 `telemetry.enabled`。
    - `--telemetry-target <local|gcp>`: 覆盖 `telemetry.target`。
    - `--telemetry-otlp-endpoint <URL>`: 覆盖 `telemetry.otlpEndpoint`。
    - `--telemetry-log-prompts` / `--no-telemetry-log-prompts`: 覆盖 `telemetry.logPrompts`。

1.  **Environment variables:**
    - `OTEL_EXPORTER_OTLP_ENDPOINT`: Overrides `telemetry.otlpEndpoint`.

1.  **环境变量:**
    - `OTEL_EXPORTER_OTLP_ENDPOINT`: 覆盖 `telemetry.otlpEndpoint`。

1.  **Workspace settings file (`.gemini/settings.json`):** Values from the `telemetry` object in this project-specific file.

1.  **工作区配置文件 (`.gemini/settings.json`):** 来自此项目特定文件中 `telemetry` 对象的值。

1.  **User settings file (`~/.gemini/settings.json`):** Values from the `telemetry` object in this global user file.

1.  **用户配置文件 (`~/.gemini/settings.json`):** 来自此全局用户文件中 `telemetry` 对象的值。

1.  **Defaults:** applied if not set by any of the above.
    - `telemetry.enabled`: `false`
    - `telemetry.target`: `local`
    - `telemetry.otlpEndpoint`: `http://localhost:4317`
    - `telemetry.logPrompts`: `true`

1.  **默认值:** 如果以上任何方式都未设置，则应用默认值。
    - `telemetry.enabled`: `false`
    - `telemetry.target`: `local`
    - `telemetry.otlpEndpoint`: `http://localhost:4317`
    - `telemetry.logPrompts`: `true`

**For the `npm run telemetry -- --target=<gcp|local>` script:**
The `--target` argument to this script _only_ overrides the `telemetry.target` for the duration and purpose of that script (i.e., choosing which collector to start). It does not permanently change your `settings.json`. The script will first look at `settings.json` for a `telemetry.target` to use as its default.

**对于 `npm run telemetry -- --target=<gcp|local>` 脚本:**
此脚本的 `--target` 参数*仅*在该脚本的持续时间和目的内覆盖 `telemetry.target`（即选择要启动哪个收集器）。它不会永久更改您的 `settings.json`。该脚本将首先在 `settings.json` 中查找 `telemetry.target` 作为其默认值。

### Example settings

### 示例设置

The following code can be added to your workspace (`.gemini/settings.json`) or user (`~/.gemini/settings.json`) settings to enable telemetry and send the output to Google Cloud:

以下代码可以添加到您的工作区 (`.gemini/settings.json`) 或用户 (`~/.gemini/settings.json`) 设置中，以启用遥测并将输出发送到 Google Cloud：

```json
{
  "telemetry": {
    "enabled": true,
    "target": "gcp"
  },
  "sandbox": false
}
```

```json
{
  "telemetry": {
    "enabled": true,
    "target": "gcp"
  },
  "sandbox": false
}
```

## Running an OTEL Collector

## 运行 OTEL Collector

An OTEL Collector is a service that receives, processes, and exports telemetry data.
The CLI sends data using the OTLP/gRPC protocol.

OTEL Collector 是一项接收、处理和导出遥测数据的服务。
CLI 使用 OTLP/gRPC 协议发送数据。

Learn more about OTEL exporter standard configuration in [documentation][otel-config-docs].

在[文档][otel-config-docs]中了解有关 OTEL 导出器标准配置的更多信息。

[otel-config-docs]: https://opentelemetry.io/docs/languages/sdk-configuration/otlp-exporter/

[otel-config-docs]: https://opentelemetry.io/docs/languages/sdk-configuration/otlp-exporter/

### Local

### 本地

Use the `npm run telemetry -- --target=local` command to automate the process of setting up a local telemetry pipeline, including configuring the necessary settings in your `.gemini/settings.json` file. The underlying script installs `otelcol-contrib` (the OpenTelemetry Collector) and `jaeger` (The Jaeger UI for viewing traces). To use it:

使用 `npm run telemetry -- --target=local` 命令来自动化设置本地遥测管道的过程，包括在您的 `.gemini/settings.json` 文件中配置必要的设置。其底层脚本会安装 `otelcol-contrib` (OpenTelemetry Collector) 和 `jaeger` (用于查看追踪的 Jaeger UI)。使用方法如下：

1.  **Run the command**:
    Execute the command from the root of the repository:

    ```bash
    npm run telemetry -- --target=local
    ```

    The script will:
    - Download Jaeger and OTEL if needed.
    - Start a local Jaeger instance.
    - Start an OTEL collector configured to receive data from Gemini CLI.
    - Automatically enable telemetry in your workspace settings.
    - On exit, disable telemetry.

1.  **运行命令**:
    在仓库的根目录执行该命令：

    ```bash
    npm run telemetry -- --target=local
    ```

    该脚本将：
    - 如果需要，下载 Jaeger 和 OTEL。
    - 启动一个本地 Jaeger 实例。
    - 启动一个配置为从 Gemini CLI 接收数据的 OTEL collector。
    - 在您的工作区设置中自动启用遥测。
    - 退出时，禁用遥测。

1.  **View traces**:
    Open your web browser and navigate to **http://localhost:16686** to access the Jaeger UI. Here you can inspect detailed traces of Gemini CLI operations.

1.  **查看追踪**:
    打开您的网络浏览器并访问 **http://localhost:16686** 来访问 Jaeger UI。在这里您可以检查 Gemini CLI 操作的详细追踪。

1.  **Inspect logs and metrics**:
    The script redirects the OTEL collector output (which includes logs and metrics) to `~/.gemini/tmp/<projectHash>/otel/collector.log`. The script will provide links to view and a command to tail your telemetry data (traces, metrics, logs) locally.

1.  **检查日志和指标**:
    该脚本将 OTEL collector 的输出（包括日志和指标）重定向到 `~/.gemini/tmp/<projectHash>/otel/collector.log`。该脚本将提供链接以及一个命令，用于在本地跟踪您的遥测数据（追踪、指标、日志）。

1.  **Stop the services**:
    Press `Ctrl+C` in the terminal where the script is running to stop the OTEL Collector and Jaeger services.

1.  **停止服务**:
    在运行脚本的终端中按 `Ctrl+C` 来停止 OTEL Collector 和 Jaeger 服务。

### Google Cloud

### Google Cloud

Use the `npm run telemetry -- --target=gcp` command to automate setting up a local OpenTelemetry collector that forwards data to your Google Cloud project, including configuring the necessary settings in your `.gemini/settings.json` file. The underlying script installs `otelcol-contrib`. To use it:

使用 `npm run telemetry -- --target=gcp` 命令来自动化设置一个本地 OpenTelemetry collector，该 collector 会将数据转发到您的 Google Cloud 项目，包括在您的 `.gemini/settings.json` 文件中配置必要的设置。其底层脚本会安装 `otelcol-contrib`。使用方法如下：

1.  **Prerequisites**:
    - Have a Google Cloud project ID.
    - Export the `GOOGLE_CLOUD_PROJECT` environment variable to make it available to the OTEL collector.
      ```bash
      export OTLP_GOOGLE_CLOUD_PROJECT="your-project-id"
      ```
    - Authenticate with Google Cloud (e.g., run `gcloud auth application-default login` or ensure `GOOGLE_APPLICATION_CREDENTIALS` is set).
    - Ensure your Google Cloud account/service account has the necessary IAM roles: "Cloud Trace Agent", "Monitoring Metric Writer", and "Logs Writer".

1.  **先决条件**:
    - 拥有一个 Google Cloud 项目 ID。
    - 导出 `GOOGLE_CLOUD_PROJECT` 环境变量，使其对 OTEL collector 可用。
      ```bash
      export OTLP_GOOGLE_CLOUD_PROJECT="your-project-id"
      ```
    - 使用 Google Cloud 进行身份验证（例如，运行 `gcloud auth application-default login` 或确保 `GOOGLE_APPLICATION_CREDENTIALS` 已设置）。
    - 确保您的 Google Cloud 帐户/服务帐户具有必要的 IAM 角色：“Cloud Trace Agent”、“Monitoring Metric Writer” 和 “Logs Writer”。

1.  **Run the command**:
    Execute the command from the root of the repository:

    ```bash
    npm run telemetry -- --target=gcp
    ```

    The script will:
    - Download the `otelcol-contrib` binary if needed.
    - Start an OTEL collector configured to receive data from Gemini CLI and export it to your specified Google Cloud project.
    - Automatically enable telemetry and disable sandbox mode in your workspace settings (`.gemini/settings.json`).
    - Provide direct links to view traces, metrics, and logs in your Google Cloud Console.
    - On exit (Ctrl+C), it will attempt to restore your original telemetry and sandbox settings.

1.  **运行命令**:
    在仓库的根目录执行该命令：

    ```bash
    npm run telemetry -- --target=gcp
    ```

    该脚本将：
    - 如果需要，下载 `otelcol-contrib` 二进制文件。
    - 启动一个 OTEL collector，配置为从 Gemini CLI 接收数据并将其导出到您指定的 Google Cloud 项目。
    - 在您的工作区设置 (`.gemini/settings.json`) 中自动启用遥测并禁用沙盒模式。
    - 提供直接链接以在您的 Google Cloud Console 中查看追踪、指标和日志。
    - 退出时 (Ctrl+C)，它将尝试恢复您原始的遥测和沙盒设置。

1.  **Run Gemini CLI:**
    In a separate terminal, run your Gemini CLI commands. This generates telemetry data that the collector captures.

1.  **运行 Gemini CLI:**
    在一个单独的终端中，运行您的 Gemini CLI 命令。这将生成遥测数据，并由 collector 捕获。

1.  **View telemetry in Google Cloud**:
    Use the links provided by the script to navigate to the Google Cloud Console and view your traces, metrics, and logs.

1.  **在 Google Cloud 中查看遥测**:
    使用脚本提供的链接导航到 Google Cloud Console 查看您的追踪、指标和日志。

1.  **Inspect local collector logs**:
    The script redirects the local OTEL collector output to `~/.gemini/tmp/<projectHash>/otel/collector-gcp.log`. The script provides links to view and command to tail your collector logs locally.

1.  **检查本地 collector 日志**:
    该脚本将本地 OTEL collector 的输出重定向到 `~/.gemini/tmp/<projectHash>/otel/collector-gcp.log`。该脚本提供了链接以及一个命令，用于在本地跟踪您的 collector 日志。

1.  **Stop the service**:
    Press `Ctrl+C` in the terminal where the script is running to stop the OTEL Collector.

1.  **停止服务**:
    在运行脚本的终端中按 `Ctrl+C` 来停止 OTEL Collector。

## Logs and metric reference

## 日志和指标参考

The following section describes the structure of logs and metrics generated for Gemini CLI.

以下部分描述了为 Gemini CLI 生成的日志和指标的结构。

- A `sessionId` is included as a common attribute on all logs and metrics.

- `sessionId` 作为通用属性包含在所有日志和指标中。

### Logs

### 日志

Logs are timestamped records of specific events. The following events are logged for Gemini CLI:

日志是特定事件的带时间戳的记录。为 Gemini CLI 记录了以下事件：

- `gemini_cli.config`: This event occurs once at startup with the CLI's configuration.
  - **Attributes**:
    - `model` (string)
    - `embedding_model` (string)
    - `sandbox_enabled` (boolean)
    - `core_tools_enabled` (string)
    - `approval_mode` (string)
    - `api_key_enabled` (boolean)
    - `vertex_ai_enabled` (boolean)
    - `code_assist_enabled` (boolean)
    - `log_prompts_enabled` (boolean)
    - `file_filtering_respect_git_ignore` (boolean)
    - `debug_mode` (boolean)
    - `mcp_servers` (string)

- `gemini_cli.config`: 此事件在启动时发生一次，包含 CLI 的配置。
  - **属性**:
    - `model` (string)
    - `embedding_model` (string)
    - `sandbox_enabled` (boolean)
    - `core_tools_enabled` (string)
    - `approval_mode` (string)
    - `api_key_enabled` (boolean)
    - `vertex_ai_enabled` (boolean)
    - `code_assist_enabled` (boolean)
    - `log_prompts_enabled` (boolean)
    - `file_filtering_respect_git_ignore` (boolean)
    - `debug_mode` (boolean)
    - `mcp_servers` (string)

- `gemini_cli.user_prompt`: This event occurs when a user submits a prompt.
  - **Attributes**:
    - `prompt_length`
    - `prompt` (this attribute is excluded if `log_prompts_enabled` is configured to be `false`)
    - `auth_type`

- `gemini_cli.user_prompt`: 此事件在用户提交提示时发生。
  - **属性**:
    - `prompt_length`
    - `prompt` (如果 `log_prompts_enabled` 配置为 `false`，则排除此属性)
    - `auth_type`

- `gemini_cli.tool_call`: This event occurs for each function call.
  - **Attributes**:
    - `function_name`
    - `function_args`
    - `duration_ms`
    - `success` (boolean)
    - `decision` (string: "accept", "reject", or "modify", if applicable)
    - `error` (if applicable)
    - `error_type` (if applicable)

- `gemini_cli.tool_call`: 此事件在每次函数调用时发生。
  - **属性**:
    - `function_name`
    - `function_args`
    - `duration_ms`
    - `success` (boolean)
    - `decision` (string: "accept", "reject", 或 "modify", 如果适用)
    - `error` (如果适用)
    - `error_type` (如果适用)

- `gemini_cli.api_request`: This event occurs when making a request to Gemini API.
  - **Attributes**:
    - `model`
    - `request_text` (if applicable)

- `gemini_cli.api_request`: 此事件在向 Gemini API 发出请求时发生。
  - **属性**:
    - `model`
    - `request_text` (如果适用)

- `gemini_cli.api_error`: This event occurs if the API request fails.
  - **Attributes**:
    - `model`
    - `error`
    - `error_type`
    - `status_code`
    - `duration_ms`
    - `auth_type`

- `gemini_cli.api_error`: 此事件在 API 请求失败时发生。
  - **属性**:
    - `model`
    - `error`
    - `error_type`
    - `status_code`
    - `duration_ms`
    - `auth_type`

- `gemini_cli.api_response`: This event occurs upon receiving a response from Gemini API.
  - **Attributes**:
    - `model`
    - `status_code`
    - `duration_ms`
    - `error` (optional)
    - `input_token_count`
    - `output_token_count`
    - `cached_content_token_count`
    - `thoughts_token_count`
    - `tool_token_count`
    - `response_text` (if applicable)
    - `auth_type`

- `gemini_cli.api_response`: 此事件在收到 Gemini API 的响应时发生。
  - **属性**:
    - `model`
    - `status_code`
    - `duration_ms`
    - `error` (可选)
    - `input_token_count`
    - `output_token_count`
    - `cached_content_token_count`
    - `thoughts_token_count`
    - `tool_token_count`
    - `response_text` (如果适用)
    - `auth_type`

- `gemini_cli.flash_fallback`: This event occurs when Gemini CLI switches to flash as fallback.
  - **Attributes**:
    - `auth_type`

- `gemini_cli.flash_fallback`: 此事件在 Gemini CLI 切换到 flash 作为备用方案时发生。
  - **属性**:
    - `auth_type`

### Metrics

### 指标

Metrics are numerical measurements of behavior over time. The following metrics are collected for Gemini CLI:

指标是行为随时间变化的数值度量。为 Gemini CLI 收集了以下指标：

- `gemini_cli.session.count` (Counter, Int): Incremented once per CLI startup.

- `gemini_cli.session.count` (Counter, Int): 每次 CLI 启动时递增一次。

- `gemini_cli.tool.call.count` (Counter, Int): Counts tool calls.
  - **Attributes**:
    - `function_name`
    - `success` (boolean)
    - `decision` (string: "accept", "reject", or "modify", if applicable)

- `gemini_cli.tool.call.count` (Counter, Int): 统计工具调用次数。
  - **属性**:
    - `function_name`
    - `success` (boolean)
    - `decision` (string: "accept", "reject", 或 "modify", 如果适用)

- `gemini_cli.tool.call.latency` (Histogram, ms): Measures tool call latency.
  - **Attributes**:
    - `function_name`
    - `decision` (string: "accept", "reject", or "modify", if applicable)

- `gemini_cli.tool.call.latency` (Histogram, ms): 测量工具调用延迟。
  - **属性**:
    - `function_name`
    - `decision` (string: "accept", "reject", 或 "modify", 如果适用)

- `gemini_cli.api.request.count` (Counter, Int): Counts all API requests.
  - **Attributes**:
    - `model`
    - `status_code`
    - `error_type` (if applicable)

- `gemini_cli.api.request.count` (Counter, Int): 统计所有 API 请求次数。
  - **属性**:
    - `model`
    - `status_code`
    - `error_type` (如果适用)

- `gemini_cli.api.request.latency` (Histogram, ms): Measures API request latency.
  - **Attributes**:
    - `model`

- `gemini_cli.api.request.latency` (Histogram, ms): 测量 API 请求延迟。
  - **属性**:
    - `model`

- `gemini_cli.token.usage` (Counter, Int): Counts the number of tokens used.
  - **Attributes**:
    - `model`
    - `type` (string: "input", "output", "thought", "cache", or "tool")

- `gemini_cli.token.usage` (Counter, Int): 统计使用的 token 数量。
  - **属性**:
    - `model`
    - `type` (string: "input", "output", "thought", "cache", 或 "tool")

- `gemini_cli.file.operation.count` (Counter, Int): Counts file operations.
  - **Attributes**:
    - `operation` (string: "create", "read", "update"): The type of file operation.
    - `lines` (Int, if applicable): Number of lines in the file.
    - `mimetype` (string, if applicable): Mimetype of the file.
    - `extension` (string, if applicable): File extension of the file.

- `gemini_cli.file.operation.count` (Counter, Int): 统计文件操作次数。
  - **属性**:
    - `operation` (string: "create", "read", "update"): 文件操作的类型。
    - `lines` (Int, 如果适用): 文件中的行数。
    - `mimetype` (string, 如果适用): 文件的 Mimetype。
    - `extension` (string, 如果适用): 文件的扩展名。
