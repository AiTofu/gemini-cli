Loaded cached credentials.
# 使用 Gemini CLI 配置 MCP 服务器

# MCP servers with the Gemini CLI

本文档提供了通过 Gemini CLI 配置和使用模型上下文协议 (Model Context Protocol, MCP) 服务器的指南。

This document provides a guide to configuring and using Model Context Protocol (MCP) servers with the Gemini CLI.

## 什么是 MCP 服务器？

## What is an MCP server?

MCP 服务器是一个通过模型上下文协议向 Gemini CLI 公开工具和资源的应用程序，允许它与外部系统和数据源进行交互。MCP 服务器充当 Gemini 模型与您的本地环境或其他服务（如 API）之间的桥梁。

An MCP server is an application that exposes tools and resources to the Gemini CLI through the Model Context Protocol, allowing it to interact with external systems and data sources. MCP servers act as a bridge between the Gemini model and your local environment or other services like APIs.

MCP 服务器使 Gemini CLI 能够：

An MCP server enables the Gemini CLI to:

- **发现工具：** 通过标准化的模式定义列出可用的工具、它们的描述和参数。
- **Discover tools:** List available tools, their descriptions, and parameters through standardized schema definitions.
- **执行工具：** 使用定义的参数调用特定工具并接收结构化的响应。
- **Execute tools:** Call specific tools with defined arguments and receive structured responses.
- **访问资源：** 从特定资源读取数据（尽管 Gemini CLI 主要关注工具执行）。
- **Access resources:** Read data from specific resources (though the Gemini CLI primarily focuses on tool execution).

通过 MCP 服务器，您可以扩展 Gemini CLI 的能力，以执行其内置功能之外的操作，例如与数据库、API、自定义脚本或专用工作流进行交互。

With an MCP server, you can extend the Gemini CLI's capabilities to perform actions beyond its built-in features, such as interacting with databases, APIs, custom scripts, or specialized workflows.

## 核心集成架构

## Core Integration Architecture

Gemini CLI 通过内置于核心包 (`packages/core/src/tools/`) 中的复杂的发现和执行系统与 MCP 服务器集成：

The Gemini CLI integrates with MCP servers through a sophisticated discovery and execution system built into the core package (`packages/core/src/tools/`):

### 发现层 (`mcp-client.ts`)

### Discovery Layer (`mcp-client.ts`)

发现过程由 `discoverMcpTools()` 协调，它会：

The discovery process is orchestrated by `discoverMcpTools()`, which:

1. **遍历已配置的服务器**，这些服务器来自您的 `settings.json` `mcpServers` 配置
2. **建立连接**，使用适当的传输机制（Stdio、SSE 或可流式传输的 HTTP）
3. **获取工具定义**，使用 MCP 协议从每个服务器获取
4. **净化和验证**工具模式，以确保与 Gemini API 的兼容性
5. **注册工具**到全局工具注册表，并解决冲突

1. **Iterates through configured servers** from your `settings.json` `mcpServers` configuration
2. **Establishes connections** using appropriate transport mechanisms (Stdio, SSE, or Streamable HTTP)
3. **Fetches tool definitions** from each server using the MCP protocol
4. **Sanitizes and validates** tool schemas for compatibility with the Gemini API
5. **Registers tools** in the global tool registry with conflict resolution

### 执行层 (`mcp-tool.ts`)

### Execution Layer (`mcp-tool.ts`)

每个发现的 MCP 工具都被包装在一个 `DiscoveredMCPTool` 实例中，该实例会：

Each discovered MCP tool is wrapped in a `DiscoveredMCPTool` instance that:

- **处理确认逻辑**，基于服务器信任设置和用户偏好
- **Handles confirmation logic** based on server trust settings and user preferences
- **管理工具执行**，通过使用正确的参数调用 MCP 服务器
- **Manages tool execution** by calling the MCP server with proper parameters
- **处理响应**，供 LLM 上下文和用户显示
- **Processes responses** for both the LLM context and user display
- **维护连接状态**并处理超时
- **Maintains connection state** and handles timeouts

