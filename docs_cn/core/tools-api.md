Loaded cached credentials.
# Gemini CLI Core: Tools API

# Gemini CLI 核心：工具 API

The Gemini CLI core (`packages/core`) features a robust system for defining, registering, and executing tools. These tools extend the capabilities of the Gemini model, allowing it to interact with the local environment, fetch web content, and perform various actions beyond simple text generation.

Gemini CLI 核心（`packages/core`）提供了一个强大的系统，用于定义、注册和执行工具。这些工具扩展了 Gemini 模型的能力，使其能够与本地环境交互、获取网络内容，并执行超越简单文本生成的各种操作。

## Core Concepts

## 核心概念

- **Tool (`tools.ts`):** An interface and base class (`BaseTool`) that defines the contract for all tools. Each tool must have:
  - `name`: A unique internal name (used in API calls to Gemini).
  - `displayName`: A user-friendly name.
  - `description`: A clear explanation of what the tool does, which is provided to the Gemini model.
  - `parameterSchema`: A JSON schema defining the parameters the tool accepts. This is crucial for the Gemini model to understand how to call the tool correctly.
  - `validateToolParams()`: A method to validate incoming parameters.
  - `getDescription()`: A method to provide a human-readable description of what the tool will do with specific parameters before execution.
  - `shouldConfirmExecute()`: A method to determine if user confirmation is required before execution (e.g., for potentially destructive operations).
  - `execute()`: The core method that performs the tool's action and returns a `ToolResult`.

- **工具 (`tools.ts`):** 一个接口和基类（`BaseTool`），定义了所有工具的契约。每个工具都必须包含：
  - `name`: 唯一的内部名称（用于对 Gemini 的 API 调用）。
  - `displayName`: 用户友好的名称。
  - `description`: 对工具功能的清晰解释，会提供给 Gemini 模型。
  - `parameterSchema`: 一个 JSON schema，定义了工具接受的参数。这对于 Gemini 模型正确理解如何调用该工具至关重要。
  - `validateToolParams()`: 一个用于验证传入参数的方法。
  - `getDescription()`: 一个在执行前提供工具将如何处理特定参数的人类可读描述的方法。
  - `shouldConfirmExecute()`: 一个用于确定执行前是否需要用户确认的方法（例如，对于潜在的破坏性操作）。
  - `execute()`: 执行工具操作并返回 `ToolResult` 的核心方法。

- **`ToolResult` (`tools.ts`):** An interface defining the structure of a tool's execution outcome:
  - `llmContent`: The factual string content to be included in the history sent back to the LLM for context.
  - `returnDisplay`: A user-friendly string (often Markdown) or a special object (like `FileDiff`) for display in the CLI.

- **`ToolResult` (`tools.ts`):** 一个定义工具执行结果结构的接口：
  - `llmContent`: 将作为上下文包含在历史记录中并发送回 LLM 的事实性字符串内容。
  - `returnDisplay`: 一个用户友好的字符串（通常是 Markdown）或一个特殊对象（如 `FileDiff`），用于在 CLI 中显示。

- **Tool Registry (`tool-registry.ts`):** A class (`ToolRegistry`) responsible for:
  - **Registering Tools:** Holding a collection of all available built-in tools (e.g., `ReadFileTool`, `ShellTool`).
  - **Discovering Tools:** It can also discover tools dynamically:
    - **Command-based Discovery:** If `toolDiscoveryCommand` is configured in settings, this command is executed. It's expected to output JSON describing custom tools, which are then registered as `DiscoveredTool` instances.
    - **MCP-based Discovery:** If `mcpServerCommand` is configured, the registry can connect to a Model Context Protocol (MCP) server to list and register tools (`DiscoveredMCPTool`).
  - **Providing Schemas:** Exposing the `FunctionDeclaration` schemas of all registered tools to the Gemini model, so it knows what tools are available and how to use them.
  - **Retrieving Tools:** Allowing the core to get a specific tool by name for execution.

