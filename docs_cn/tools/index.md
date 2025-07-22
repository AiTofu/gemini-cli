Loaded cached credentials.
# Gemini CLI tools

# Gemini CLI 工具

The Gemini CLI includes built-in tools that the Gemini model uses to interact with your local environment, access information, and perform actions. These tools enhance the CLI's capabilities, enabling it to go beyond text generation and assist with a wide range of tasks.

Gemini CLI 包含内置工具，Gemini 模型可利用这些工具与您的本地环境进行交互、访问信息并执行操作。这些工具增强了 CLI 的能力，使其能够超越文本生成，协助处理各种任务。

## Overview of Gemini CLI tools

## Gemini CLI 工具概述

In the context of the Gemini CLI, tools are specific functions or modules that the Gemini model can request to be executed. For example, if you ask Gemini to "Summarize the contents of `my_document.txt`," the model will likely identify the need to read that file and will request the execution of the `read_file` tool.

在 Gemini CLI 的上下文中，工具是 Gemini 模型可以请求执行的特定函数或模块。例如，如果您要求 Gemini “总结 `my_document.txt` 的内容”，模型很可能会识别出读取该文件的需求，并请求执行 `read_file` 工具。

The core component (`packages/core`) manages these tools, presents their definitions (schemas) to the Gemini model, executes them when requested, and returns the results to the model for further processing into a user-facing response.

核心组件 (`packages/core`) 负责管理这些工具，将其定义（模式）呈现给 Gemini 模型，在收到请求时执行它们，并将结果返回给模型以进一步处理成面向用户的响应。

These tools provide the following capabilities:

这些工具提供以下能力：

- **Access local information:** Tools allow Gemini to access your local file system, read file contents, list directories, etc.
- **Execute commands:** With tools like `run_shell_command`, Gemini can run shell commands (with appropriate safety measures and user confirmation).
- **Interact with the web:** Tools can fetch content from URLs.
- **Take actions:** Tools can modify files, write new files, or perform other actions on your system (again, typically with safeguards).
- **Ground responses:** By using tools to fetch real-time or specific local data, Gemini's responses can be more accurate, relevant, and grounded in your actual context.

- **访问本地信息：** 工具允许 Gemini 访问您的本地文件系统、读取文件内容、列出目录等。
- **执行命令：** 借助 `run_shell_command` 等工具，Gemini 可以运行 shell 命令（需要有适当的安全措施和用户确认）。
- **与网络交互：** 工具可以从 URL 获取内容。
- **执行操作：** 工具可以修改文件、写入新文件或在您的系统上执行其他操作（同样，通常有安全保障措施）。
- **提供有事实依据的回答：** 通过使用工具获取实时或特定的本地数据，Gemini 的回答可以更准确、更相关，并基于您的实际情况。

## How to use Gemini CLI tools

## 如何使用 Gemini CLI 工具

To use Gemini CLI tools, provide a prompt to the Gemini CLI. The process works as follows:

要使用 Gemini CLI 工具，只需向 Gemini CLI 提供一个提示。其工作流程如下：

1.  You provide a prompt to the Gemini CLI.
2.  The CLI sends the prompt to the core.
3.  The core, along with your prompt and conversation history, sends a list of available tools and their descriptions/schemas to the Gemini API.
4.  The Gemini model analyzes your request. If it determines that a tool is needed, its response will include a request to execute a specific tool with certain parameters.
5.  The core receives this tool request, validates it, and (often after user confirmation for sensitive operations) executes the tool.
6.  The output from the tool is sent back to the Gemini model.
7.  The Gemini model uses the tool's output to formulate its final answer, which is then sent back through the core to the CLI and displayed to you.

1.  您向 Gemini CLI 提供一个提示。
2.  CLI 将提示发送到核心组件。
3.  核心组件将您的提示、对话历史记录以及可用工具列表及其描述/模式发送到 Gemini API。
4.  Gemini 模型分析您的请求。如果确定需要使用某个工具，其响应将包含一个执行特定工具并附带某些参数的请求。
5.  核心组件接收此工具请求，对其进行验证，并（通常在用户确认敏感操作后）执行该工具。
6.  工具的输出被发送回 Gemini 模型。
7.  Gemini 模型使用工具的输出来构建最终答案，然后通过核心组件传回 CLI 并显示给您。