### 传输机制

### Transport Mechanisms

Gemini CLI 支持三种 MCP 传输类型：

The Gemini CLI supports three MCP transport types:

- **Stdio 传输：** 派生一个子进程并通过 stdin/stdout 进行通信
- **Stdio Transport:** Spawns a subprocess and communicates via stdin/stdout
- **SSE 传输：** 连接到服务器发送事件 (Server-Sent Events) 端点
- **SSE Transport:** Connects to Server-Sent Events endpoints
- **可流式传输的 HTTP 传输：** 使用 HTTP 流进行通信
- **Streamable HTTP Transport:** Uses HTTP streaming for communication

## 如何设置您的 MCP 服务器

## How to set up your MCP server

Gemini CLI 使用您 `settings.json` 文件中的 `mcpServers` 配置来定位和连接到 MCP 服务器。此配置支持多个具有不同传输机制的服务器。

The Gemini CLI uses the `mcpServers` configuration in your `settings.json` file to locate and connect to MCP servers. This configuration supports multiple servers with different transport mechanisms.

### 在 settings.json 中配置 MCP 服务器

### Configure the MCP server in settings.json

您可以在全局 `~/.gemini/settings.json` 文件中配置 MCP 服务器，或者在您项目的根目录中，创建或打开 `.gemini/settings.json` 文件。在该文件中，添加 `mcpServers` 配置块。

You can configure MCP servers at the global level in the `~/.gemini/settings.json` file or in your project's root directory, create or open the `.gemini/settings.json` file. Within the file, add the `mcpServers` configuration block.

### 配置结构

### Configuration Structure

将一个 `mcpServers` 对象添加到您的 `settings.json` 文件中：

Add an `mcpServers` object to your `settings.json` file:

```json
{ // 文件包含其他配置对象
  "mcpServers": {
    "serverName": {
      "command": "path/to/server",
      "args": ["--arg1", "value1"],
      "env": {
        "API_KEY": "$MY_API_TOKEN"
      },
      "cwd": "./server-directory",
      "timeout": 30000,
      "trust": false
    }
  }
}
```

### 配置属性

### Configuration Properties

每个服务器配置支持以下属性：

Each server configuration supports the following properties:

#### 必需项（以下之一）

#### Required (one of the following)

- **`command`** (string): 用于 Stdio 传输的可执行文件路径
- **`command`** (string): Path to the executable for Stdio transport
- **`url`** (string): SSE 端点 URL (例如, `"http://localhost:8080/sse"`)
- **`url`** (string): SSE endpoint URL (e.g., `"http://localhost:8080/sse"`)
- **`httpUrl`** (string): HTTP 流端点 URL
- **`httpUrl`** (string): HTTP streaming endpoint URL

#### 可选项

#### Optional

- **`args`** (string[]): 用于 Stdio 传输的命令行参数
- **`args`** (string[]): Command-line arguments for Stdio transport
- **`headers`** (object): 使用 `url` 或 `httpUrl` 时的自定义 HTTP 标头
- **`headers`** (object): Custom HTTP headers when using `url` or `httpUrl`
- **`env`** (object): 服务器进程的环境变量。值可以使用 `$VAR_NAME` 或 `${VAR_NAME}` 语法引用环境变量
- **`env`** (object): Environment variables for the server process. Values can reference environment variables using `$VAR_NAME` or `${VAR_NAME}` syntax
- **`cwd`** (string): 用于 Stdio 传输的工作目录
- **`cwd`** (string): Working directory for Stdio transport
- **`timeout`** (number): 请求超时时间（毫秒）（默认值：600,000ms = 10 分钟）
- **`timeout`** (number): Request timeout in milliseconds (default: 600,000ms = 10 minutes)
- **`trust`** (boolean): 当为 `true` 时，绕过此服务器的所有工具调用确认（默认值：`false`）
- **`trust`** (boolean): When `true`, bypasses all tool call confirmations for this server (default: `false`)
- **`includeTools`** (string[]): 要从此 MCP 服务器包含的工具名称列表。指定后，只有此处列出的工具将从此服务器可用（白名单行为）。如果未指定，则默认启用服务器的所有工具。
- **`includeTools`** (string[]): List of tool names to include from this MCP server. When specified, only the tools listed here will be available from this server (whitelist behavior). If not specified, all tools from the server are enabled by default.
- **`excludeTools`** (string[]): 要从此 MCP 服务器排除的工具名称列表。此处列出的工具将对模型不可用，即使它们由服务器公开。**注意：** `excludeTools` 的优先级高于 `includeTools` - 如果一个工具同时在两个列表中，它将被排除。
- **`excludeTools`** (string[]): List of tool names to exclude from this MCP server. Tools listed here will not be available to the model, even if they are exposed by the server. **Note:** `excludeTools` takes precedence over `includeTools` - if a tool is in both lists, it will be excluded.