- **工具注册表 (`tool-registry.ts`):** 一个类（`ToolRegistry`），负责：
  - **注册工具:** 持有所有可用的内置工具集合（例如 `ReadFileTool`, `ShellTool`）。
  - **发现工具:** 它也可以动态发现工具：
    - **基于命令的发现:** 如果在设置中配置了 `toolDiscoveryCommand`，该命令将被执行。它应输出描述自定义工具的 JSON，这些工具随后被注册为 `DiscoveredTool` 实例。
    - **基于 MCP 的发现:** 如果配置了 `mcpServerCommand`，注册表可以连接到模型上下文协议（MCP）服务器来列出并注册工具（`DiscoveredMCPTool`）。
  - **提供 Schemas:** 向 Gemini 模型暴露所有已注册工具的 `FunctionDeclaration` schemas，以便模型了解哪些工具可用以及如何使用它们。
  - **检索工具:** 允许核心按名称获取特定工具以供执行。

## Built-in Tools

## 内置工具

The core comes with a suite of pre-defined tools, typically found in `packages/core/src/tools/`. These include:

核心附带了一套预定义的工具，通常位于 `packages/core/src/tools/` 目录中。这些工具包括：

- **File System Tools:**
  - `LSTool` (`ls.ts`): Lists directory contents.
  - `ReadFileTool` (`read-file.ts`): Reads the content of a single file. It takes an `absolute_path` parameter, which must be an absolute path.
  - `WriteFileTool` (`write-file.ts`): Writes content to a file.
  - `GrepTool` (`grep.ts`): Searches for patterns in files.
  - `GlobTool` (`glob.ts`): Finds files matching glob patterns.
  - `EditTool` (`edit.ts`): Performs in-place modifications to files (often requiring confirmation).
  - `ReadManyFilesTool` (`read-many-files.ts`): Reads and concatenates content from multiple files or glob patterns (used by the `@` command in CLI).
- **Execution Tools:**
  - `ShellTool` (`shell.ts`): Executes arbitrary shell commands (requires careful sandboxing and user confirmation).
- **Web Tools:**
  - `WebFetchTool` (`web-fetch.ts`): Fetches content from a URL.
  - `WebSearchTool` (`web-search.ts`): Performs a web search.
- **Memory Tools:**
  - `MemoryTool` (`memoryTool.ts`): Interacts with the AI's memory.

- **文件系统工具:**
  - `LSTool` (`ls.ts`): 列出目录内容。
  - `ReadFileTool` (`read-file.ts`): 读取单个文件的内容。它接受一个 `absolute_path` 参数，该参数必须是绝对路径。
  - `WriteFileTool` (`write-file.ts`): 将内容写入文件。
  - `GrepTool` (`grep.ts`): 在文件中搜索模式。
  - `GlobTool` (`glob.ts`): 查找匹配 glob 模式的文件。
  - `EditTool` (`edit.ts`): 对文件进行原地修改（通常需要确认）。
  - `ReadManyFilesTool` (`read-many-files.ts`): 读取并连接来自多个文件或 glob 模式的内容（在 CLI 中由 `@` 命令使用）。
- **执行工具:**
  - `ShellTool` (`shell.ts`): 执行任意 shell 命令（需要谨慎的沙箱环境和用户确认）。
- **网络工具:**
  - `WebFetchTool` (`web-fetch.ts`): 从 URL 获取内容。
  - `WebSearchTool` (`web-search.ts`): 执行网络搜索。
- **记忆工具:**
  - `MemoryTool` (`memoryTool.ts`): 与 AI 的记忆进行交互。

Each of these tools extends `BaseTool` and implements the required methods for its specific functionality.

这些工具都扩展了 `BaseTool` 并为其特定功能实现了所需的方法。

## Tool Execution Flow

## 工具执行流程

1.  **Model Request:** The Gemini model, based on the user's prompt and the provided tool schemas, decides to use a tool and returns a `FunctionCall` part in its response, specifying the tool name and arguments.
2.  **Core Receives Request:** The core parses this `FunctionCall`.
3.  **Tool Retrieval:** It looks up the requested tool in the `ToolRegistry`.
4.  **Parameter Validation:** The tool's `validateToolParams()` method is called.
5.  **Confirmation (if needed):**
    - The tool's `shouldConfirmExecute()` method is called.
    - If it returns details for confirmation, the core communicates this back to the CLI, which prompts the user.
    - The user's decision (e.g., proceed, cancel) is sent back to the core.
