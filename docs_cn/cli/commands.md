Loaded cached credentials.
# CLI Commands

# CLI 命令

Gemini CLI supports several built-in commands to help you manage your session, customize the interface, and control its behavior. These commands are prefixed with a forward slash (`/`), an at symbol (`@`), or an exclamation mark (`!`).

Gemini CLI 支持多种内置命令，可帮助您管理会话、自定义界面和控制其行为。这些命令以正斜杠 (`/`)、@ 符号 (`@`) 或感叹号 (`!`) 为前缀。

## Slash commands (`/`)

## 斜杠命令 (`/`)

Slash commands provide meta-level control over the CLI itself.

斜杠命令提供对 CLI 本身的元级别控制。

- **`/bug`**
  - **Description:** File an issue about Gemini CLI. By default, the issue is filed within the GitHub repository for Gemini CLI. The string you enter after `/bug` will become the headline for the bug being filed. The default `/bug` behavior can be modified using the `bugCommand` setting in your `.gemini/settings.json` files.
  - **描述：** 提交一个关于 Gemini CLI 的问题。默认情况下，该问题会提交到 Gemini CLI 的 GitHub 仓库中。您在 `/bug` 后输入的字符串将成为所提交 bug 的标题。可以使用 `.gemini/settings.json` 文件中的 `bugCommand` 设置来修改默认的 `/bug` 行为。

- **`/chat`**
  - **Description:** Save and resume conversation history for branching conversation state interactively, or resuming a previous state from a later session.
  - **描述：** 保存和恢复对话历史，用于交互式地分支对话状态，或在后续会话中恢复先前的状态。
  - **Sub-commands:**
  - **子命令：**
    - **`save`**
      - **Description:** Saves the current conversation history. You must add a `<tag>` for identifying the conversation state.
      - **描述：** 保存当前对话历史。您必须添加一个 `<tag>` 来标识对话状态。
      - **Usage:** `/chat save <tag>`
      - **用法：** `/chat save <tag>`
    - **`resume`**
      - **Description:** Resumes a conversation from a previous save.
      - **描述：** 从先前的保存中恢复对话。
      - **Usage:** `/chat resume <tag>`
      - **用法：** `/chat resume <tag>`
    - **`list`**
      - **Description:** Lists available tags for chat state resumption.
      - **描述：** 列出可用于恢复聊天状态的标签。

- **`/clear`**
  - **Description:** Clear the terminal screen, including the visible session history and scrollback within the CLI. The underlying session data (for history recall) might be preserved depending on the exact implementation, but the visual display is cleared.
  - **描述：** 清除终端屏幕，包括 CLI 内可见的会话历史和回滚记录。底层的会话数据（用于历史回顾）可能会根据具体实现而保留，但视觉显示会被清除。
  - **Keyboard shortcut:** Press **Ctrl+L** at any time to perform a clear action.
  - **键盘快捷键：** 随时按 **Ctrl+L** 执行清除操作。

- **`/compress`**
  - **Description:** Replace the entire chat context with a summary. This saves on tokens used for future tasks while retaining a high level summary of what has happened.
  - **描述：** 将整个聊天上下文替换为摘要。这样可以在为未来任务节省 token 的同时，保留已发生事件的高度概括性总结。

- **`/copy`**
  - **Description:** Copies the last output produced by Gemini CLI to your clipboard, for easy sharing or reuse.
  - **描述：** 将 Gemini CLI 生成的最后一次输出复制到剪贴板，以便轻松分享或重复使用。

- **`/editor`**
  - **Description:** Open a dialog for selecting supported editors.
  - **描述：** 打开一个用于选择支持的编辑器的对话框。

- **`/extensions`**
  - **Description:** Lists all active extensions in the current Gemini CLI session. See [Gemini CLI Extensions](../extension.md).
  - **描述：** 列出当前 Gemini CLI 会话中的所有活动扩展。请参阅 [Gemini CLI 扩展](../extension.md)。