### 示例配置

### Example Configurations

#### Python MCP 服务器 (Stdio)

#### Python MCP Server (Stdio)

```json
{
  "mcpServers": {
    "pythonTools": {
      "command": "python",
      "args": ["-m", "my_mcp_server", "--port", "8080"],
      "cwd": "./mcp-servers/python",
      "env": {
        "DATABASE_URL": "$DB_CONNECTION_STRING",
        "API_KEY": "${EXTERNAL_API_KEY}"
      },
      "timeout": 15000
    }
  }
}
```

#### Node.js MCP 服务器 (Stdio)

#### Node.js MCP Server (Stdio)

```json
{
  "mcpServers": {
    "nodeServer": {
      "command": "node",
      "args": ["dist/server.js", "--verbose"],
      "cwd": "./mcp-servers/node",
      "trust": true
    }
  }
}
```

#### 基于 Docker 的 MCP 服务器

#### Docker-based MCP Server

```json
{
  "mcpServers": {
    "dockerizedServer": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "API_KEY",
        "-v",
        "${PWD}:/workspace",
        "my-mcp-server:latest"
      ],
      "env": {
        "API_KEY": "$EXTERNAL_SERVICE_TOKEN"
      }
    }
  }
}
```

#### 基于 HTTP 的 MCP 服务器

#### HTTP-based MCP Server

```json
{
  "mcpServers": {
    "httpServer": {
      "httpUrl": "http://localhost:3000/mcp",
      "timeout": 5000
    }
  }
}
```

#### 带自定义标头的基于 HTTP 的 MCP 服务器

#### HTTP-based MCP Server with Custom Headers

```json
{
  "mcpServers": {
    "httpServerWithAuth": {
      "httpUrl": "http://localhost:3000/mcp",
      "headers": {
        "Authorization": "Bearer your-api-token",
        "X-Custom-Header": "custom-value",
        "Content-Type": "application/json"
      },
      "timeout": 5000
    }
  }
}
```

#### 带工具过滤的 MCP 服务器

#### MCP Server with Tool Filtering

```json
{
  "mcpServers": {
    "filteredServer": {
      "command": "python",
      "args": ["-m", "my_mcp_server"],
      "includeTools": ["safe_tool", "file_reader", "data_processor"],
      // "excludeTools": ["dangerous_tool", "file_deleter"],
      "timeout": 30000
    }
  }
}
```

## 发现过程深入解析

## Discovery Process Deep Dive

当 Gemini CLI 启动时，它通过以下详细过程执行 MCP 服务器发现：

When the Gemini CLI starts, it performs MCP server discovery through the following detailed process:

### 1. 服务器迭代和连接

### 1. Server Iteration and Connection

对于 `mcpServers` 中配置的每个服务器：

For each configured server in `mcpServers`:

1. **状态跟踪开始：** 服务器状态设置为 `CONNECTING`
2. **传输选择：** 基于配置属性：
   - `httpUrl` → `StreamableHTTPClientTransport`
   - `url` → `SSEClientTransport`
   - `command` → `StdioClientTransport`
3. **建立连接：** MCP 客户端尝试使用配置的超时时间进行连接
4. **错误处理：** 连接失败会被记录，并且服务器状态设置为 `DISCONNECTED`