6.  **Execution:** If validated and confirmed (or if no confirmation is needed), the core calls the tool's `execute()` method with the provided arguments and an `AbortSignal` (for potential cancellation).
7.  **Result Processing:** The `ToolResult` from `execute()` is received by the core.
8.  **Response to Model:** The `llmContent` from the `ToolResult` is packaged as a `FunctionResponse` and sent back to the Gemini model so it can continue generating a user-facing response.
9.  **Display to User:** The `returnDisplay` from the `ToolResult` is sent to the CLI to show the user what the tool did.

1.  **模型请求:** Gemini 模型根据用户的提示和提供的工具 schemas，决定使用一个工具，并在其响应中返回一个 `FunctionCall` 部分，指明工具名称和参数。
2.  **核心接收请求:** 核心解析这个 `FunctionCall`。
3.  **工具检索:** 它在 `ToolRegistry` 中查找请求的工具。
4.  **参数验证:** 调用工具的 `validateToolParams()` 方法。
5.  **确认（如果需要）:**
    - 调用工具的 `shouldConfirmExecute()` 方法。
    - 如果该方法返回需要确认的详细信息，核心会将其传回给 CLI，由 CLI 提示用户。
    - 用户的决定（例如，继续、取消）被发送回核心。
6.  **执行:** 如果通过验证并获得确认（或者不需要确认），核心会使用提供的参数和一个 `AbortSignal`（用于潜在的取消操作）来调用工具的 `execute()` 方法。
7.  **结果处理:** 核心接收来自 `execute()` 的 `ToolResult`。
8.  **响应模型:** 来自 `ToolResult` 的 `llmContent` 被打包成一个 `FunctionResponse` 并发送回 Gemini 模型，以便它可以继续生成面向用户的响应。
9.  **向用户显示:** 来自 `ToolResult` 的 `returnDisplay` 被发送到 CLI，以向用户展示该工具执行了什么操作。

## Extending with Custom Tools

## 使用自定义工具进行扩展

While direct programmatic registration of new tools by users isn't explicitly detailed as a primary workflow in the provided files for typical end-users, the architecture supports extension through:

尽管对于普通终端用户而言，通过编程直接注册新工具并未在所提供的文件中被明确详述为主要工作流程，但该架构支持通过以下方式进行扩展：

- **Command-based Discovery:** Advanced users or project administrators can define a `toolDiscoveryCommand` in `settings.json`. This command, when run by the Gemini CLI core, should output a JSON array of `FunctionDeclaration` objects. The core will then make these available as `DiscoveredTool` instances. The corresponding `toolCallCommand` would then be responsible for actually executing these custom tools.
- **MCP Server(s):** For more complex scenarios, one or more MCP servers can be set up and configured via the `mcpServers` setting in `settings.json`. The Gemini CLI core can then discover and use tools exposed by these servers. As mentioned, if you have multiple MCP servers, the tool names will be prefixed with the server name from your configuration (e.g., `serverAlias__actualToolName`).

- **基于命令的发现:** 高级用户或项目管理员可以在 `settings.json` 中定义一个 `toolDiscoveryCommand`。当 Gemini CLI 核心运行此命令时，它应输出一个 `FunctionDeclaration` 对象的 JSON 数组。核心随后会将这些工具作为 `DiscoveredTool` 实例提供。相应的 `toolCallCommand` 则负责实际执行这些自定义工具。
- **MCP 服务器:** 对于更复杂的场景，可以设置一个或多个 MCP 服务器，并通过 `settings.json` 中的 `mcpServers` 设置进行配置。Gemini CLI 核心随后可以发现并使用这些服务器暴露的工具。如前所述，如果您有多个 MCP 服务器，工具名称将以您配置中的服务器名称作为前缀（例如 `serverAlias__actualToolName`）。

This tool system provides a flexible and powerful way to augment the Gemini model's capabilities, making the Gemini CLI a versatile assistant for a wide range of tasks.

这个工具系统提供了一种灵活而强大的方式来增强 Gemini 模型的能力，使 Gemini CLI 成为一个能够处理广泛任务的多功能助手。
