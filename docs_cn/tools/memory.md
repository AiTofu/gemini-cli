Loaded cached credentials.
# Memory Tool (`save_memory`)

# Memory 工具 (`save_memory`)

This document describes the `save_memory` tool for the Gemini CLI.

本文档介绍了 Gemini CLI 的 `save_memory` 工具。

## Description

## 描述

Use `save_memory` to save and recall information across your Gemini CLI sessions. With `save_memory`, you can direct the CLI to remember key details across sessions, providing personalized and directed assistance.

使用 `save_memory` 可以在您的 Gemini CLI 会话之间保存和回忆信息。通过 `save_memory`，您可以指示 CLI 记住跨会话的关键细节，从而提供个性化和有针对性的帮助。

### Arguments

### 参数

`save_memory` takes one argument:

`save_memory` 接受一个参数：

- `fact` (string, required): The specific fact or piece of information to remember. This should be a clear, self-contained statement written in natural language.

- `fact` (string, 必需): 需要记住的具体事实或信息。这应该是一段用自然语言写成的清晰、独立完整的陈述。

## How to use `save_memory` with the Gemini CLI

## 如何在 Gemini CLI 中使用 `save_memory`

The tool appends the provided `fact` to a special `GEMINI.md` file located in the user's home directory (`~/.gemini/GEMINI.md`). This file can be configured to have a different name.

该工具会将提供的 `fact` 追加到一个位于用户主目录 (`~/.gemini/GEMINI.md`) 下的特殊 `GEMINI.md` 文件中。该文件可以被配置为其他名称。

Once added, the facts are stored under a `## Gemini Added Memories` section. This file is loaded as context in subsequent sessions, allowing the CLI to recall the saved information.

添加后，这些事实会存储在 `## Gemini Added Memories` 部分下。该文件会在后续会话中作为上下文加载，从而使 CLI 能够回忆起已保存的信息。

Usage:

用法:

```
save_memory(fact="Your fact here.")
```

### `save_memory` examples

### `save_memory` 示例

Remember a user preference:

记住用户偏好：

```
save_memory(fact="My preferred programming language is Python.")
```

Store a project-specific detail:

存储项目特定细节：

```
save_memory(fact="The project I'm currently working on is called 'gemini-cli'.")
```

## Important notes

## 重要说明

- **General usage:** This tool should be used for concise, important facts. It is not intended for storing large amounts of data or conversational history.

- **通用用法：** 此工具应用于记录简洁、重要的事实，不适用于存储大量数据或对话历史。

- **Memory file:** The memory file is a plain text Markdown file, so you can view and edit it manually if needed.

- **记忆文件：** 记忆文件是一个纯文本 Markdown 文件，因此您可以在需要时手动查看和编辑它。