1. **Status tracking begins:** Server status is set to `CONNECTING`
2. **Transport selection:** Based on configuration properties:
   - `httpUrl` → `StreamableHTTPClientTransport`
   - `url` → `SSEClientTransport`
   - `command` → `StdioClientTransport`
3. **Connection establishment:** The MCP client attempts to connect with the configured timeout
4. **Error handling:** Connection failures are logged and the server status is set to `DISCONNECTED`

### 2. 工具发现

### 2. Tool Discovery

成功连接后：

Upon successful connection:

1. **工具列表：** 客户端调用 MCP 服务器的工具列表端点
2. **模式验证：** 验证每个工具的函数声明
3. **工具过滤：** 根据 `includeTools` 和 `excludeTools` 配置过滤工具
4. **名称净化：** 清理工具名称以满足 Gemini API 要求：
   - 无效字符（非字母数字、下划线、点、连字符）被替换为下划线
   - 超过 63 个字符的名称通过中间替换 (`___`) 进行截断

1. **Tool listing:** The client calls the MCP server's tool listing endpoint
2. **Schema validation:** Each tool's function declaration is validated
3. **Tool filtering:** Tools are filtered based on `includeTools` and `excludeTools` configuration
4. **Name sanitization:** Tool names are cleaned to meet Gemini API requirements:
   - Invalid characters (non-alphanumeric, underscore, dot, hyphen) are replaced with underscores
   - Names longer than 63 characters are truncated with middle replacement (`___`)

### 3. 冲突解决

### 3. Conflict Resolution

当多个服务器公开同名工具时：

When multiple servers expose tools with the same name:

1. **先注册者优先：** 第一个注册工具名称的服务器获得无前缀的名称
2. **自动添加前缀：** 后续的服务器获得带前缀的名称：`serverName__toolName`
3. **注册表跟踪：** 工具注册表维护服务器名称与其工具之间的映射

1. **First registration wins:** The first server to register a tool name gets the unprefixed name
2. **Automatic prefixing:** Subsequent servers get prefixed names: `serverName__toolName`
3. **Registry tracking:** The tool registry maintains mappings between server names and their tools

### 4. 模式处理

### 4. Schema Processing

工具参数模式会经过净化处理以兼容 Gemini API：

Tool parameter schemas undergo sanitization for Gemini API compatibility:

- **移除 `$schema` 属性**
- **`$schema` properties** are removed
- **剥离 `additionalProperties`**
- **`additionalProperties`** are stripped
- **移除 `anyOf` 与 `default` 组合中的默认值**（为了 Vertex AI 兼容性）
- **`anyOf` with `default`** have their default values removed (Vertex AI compatibility)
- **递归处理**应用于嵌套模式
- **Recursive processing** applies to nested schemas

### 5. 连接管理

### 5. Connection Management

发现之后：

After discovery:

- **持久连接：** 成功注册工具的服务器会保持其连接
- **Persistent connections:** Servers that successfully register tools maintain their connections
- **清理：** 未提供任何可用工具的服务器的连接将被关闭
- **Cleanup:** Servers that provide no usable tools have their connections closed
- **状态更新：** 最终服务器状态设置为 `CONNECTED` 或 `DISCONNECTED`
- **Status updates:** Final server statuses are set to `CONNECTED` or `DISCONNECTED`

## 工具执行流程

## Tool Execution Flow

当 Gemini 模型决定使用 MCP 工具时，会发生以下执行流程：

When the Gemini model decides to use an MCP tool, the following execution flow occurs:

### 1. 工具调用

### 1. Tool Invocation

模型会生成一个包含以下内容的 `FunctionCall`：

The model generates a `FunctionCall` with:

- **工具名称：** 注册的名称（可能带前缀）
- **Tool name:** The registered name (potentially prefixed)
- **参数：** 与工具参数模式匹配的 JSON 对象
- **Arguments:** JSON object matching the tool's parameter schema

### 2. 确认过程

### 2. Confirmation Process

每个 `DiscoveredMCPTool` 都实现了复杂的确认逻辑：

