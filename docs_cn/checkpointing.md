Loaded cached credentials.
# Checkpointing

# 检查点

The Gemini CLI includes a Checkpointing feature that automatically saves a snapshot of your project's state before any file modifications are made by AI-powered tools. This allows you to safely experiment with and apply code changes, knowing you can instantly revert back to the state before the tool was run.

Gemini CLI 包含一个检查点（Checkpointing）功能，它会在 AI 驱动的工具对文件进行任何修改之前，自动保存你项目状态的快照。这使你可以安全地试验和应用代码更改，因为你知道可以随时即时恢复到工具运行之前的状态。

## How It Works

## 工作原理

When you approve a tool that modifies the file system (like `write_file` or `replace`), the CLI automatically creates a "checkpoint." This checkpoint includes:

当你批准一个会修改文件系统的工具（如 `write_file` 或 `replace`）时，CLI 会自动创建一个“检查点”。这个检查点包括：

1.  **A Git Snapshot:** A commit is made in a special, shadow Git repository located in your home directory (`~/.gemini/history/<project_hash>`). This snapshot captures the complete state of your project files at that moment. It does **not** interfere with your own project's Git repository.

1.  **一个 Git 快照：** 系统会在位于你主目录（`~/.gemini/history/<project_hash>`）下的一个特殊的影子 Git 仓库中创建一个 commit。这个快照捕捉了你项目文件在那一刻的完整状态。它**不会**干扰你自己的项目的 Git 仓库。

2.  **Conversation History:** The entire conversation you've had with the agent up to that point is saved.

2.  **对话历史：** 你与智能代理到那一刻为止的全部对话都会被保存下来。

3.  **The Tool Call:** The specific tool call that was about to be executed is also stored.

3.  **工具调用：** 即将被执行的具体工具调用也会被存储。

If you want to undo the change or simply go back, you can use the `/restore` command. Restoring a checkpoint will:

如果你想撤销更改或仅仅是返回上一步，你可以使用 `/restore` 命令。恢复一个检查点将会：

- Revert all files in your project to the state captured in the snapshot.
- 将你项目中的所有文件恢复到快照中捕捉的状态。

- Restore the conversation history in the CLI.
- 在 CLI 中恢复对话历史。

- Re-propose the original tool call, allowing you to run it again, modify it, or simply ignore it.
- 重新提出原始的工具调用，允许你再次运行它、修改它或直接忽略它。

All checkpoint data, including the Git snapshot and conversation history, is stored locally on your machine. The Git snapshot is stored in the shadow repository while the conversation history and tool calls are saved in a JSON file in your project's temporary directory, typically located at `~/.gemini/tmp/<project_hash>/checkpoints`.

所有的检查点数据，包括 Git 快照和对话历史，都存储在你的本地机器上。Git 快照存储在影子仓库中，而对话历史和工具调用则保存在你项目临时目录下的一个 JSON 文件中，通常位于 `~/.gemini/tmp/<project_hash>/checkpoints`。

## Enabling the Feature

## 启用该功能

The Checkpointing feature is disabled by default. To enable it, you can either use a command-line flag or edit your `settings.json` file.

检查点功能默认是禁用的。要启用它，你可以使用命令行标志或编辑你的 `settings.json` 文件。

### Using the Command-Line Flag

### 使用命令行标志

You can enable checkpointing for the current session by using the `--checkpointing` flag when starting the Gemini CLI:

你可以在启动 Gemini CLI 时使用 `--checkpointing` 标志来为当前会话启用检查点功能：

```bash
gemini --checkpointing
```

```bash
gemini --checkpointing
```

### Using the `settings.json` File

### 使用 `settings.json` 文件

To enable checkpointing by default for all sessions, you need to edit your `settings.json` file.

要为所有会话默认启用检查点功能，你需要编辑你的 `settings.json` 文件。

Add the following key to your `settings.json`:

将以下键添加到你的 `settings.json` 中：

```json
{
  "checkpointing": {
    "enabled": true
  }
}
```

```json
{
  "checkpointing": {
    "enabled": true
  }
}
```

## Using the `/restore` Command

## 使用 `/restore` 命令

Once enabled, checkpoints are created automatically. To manage them, you use the `/restore` command.

一旦启用，检查点会自动创建。要管理它们，你可以使用 `/restore` 命令。

### List Available Checkpoints

### 列出可用的检查点

To see a list of all saved checkpoints for the current project, simply run:

要查看当前项目所有已保存的检查点列表，只需运行：

```
/restore
```

```
/restore
```

The CLI will display a list of available checkpoint files. These file names are typically composed of a timestamp, the name of the file being modified, and the name of the tool that was about to be run (e.g., `2025-06-22T10-00-00_000Z-my-file.txt-write_file`).

CLI 将会显示一个可用检查点文件的列表。这些文件名通常由时间戳、被修改的文件名以及即将运行的工具名称组成（例如 `2025-06-22T10-00-00_000Z-my-file.txt-write_file`）。

### Restore a Specific Checkpoint

### 恢复指定的检查点

To restore your project to a specific checkpoint, use the checkpoint file from the list:

要将你的项目恢复到指定的检查点，请使用列表中的检查点文件：

```
/restore <checkpoint_file>
```

```
/restore <checkpoint_file>
```

For example:

例如：

```
/restore 2025-06-22T10-00-00_000Z-my-file.txt-write_file
```

```
/restore 2025-06-22T10-00-00_000Z-my-file.txt-write_file
```

After running the command, your files and conversation will be immediately restored to the state they were in when the checkpoint was created, and the original tool prompt will reappear.

运行该命令后，你的文件和对话将立即恢复到创建检查点时的状态，并且原始的工具提示将重新出现。