- **`/help`** (or **`/?`**)
  - **Description:** Display help information about the Gemini CLI, including available commands and their usage.
  - **描述：** 显示有关 Gemini CLI 的帮助信息，包括可用命令及其用法。

- **`/mcp`**
  - **Description:** List configured Model Context Protocol (MCP) servers, their connection status, server details, and available tools.
  - **描述：** 列出已配置的 Model Context Protocol (MCP) 服务器、它们的连接状态、服务器详情以及可用的工具。
  - **Sub-commands:**
  - **子命令：**
    - **`desc`** or **`descriptions`**:
      - **Description:** Show detailed descriptions for MCP servers and tools.
      - **描述：** 显示 MCP 服务器和工具的详细描述。
    - **`nodesc`** or **`nodescriptions`**:
      - **Description:** Hide tool descriptions, showing only the tool names.
      - **描述：** 隐藏工具描述，仅显示工具名称。
    - **`schema`**:
      - **Description:** Show the full JSON schema for the tool's configured parameters.
      - **描述：** 显示工具已配置参数的完整 JSON schema。
  - **Keyboard Shortcut:** Press **Ctrl+T** at any time to toggle between showing and hiding tool descriptions.
  - **键盘快捷键：** 随时按 **Ctrl+T** 来切换显示和隐藏工具描述。