Each `DiscoveredMCPTool` implements sophisticated confirmation logic:

#### 基于信任的绕过

#### Trust-based Bypass

```typescript
if (this.trust) {
  return false; // 不需要确认
}
```

#### 动态允许列表

#### Dynamic Allow-listing

系统为以下内容维护内部允许列表：

The system maintains internal allow-lists for:

- **服务器级别：** `serverName` → 此服务器的所有工具都受信任
- **Server-level:** `serverName` → All tools from this server are trusted
- **工具级别：** `serverName.toolName` → 此特定工具受信任
- **Tool-level:** `serverName.toolName` → This specific tool is trusted

#### 用户选择处理

#### User Choice Handling

当需要确认时，用户可以选择：

When confirmation is required, users can choose:

- **仅执行一次：** 仅本次执行
- **Proceed once:** Execute this time only
- **始终允许此工具：** 添加到工具级别的允许列表
- **Always allow this tool:** Add to tool-level allow-list
- **始终允许此服务器：** 添加到服务器级别的允许列表
- **Always allow this server:** Add to server-level allow-list
- **取消：** 中止执行
- **Cancel:** Abort execution

### 3. 执行

### 3. Execution

确认后（或通过信任绕过）：

Upon confirmation (or trust bypass):

1. **参数准备：** 根据工具的模式验证参数
2. **MCP 调用：** 底层的 `CallableTool` 使用以下内容调用服务器：

1. **Parameter preparation:** Arguments are validated against the tool's schema
2. **MCP call:** The underlying `CallableTool` invokes the server with:

   ```typescript
   const functionCalls = [
     {
       name: this.serverToolName, // 原始服务器工具名称
       args: params,
     },
   ];
   ```

3. **响应处理：** 格式化结果以供 LLM 上下文和用户显示

3. **Response processing:** Results are formatted for both LLM context and user display

### 4. 响应处理

### 4. Response Handling

执行结果包含：

The execution result contains:

- **`llmContent`：** 用于语言模型上下文的原始响应部分
- **`llmContent`:** Raw response parts for the language model's context
- **`returnDisplay`：** 用于用户显示的格式化输出（通常是 Markdown 代码块中的 JSON）
- **`returnDisplay`:** Formatted output for user display (often JSON in markdown code blocks)

## 如何与您的 MCP 服务器交互

## How to interact with your MCP server

### 使用 `/mcp` 命令

### Using the `/mcp` Command

`/mcp` 命令提供有关您的 MCP 服务器设置的全面信息：

The `/mcp` command provides comprehensive information about your MCP server setup:

```bash
/mcp
```

这将显示：

This displays:

- **服务器列表：** 所有已配置的 MCP 服务器
- **Server list:** All configured MCP servers
- **连接状态：** `CONNECTED`、`CONNECTING` 或 `DISCONNECTED`
- **Connection status:** `CONNECTED`, `CONNECTING`, or `DISCONNECTED`
- **服务器详情：** 配置摘要（不包括敏感数据）
- **Server details:** Configuration summary (excluding sensitive data)
- **可用工具：** 每个服务器的工具列表及其描述
- **Available tools:** List of tools from each server with descriptions
- **发现状态：** 整体发现过程的状态
- **Discovery state:** Overall discovery process status

### `/mcp` 输出示例

### Example `/mcp` Output

```
MCP Servers Status:

📡 pythonTools (CONNECTED)
  Command: python -m my_mcp_server --port 8080
  Working Directory: ./mcp-servers/python
  Timeout: 15000ms
  Tools: calculate_sum, file_analyzer, data_processor

🔌 nodeServer (DISCONNECTED)
  Command: node dist/server.js --verbose
  Error: Connection refused

🐳 dockerizedServer (CONNECTED)
  Command: docker run -i --rm -e API_KEY my-mcp-server:latest
  Tools: docker__deploy, docker__status

Discovery State: COMPLETED
```

### 工具使用

### Tool Usage

一旦发现，MCP 工具就像内置工具一样可供 Gemini 模型使用。模型将自动：

Once discovered, MCP tools are available to the Gemini model like built-in tools. The model will automatically:

1. **根据您的请求选择合适的工具**
2. **Select appropriate tools** based on your requests
3. **显示确认对话框**（除非服务器受信任）
4. **Present confirmation dialogs** (unless the server is trusted)
5. **使用正确的参数执行工具**
6. **Execute tools** with proper parameters
7. **以用户友好的格式显示结果**
8. **Display results** in a user-friendly format

## 状态监控和故障排除

## Status Monitoring and Troubleshooting

### 连接状态

### Connection States

MCP 集成跟踪多种状态：

The MCP integration tracks several states:

#### 服务器状态 (`MCPServerStatus`)

#### Server Status (`MCPServerStatus`)

- **`DISCONNECTED`：** 服务器未连接或存在错误
- **`DISCONNECTED`:** Server is not connected or has errors
- **`CONNECTING`：** 正在尝试连接
- **`CONNECTING`:** Connection attempt in progress
- **`CONNECTED`：** 服务器已连接并准备就绪
- **`CONNECTED`:** Server is connected and ready

#### 发现状态 (`MCPDiscoveryState`)

#### Discovery State (`MCPDiscoveryState`)

- **`NOT_STARTED`：** 发现尚未开始
- **`NOT_STARTED`:** Discovery hasn't begun
- **`IN_PROGRESS`：** 正在发现服务器
- **`IN_PROGRESS`:** Currently discovering servers
- **`COMPLETED`：** 发现完成（无论有无错误）
- **`COMPLETED`:** Discovery finished (with or without errors)

### 常见问题与解决方案

### Common Issues and Solutions

#### 服务器无法连接

#### Server Won't Connect

**症状：** 服务器显示 `DISCONNECTED` 状态

**Symptoms:** Server shows `DISCONNECTED` status

**故障排除：**

**Troubleshooting:**

1. **检查配置：** 验证 `command`、`args` 和 `cwd` 是否正确
2. **手动测试：** 直接运行服务器命令以确保其正常工作
3. **检查依赖项：** 确保所有必需的包都已安装
4. **查看日志：** 在 CLI 输出中查找错误消息
5. **验证权限：** 确保 CLI 可以执行服务器命令

1. **Check configuration:** Verify `command`, `args`, and `cwd` are correct
2. **Test manually:** Run the server command directly to ensure it works
3. **Check dependencies:** Ensure all required packages are installed
4. **Review logs:** Look for error messages in the CLI output
5. **Verify permissions:** Ensure the CLI can execute the server command

#### 未发现任何工具

#### No Tools Discovered

**症状：** 服务器已连接但没有可用的工具

**Symptoms:** Server connects but no tools are available

**故障排除：**

**Troubleshooting:**

1. **验证工具注册：** 确保您的服务器确实注册了工具
2. **检查 MCP 协议：** 确认您的服务器正确实现了 MCP 工具列表功能
3. **查看服务器日志：** 检查 stderr 输出以查找服务器端错误
4. **测试工具列表：** 手动测试服务器的工具发现端点

1. **Verify tool registration:** Ensure your server actually registers tools
2. **Check MCP protocol:** Confirm your server implements the MCP tool listing correctly
3. **Review server logs:** Check stderr output for server-side errors
4. **Test tool listing:** Manually test your server's tool discovery endpoint

#### 工具无法执行

#### Tools Not Executing

**症状：** 工具已发现但在执行期间失败

**Symptoms:** Tools are discovered but fail during execution

**故障排除：**

**Troubleshooting:**

1. **参数验证：** 确保您的工具接受预期的参数
2. **模式兼容性：** 验证您的输入模式是有效的 JSON Schema
3. **错误处理：** 检查您的工具是否抛出未处理的异常
4. **超时问题：** 考虑增加 `timeout` 设置

1. **Parameter validation:** Ensure your tool accepts the expected parameters
2. **Schema compatibility:** Verify your input schemas are valid JSON Schema
3. **Error handling:** Check if your tool is throwing unhandled exceptions
4. **Timeout issues:** Consider increasing the `timeout` setting

#### 沙盒兼容性

