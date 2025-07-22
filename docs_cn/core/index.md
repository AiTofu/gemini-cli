Loaded cached credentials.
# Gemini CLI Core

# Gemini CLI 核心

Gemini CLI's core package (`packages/core`) is the backend portion of Gemini CLI, handling communication with the Gemini API, managing tools, and processing requests sent from `packages/cli`. For a general overview of Gemini CLI, see the [main documentation page](../index.md).

Gemini CLI 的核心包（`packages/core`）是 Gemini CLI 的后端部分，负责与 Gemini API 通信、管理工具以及处理从 `packages/cli` 发送的请求。有关 Gemini CLI 的总体概述，请参阅[主文档页面](../index.md)。

## Navigating this section

## 浏览本节

- **[Core tools API](./tools-api.md):** Information on how tools are defined, registered, and used by the core.
- **[Memory Import Processor](./memport.md):** Documentation for the modular GEMINI.md import feature using @file.md syntax.

- **[核心工具 API](./tools-api.md):** 有关核心如何定义、注册和使用工具的信息。
- **[内存导入处理器](./memport.md):** 关于使用 @file.md 语法的模块化 GEMINI.md 导入功能的文档。

## Role of the core

## 核心的角色

While the `packages/cli` portion of Gemini CLI provides the user interface, `packages/core` is responsible for:

`packages/cli` 部分提供了 Gemini CLI 的用户界面，而 `packages/core` 则负责：

- **Gemini API interaction:** Securely communicating with the Google Gemini API, sending user prompts, and receiving model responses.
- **Prompt engineering:** Constructing effective prompts for the Gemini model, potentially incorporating conversation history, tool definitions, and instructional context from `GEMINI.md` files.
- **Tool management & orchestration:**
  - Registering available tools (e.g., file system tools, shell command execution).
  - Interpreting tool use requests from the Gemini model.
  - Executing the requested tools with the provided arguments.
  - Returning tool execution results to the Gemini model for further processing.
- **Session and state management:** Keeping track of the conversation state, including history and any relevant context required for coherent interactions.
- **Configuration:** Managing core-specific configurations, such as API key access, model selection, and tool settings.

- **Gemini API 交互：** 与 Google Gemini API 进行安全通信，发送用户提示并接收模型响应。
- **提示工程：** 为 Gemini 模型构建有效的提示，可能包含对话历史、工具定义以及来自 `GEMINI.md` 文件的指令性上下文。
- **工具管理与编排：**
  - 注册可用工具（例如，文件系统工具、shell 命令执行）。
  - 解释来自 Gemini 模型的工具使用请求。
  - 使用提供的参数执行请求的工具。
  - 将工具执行结果返回给 Gemini 模型以进行进一步处理。
- **会话和状态管理：** 跟踪对话状态，包括历史记录和连贯交互所需的任何相关上下文。
- **配置：** 管理核心特定的配置，例如 API 密钥访问、模型选择和工具设置。

## Security considerations

## 安全注意事项

The core plays a vital role in security:

核心在安全性方面扮演着至关重要的角色：

- **API key management:** It handles the `GEMINI_API_KEY` and ensures it's used securely when communicating with the Gemini API.
- **Tool execution:** When tools interact with the local system (e.g., `run_shell_command`), the core (and its underlying tool implementations) must do so with appropriate caution, often involving sandboxing mechanisms to prevent unintended modifications.

- **API 密钥管理：** 它处理 `GEMINI_API_KEY` 并确保在与 Gemini API 通信时安全使用。
- **工具执行：** 当工具与本地系统交互时（例如 `run_shell_command`），核心（及其底层的工具实现）必须谨慎操作，通常会采用沙箱机制来防止意外的修改。

## Chat history compression

## 聊天记录压缩

To ensure that long conversations don't exceed the token limits of the Gemini model, the core includes a chat history compression feature.

为确保长对话不超过 Gemini 模型的 token 限制，核心包含聊天记录压缩功能。

When a conversation approaches the token limit for the configured model, the core automatically compresses the conversation history before sending it to the model. This compression is designed to be lossless in terms of the information conveyed, but it reduces the overall number of tokens used.

当对话接近所配置模型的 token 限制时，核心会在将对话历史发送给模型之前自动对其进行压缩。这种压缩旨在无损地传达信息，同时减少使用的 token 总数。

You can find the token limits for each model in the [Google AI documentation](https://ai.google.dev/gemini-api/docs/models).

您可以在 [Google AI 文档](https://ai.google.dev/gemini-api/docs/models)中找到每个模型的 token 限制。

## Model fallback

## 模型回退

Gemini CLI includes a model fallback mechanism to ensure that you can continue to use the CLI even if the default "pro" model is rate-limited.

Gemini CLI 包含一个模型回退机制，以确保即使用户的默认 "pro" 模型受到速率限制，您仍然可以继续使用 CLI。

If you are using the default "pro" model and the CLI detects that you are being rate-limited, it automatically switches to the "flash" model for the current session. This allows you to continue working without interruption.

如果您正在使用默认的 "pro" 模型，并且 CLI 检测到您受到了速率限制，它会自动为当前会话切换到 "flash" 模型。这使您可以不间断地继续工作。

## File discovery service

## 文件发现服务

The file discovery service is responsible for finding files in the project that are relevant to the current context. It is used by the `@` command and other tools that need to access files.

文件发现服务负责在项目中查找与当前上下文相关的文​​件。`@` 命令和其他需要访问文件的工具会使用它。

## Memory discovery service

## 内存发现服务

The memory discovery service is responsible for finding and loading the `GEMINI.md` files that provide context to the model. It searches for these files in a hierarchical manner, starting from the current working directory and moving up to the project root and the user's home directory. It also searches in subdirectories.

内存发现服务负责查找并加载为模型提供上下文的 `GEMINI.md` 文件。它以分层的方式搜索这些文件，从当前工作目录开始，向上移动到项目根目录和用户的主目录。它也会在子目录中搜索。

This allows you to have global, project-level, and component-level context files, which are all combined to provide the model with the most relevant information.

这使您可以拥有全局、项目级别和组件级别的上下文文件，这些文件会组合在一起，为模型提供最相关的信息。

You can use the [`/memory` command](../cli/commands.md) to `show`, `add`, and `refresh` the content of loaded `GEMINI.md` files.

您可以使用 [`/memory` 命令](../cli/commands.md) 来 `show`（显示）、`add`（添加）和 `refresh`（刷新）已加载的 `GEMINI.md` 文件的内容。