You will typically see messages in the CLI indicating when a tool is being called and whether it succeeded or failed.

您通常会在 CLI 中看到消息，提示工具何时被调用以及调用是成功还是失败。

## Security and confirmation

## 安全与确认

Many tools, especially those that can modify your file system or execute commands (`write_file`, `edit`, `run_shell_command`), are designed with safety in mind. The Gemini CLI will typically:

许多工具，特别是那些可以修改您的文件系统或执行命令的工具（如 `write_file`, `edit`, `run_shell_command`），在设计时都考虑到了安全性。Gemini CLI 通常会：

- **Require confirmation:** Prompt you before executing potentially sensitive operations, showing you what action is about to be taken.
- **Utilize sandboxing:** All tools are subject to restrictions enforced by sandboxing (see [Sandboxing in the Gemini CLI](../sandbox.md)). This means that when operating in a sandbox, any tools (including MCP servers) you wish to use must be available _inside_ the sandbox environment. For example, to run an MCP server through `npx`, the `npx` executable must be installed within the sandbox's Docker image or be available in the `sandbox-exec` environment.

- **要求确认：** 在执行潜在的敏感操作前提示您，并显示即将执行的操作。
- **利用沙盒：** 所有工具都受到沙盒强制执行的限制（请参阅 [Gemini CLI 中的沙盒](../sandbox.md)）。这意味着，在沙盒中操作时，您希望使用的任何工具（包括 MCP 服务器）都必须在沙盒环境*内部*可用。例如，要通过 `npx` 运行 MCP 服务器，`npx` 可执行文件必须安装在沙盒的 Docker 镜像中，或者在 `sandbox-exec` 环境中可用。

It's important to always review confirmation prompts carefully before allowing a tool to proceed.

在允许工具继续执行之前，请务必仔细审查确认提示。

## Learn more about Gemini CLI's tools

## 了解更多关于 Gemini CLI 的工具

Gemini CLI's built-in tools can be broadly categorized as follows:

Gemini CLI 的内置工具可大致分为以下几类：

- **[File System Tools](./file-system.md):** For interacting with files and directories (reading, writing, listing, searching, etc.).
- **[Shell Tool](./shell.md) (`run_shell_command`):** For executing shell commands.
- **[Web Fetch Tool](./web-fetch.md) (`web_fetch`):** For retrieving content from URLs.
- **[Web Search Tool](./web-search.md) (`web_search`):** For searching the web.
- **[Multi-File Read Tool](./multi-file.md) (`read_many_files`):** A specialized tool for reading content from multiple files or directories, often used by the `@` command.
- **[Memory Tool](./memory.md) (`save_memory`):** For saving and recalling information across sessions.

- **[文件系统工具](./file-system.md)：** 用于与文件和目录交互（读取、写入、列出、搜索等）。
- **[Shell 工具](./shell.md) (`run_shell_command`)：** 用于执行 shell 命令。
- **[网页抓取工具](./web-fetch.md) (`web_fetch`)：** 用于从 URL 检索内容。
- **[网页搜索工具](./web-search.md) (`web_search`)：** 用于在网络上搜索。
- **[多文件读取工具](./multi-file.md) (`read_many_files`)：** 一种专门用于从多个文件或目录读取内容的工具，常被 `@` 命令使用。
- **[记忆工具](./memory.md) (`save_memory`)：** 用于跨会话保存和回忆信息。

Additionally, these tools incorporate:

此外，这些工具还包含：

- **[MCP servers](./mcp-server.md)**: MCP servers act as a bridge between the Gemini model and your local environment or other services like APIs.
- **[Sandboxing](../sandbox.md)**: Sandboxing isolates the model and its changes from your environment to reduce potential risk.

- **[MCP 服务器](./mcp-server.md)**：MCP 服务器充当 Gemini 模型与您的本地环境或其他服务（如 API）之间的桥梁。
- **[沙盒](../sandbox.md)**：沙盒将模型及其更改与您的环境隔离，以降低潜在风险。