#### Sandbox Compatibility

**症状：** 启用沙盒时 MCP 服务器失败

**Symptoms:** MCP servers fail when sandboxing is enabled

**解决方案：**

**Solutions:**

1. **基于 Docker 的服务器：** 使用包含所有依赖项的 Docker 容器
2. **路径可访问性：** 确保服务器可执行文件在沙盒中可用
3. **网络访问：** 配置沙盒以允许必要的网络连接
4. **环境变量：** 验证所需的环境变量已传递

1. **Docker-based servers:** Use Docker containers that include all dependencies
2. **Path accessibility:** Ensure server executables are available in the sandbox
3. **Network access:** Configure sandbox to allow necessary network connections
4. **Environment variables:** Verify required environment variables are passed through

### 调试技巧

### Debugging Tips

1. **启用调试模式：** 使用 `--debug` 运行 CLI 以获取详细输出
2. **检查 stderr：** MCP 服务器的 stderr 会被捕获并记录（INFO 消息被过滤）
3. **隔离测试：** 在集成之前独立测试您的 MCP 服务器
4. **增量设置：** 在添加复杂功能之前，从简单的工具开始
5. **频繁使用 `/mcp`：** 在开发过程中监控服务器状态

1. **Enable debug mode:** Run the CLI with `--debug` for verbose output
2. **Check stderr:** MCP server stderr is captured and logged (INFO messages filtered)
3. **Test isolation:** Test your MCP server independently before integrating
4. **Incremental setup:** Start with simple tools before adding complex functionality
5. **Use `/mcp` frequently:** Monitor server status during development

## 重要说明

## Important Notes

### 安全考虑

### Security Considerations

- **信任设置：** `trust` 选项会绕过所有确认对话框。请谨慎使用，并且仅用于您完全控制的服务器
- **Trust settings:** The `trust` option bypasses all confirmation dialogs. Use cautiously and only for servers you completely control
- **访问令牌：** 在配置包含 API 密钥或令牌的环境变量时，请注意安全性
- **Access tokens:** Be security-aware when configuring environment variables containing API keys or tokens
- **沙盒兼容性：** 使用沙盒时，请确保 MCP 服务器在沙盒环境中可用
- **Sandbox compatibility:** When using sandboxing, ensure MCP servers are available within the sandbox environment
- **私有数据：** 使用范围广泛的个人访问令牌可能导致存储库之间的信息泄露
- **Private data:** Using broadly scoped personal access tokens can lead to information leakage between repositories

### 性能和资源管理

### Performance and Resource Management

- **连接持久性：** CLI 会与成功注册工具的服务器保持持久连接
- **Connection persistence:** The CLI maintains persistent connections to servers that successfully register tools
- **自动清理：** 与不提供任何工具的服务器的连接会自动关闭
- **Automatic cleanup:** Connections to servers providing no tools are automatically closed
- **超时管理：** 根据服务器的响应特性配置适当的超时时间
- **Timeout management:** Configure appropriate timeouts based on your server's response characteristics
- **资源监控：** MCP 服务器作为独立进程运行并消耗系统资源
- **Resource monitoring:** MCP servers run as separate processes and consume system resources

### 模式兼容性

### Schema Compatibility

- **属性剥离：** 系统会自动移除某些模式属性（`$schema`、`additionalProperties`）以兼容 Gemini API
- **Property stripping:** The system automatically removes certain schema properties (`$schema`, `additionalProperties`) for Gemini API compatibility
- **名称净化：** 工具名称会自动净化以满足 API 要求
- **Name sanitization:** Tool names are automatically sanitized to meet API requirements
- **冲突解决：** 服务器之间的工具名称冲突通过自动添加前缀来解决
- **Conflict resolution:** Tool name conflicts between servers are resolved through automatic prefixing

这种全面的集成使 MCP 服务器成为扩展 Gemini CLI 功能的强大方式，同时保持了安全性、可靠性和易用性。

This comprehensive integration makes MCP servers a powerful way to extend the Gemini CLI's capabilities while maintaining security, reliability, and ease of use.