- **`/memory`**
  - **Description:** Manage the AI's instructional context (hierarchical memory loaded from `GEMINI.md` files).
  - **描述：** 管理 AI 的指令上下文（从 `GEMINI.md` 文件加载的分层内存）。
  - **Sub-commands:**
  - **子命令：**
    - **`add`**:
      - **Description:** Adds the following text to the AI's memory. Usage: `/memory add <text to remember>`
      - **描述：** 将以下文本添加到 AI 的内存中。用法：`/memory add <要记住的文本>`
    - **`show`**:
      - **Description:** Display the full, concatenated content of the current hierarchical memory that has been loaded from all `GEMINI.md` files. This lets you inspect the instructional context being provided to the Gemini model.
      - **描述：** 显示从所有 `GEMINI.md` 文件加载的当前分层内存的完整串联内容。这使您可以检查提供给 Gemini 模型的指令上下文。
    - **`refresh`**:
      - **Description:** Reload the hierarchical instructional memory from all `GEMINI.md` files found in the configured locations (global, project/ancestors, and sub-directories). This command updates the model with the latest `GEMINI.md` content.
      - **描述：** 从配置位置（全局、项目/父目录和子目录）中找到的所有 `GEMINI.md` 文件重新加载分层指令内存。此命令会使用最新的 `GEMINI.md` 内容更新模型。
    - **Note:** For more details on how `GEMINI.md` files contribute to hierarchical memory, see the [CLI Configuration documentation](./configuration.md#4-geminimd-files-hierarchical-instructional-context).
    - **注意：** 有关 `GEMINI.md` 文件如何构成层次化内存的更多详情，请参阅 [CLI 配置文档](./configuration.md#4-geminimd-files-hierarchical-instructional-context)。

- **`/restore`**
  - **Description:** Restores the project files to the state they were in just before a tool was executed. This is particularly useful for undoing file edits made by a tool. If run without a tool call ID, it will list available checkpoints to restore from.
  - **描述：** 将项目文件恢复到工具执行前的状态。这对于撤销工具所做的文件编辑特别有用。如果在没有工具调用 ID 的情况下运行，它将列出可供恢复的检查点。
  - **Usage:** `/restore [tool_call_id]`
  - **用法：** `/restore [tool_call_id]`
  - **Note:** Only available if the CLI is invoked with the `--checkpointing` option or configured via [settings](./configuration.md). See [Checkpointing documentation](../checkpointing.md) for more details.
  - **注意：** 仅当使用 `--checkpointing` 选项调用 CLI 或通过[设置](./configuration.md)进行配置时才可用。有关更多详细信息，请参阅[检查点文档](../checkpointing.md)。

- **`/stats`**
  - **Description:** Display detailed statistics for the current Gemini CLI session, including token usage, cached token savings (when available), and session duration. Note: Cached token information is only displayed when cached tokens are being used, which occurs with API key authentication but not with OAuth authentication at this time.
  - **描述：** 显示当前 Gemini CLI 会话的详细统计信息，包括 token 使用量、缓存的 token 节省量（如果可用）和会话持续时间。注意：缓存的 token 信息仅在使用缓存 token 时显示，这种情况目前发生在 API 密钥身份验证中，而不是 OAuth 身份验证中。

- [**`/theme`**](./themes.md)
  - **Description:** Open a dialog that lets you change the visual theme of Gemini CLI.
  - **描述：** 打开一个对话框，让您可以更改 Gemini CLI 的视觉主题。

- **`/auth`**
  - **Description:** Open a dialog that lets you change the authentication method.
  - **描述：** 打开一个对话框，让您可以更改身份验证方法。

- **`/about`**
  - **Description:** Show version info. Please share this information when filing issues.
  - **描述：** 显示版本信息。提交问题时请分享此信息。

- [**`/tools`**](../tools/index.md)
  - **Description:** Display a list of tools that are currently available within Gemini CLI.
  - **描述：** 显示 Gemini CLI 中当前可用的工具列表。
  - **Sub-commands:**
  - **子命令：**
    - **`desc`** or **`descriptions`**:
      - **Description:** Show detailed descriptions of each tool, including each tool's name with its full description as provided to the model.
      - **描述：** 显示每个工具的详细描述，包括每个工具的名称及其提供给模型的完整描述。
    - **`nodesc`** or **`nodescriptions`**:
      - **Description:** Hide tool descriptions, showing only the tool names.
      - **描述：** 隐藏工具描述，仅显示工具名称。

- **`/privacy`**
  - **Description:** Display the Privacy Notice and allow users to select whether they consent to the collection of their data for service improvement purposes.
  - **描述：** 显示隐私声明，并允许用户选择是否同意为改善服务而收集其数据。

- **`/quit`** (or **`/exit`**)
  - **Description:** Exit Gemini CLI.
  - **描述：** 退出 Gemini CLI。

## At commands (`@`)

## @ 命令 (`@`)

At commands are used to include the content of files or directories as part of your prompt to Gemini. These commands include git-aware filtering.

@ 命令用于将文件或目录的内容包含在您给 Gemini 的提示中。这些命令包含 git 感知过滤功能。

- **`@<path_to_file_or_directory>`**
  - **Description:** Inject the content of the specified file or files into your current prompt. This is useful for asking questions about specific code, text, or collections of files.
  - **描述：** 将指定文件或多个文件的内容注入到您当前的提示中。这对于询问有关特定代码、文本或文件集合的问题非常有用。
  - **Examples:**
  - **示例：**
    - `@path/to/your/file.txt Explain this text.`
    - `@path/to/your/file.txt 解释这段文字。`
    - `@src/my_project/ Summarize the code in this directory.`
    - `@src/my_project/ 总结这个目录中的代码。`
    - `What is this file about? @README.md`
    - `这个文件是关于什么的？ @README.md`
  - **Details:**
  - **详情：**
    - If a path to a single file is provided, the content of that file is read.
    - 如果提供了单个文件的路径，则读取该文件的内容。
    - If a path to a directory is provided, the command attempts to read the content of files within that directory and any subdirectories.
    - 如果提供了目录的路径，该命令会尝试读取该目录及其任何子目录中文件的内容。
    - Spaces in paths should be escaped with a backslash (e.g., `@My\ Documents/file.txt`).
    - 路径中的空格应使用反斜杠进行转义（例如，`@My\ Documents/file.txt`）。
    - The command uses the `read_many_files` tool internally. The content is fetched and then inserted into your query before being sent to the Gemini model.
    - 该命令在内部使用 `read_many_files` 工具。内容在发送给 Gemini 模型之前被获取并插入到您的查询中。
    - **Git-aware filtering:** By default, git-ignored files (like `node_modules/`, `dist/`, `.env`, `.git/`) are excluded. This behavior can be changed via the `fileFiltering` settings.
    - **Git 感知过滤：** 默认情况下，被 git 忽略的文件（如 `node_modules/`、`dist/`、`.env`、`.git/`）会被排除。此行为可以通过 `fileFiltering` 设置进行更改。
    - **File types:** The command is intended for text-based files. While it might attempt to read any file, binary files or very large files might be skipped or truncated by the underlying `read_many_files` tool to ensure performance and relevance. The tool indicates if files were skipped.
    - **文件类型：** 该命令主要用于基于文本的文件。虽然它可能会尝试读取任何文件，但二进制文件或非常大的文件可能会被底层的 `read_many_files` 工具跳过或截断，以确保性能和相关性。该工具会指示是否有文件被跳过。
  - **Output:** The CLI will show a tool call message indicating that `read_many_files` was used, along with a message detailing the status and the path(s) that were processed.
  - **输出：** CLI 将显示一条工具调用消息，指示已使用 `read_many_files`，并附带一条详细说明状态和已处理路径的消息。

- **`@` (Lone at symbol)**
  - **Description:** If you type a lone `@` symbol without a path, the query is passed as-is to the Gemini model. This might be useful if you are specifically talking _about_ the `@` symbol in your prompt.
  - **描述：** 如果您只输入一个独立的 `@` 符号而没有路径，查询将按原样传递给 Gemini 模型。如果您在提示中专门讨论 `@` 符号本身，这可能会很有用。

### Error handling for `@` commands

### `@` 命令的错误处理

- If the path specified after `@` is not found or is invalid, an error message will be displayed, and the query might not be sent to the Gemini model, or it will be sent without the file content.
- 如果 `@` 后指定的路径未找到或无效，将显示错误消息，并且查询可能不会发送到 Gemini 模型，或者会在没有文件内容的情况下发送。
- If the `read_many_files` tool encounters an error (e.g., permission issues), this will also be reported.
- 如果 `read_many_files` 工具遇到错误（例如，权限问题），这也会被报告。

## Shell mode & passthrough commands (`!`)

## Shell 模式和直通命令 (`!`)

The `!` prefix lets you interact with your system's shell directly from within Gemini CLI.

`!` 前缀可让您直接从 Gemini CLI 内部与系统 shell 交互。

- **`!<shell_command>`**
  - **Description:** Execute the given `<shell_command>` in your system's default shell. Any output or errors from the command are displayed in the terminal.
  - **描述：** 在系统的默认 shell 中执行给定的 `<shell_command>`。命令的任何输出或错误都会显示在终端中。
  - **Examples:**
  - **示例：**
    - `!ls -la` (executes `ls -la` and returns to Gemini CLI)
    - `!ls -la` (执行 `ls -la` 并返回到 Gemini CLI)
    - `!git status` (executes `git status` and returns to Gemini CLI)
    - `!git status` (执行 `git status` 并返回到 Gemini CLI)

- **`!` (Toggle shell mode)**
  - **Description:** Typing `!` on its own toggles shell mode.
  - **描述：** 单独输入 `!` 可切换 shell 模式。
    - **Entering shell mode:**
    - **进入 shell 模式：**
      - When active, shell mode uses a different coloring and a "Shell Mode Indicator".
      - 激活时，shell 模式会使用不同的颜色和“Shell 模式指示器”。
      - While in shell mode, text you type is interpreted directly as a shell command.
      - 在 shell 模式下，您输入的文本会直接被解释为 shell 命令。
    - **Exiting shell mode:**
    - **退出 shell 模式：**
      - When exited, the UI reverts to its standard appearance and normal Gemini CLI behavior resumes.
      - 退出后，UI 会恢复其标准外观，并恢复正常的 Gemini CLI 行为。

- **Caution for all `!` usage:** Commands you execute in shell mode have the same permissions and impact as if you ran them directly in your terminal.
- **所有 `!` 用法的注意事项：** 您在 shell 模式下执行的命令具有与直接在终端中运行它们相同的权限和影响。
