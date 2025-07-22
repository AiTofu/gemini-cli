Loaded cached credentials.
# Shell Tool (`run_shell_command`)

# Shell 工具 (`run_shell_command`)

This document describes the `run_shell_command` tool for the Gemini CLI.

本文档介绍了 Gemini CLI 的 `run_shell_command` 工具。

## Description

## 描述

Use `run_shell_command` to interact with the underlying system, run scripts, or perform command-line operations. `run_shell_command` executes a given shell command. On Windows, the command will be executed with `cmd.exe /c`. On other platforms, the command will be executed with `bash -c`.

使用 `run_shell_command` 可以与底层系统交互、运行脚本或执行命令行操作。`run_shell_command` 会执行给定的 shell 命令。在 Windows 上，该命令将通过 `cmd.exe /c` 执行。在其他平台上，该命令将通过 `bash -c` 执行。

### Arguments

### 参数

`run_shell_command` takes the following arguments:

`run_shell_command` 接受以下参数：

- `command` (string, required): The exact shell command to execute.
- `description` (string, optional): A brief description of the command's purpose, which will be shown to the user.
- `directory` (string, optional): The directory (relative to the project root) in which to execute the command. If not provided, the command runs in the project root.

- `command` (string, required): 要执行的确切 shell 命令。
- `description` (string, optional): 命令用途的简要描述，将显示给用户。
- `directory` (string, optional): 执行命令的目录（相对于项目根目录）。如果未提供，命令将在项目根目录中运行。

## How to use `run_shell_command` with the Gemini CLI

## 如何在 Gemini CLI 中使用 `run_shell_command`

When using `run_shell_command`, the command is executed as a subprocess. `run_shell_command` can start background processes using `&`. The tool returns detailed information about the execution, including:

使用 `run_shell_command` 时，命令会作为一个子进程执行。`run_shell_command` 可以使用 `&` 启动后台进程。该工具会返回有关执行的详细信息，包括：

- `Command`: The command that was executed.
- `Directory`: The directory where the command was run.
- `Stdout`: Output from the standard output stream.
- `Stderr`: Output from the standard error stream.
- `Error`: Any error message reported by the subprocess.
- `Exit Code`: The exit code of the command.
- `Signal`: The signal number if the command was terminated by a signal.
- `Background PIDs`: A list of PIDs for any background processes started.

- `Command`: 已执行的命令。
- `Directory`: 命令运行所在的目录。
- `Stdout`: 标准输出流的输出。
- `Stderr`: 标准错误流的输出。
- `Error`: 子进程报告的任何错误消息。
- `Exit Code`: 命令的退出代码。
- `Signal`: 如果命令被信号终止，则为信号编号。
- `Background PIDs`: 任何已启动的后台进程的 PID 列表。

Usage:

用法：

```
run_shell_command(command="Your commands.", description="Your description of the command.", directory="Your execution directory.")
```

```
run_shell_command(command="你的命令。", description="你对命令的描述。", directory="你的执行目录。")
```

## `run_shell_command` examples

## `run_shell_command` 示例

List files in the current directory:

列出当前目录中的文件：

```
run_shell_command(command="ls -la")
```

```
run_shell_command(command="ls -la")
```

Run a script in a specific directory:

在特定目录中运行脚本：

```
run_shell_command(command="./my_script.sh", directory="scripts", description="Run my custom script")
```

```
run_shell_command(command="./my_script.sh", directory="scripts", description="运行我的自定义脚本")
```

Start a background server:

启动后台服务器：

```
run_shell_command(command="npm run dev &", description="Start development server in background")
```

```
run_shell_command(command="npm run dev &", description="在后台启动开发服务器")
```

## Important notes

## 重要说明

- **Security:** Be cautious when executing commands, especially those constructed from user input, to prevent security vulnerabilities.
- **Interactive commands:** Avoid commands that require interactive user input, as this can cause the tool to hang. Use non-interactive flags if available (e.g., `npm init -y`).
- **Error handling:** Check the `Stderr`, `Error`, and `Exit Code` fields to determine if a command executed successfully.
- **Background processes:** When a command is run in the background with `&`, the tool will return immediately and the process will continue to run in the background. The `Background PIDs` field will contain the process ID of the background process.

- **安全性：** 执行命令时要谨慎，特别是那些由用户输入构建的命令，以防止安全漏洞。
- **交互式命令：** 避免需要交互式用户输入的命令，因为这可能导致工具挂起。如果可用，请使用非交互式标志（例如 `npm init -y`）。
- **错误处理：** 检查 `Stderr`、`Error` 和 `Exit Code` 字段以确定命令是否成功执行。
- **后台进程：** 当命令使用 `&` 在后台运行时，该工具将立即返回，进程将继续在后台运行。`Background PIDs` 字段将包含后台进程的进程 ID。

## Command Restrictions

## 命令限制

You can restrict the commands that can be executed by the `run_shell_command` tool by using the `coreTools` and `excludeTools` settings in your configuration file.

你可以通过在配置文件中使用 `coreTools` 和 `excludeTools` 设置来限制 `run_shell_command` 工具可以执行的命令。

- `coreTools`: To restrict `run_shell_command` to a specific set of commands, add entries to the `coreTools` list in the format `run_shell_command(<command>)`. For example, `"coreTools": ["run_shell_command(git)"]` will only allow `git` commands. Including the generic `run_shell_command` acts as a wildcard, allowing any command not explicitly blocked.
- `excludeTools`: To block specific commands, add entries to the `excludeTools` list in the format `run_shell_command(<command>)`. For example, `"excludeTools": ["run_shell_command(rm)"]` will block `rm` commands.

- `coreTools`: 要将 `run_shell_command` 限制为一组特定的命令，请以 `run_shell_command(<command>)` 的格式向 `coreTools` 列表添加条目。例如，`"coreTools": ["run_shell_command(git)"]` 将只允许 `git` 命令。包含通用的 `run_shell_command` 可作为通配符，允许任何未被明确阻止的命令。
- `excludeTools`: 要阻止特定的命令，请以 `run_shell_command(<command>)` 的格式向 `excludeTools` 列表添加条目。例如，`"excludeTools": ["run_shell_command(rm)"]` 将阻止 `rm` 命令。

The validation logic is designed to be secure and flexible:

验证逻辑旨在安全且灵活：

1.  **Command Chaining Disabled**: The tool automatically splits commands chained with `&&`, `||`, or `;` and validates each part separately. If any part of the chain is disallowed, the entire command is blocked.
2.  **Prefix Matching**: The tool uses prefix matching. For example, if you allow `git`, you can run `git status` or `git log`.
3.  **Blocklist Precedence**: The `excludeTools` list is always checked first. If a command matches a blocked prefix, it will be denied, even if it also matches an allowed prefix in `coreTools`.

1.  **禁用命令链**：该工具会自动拆分用 `&&`、`||` 或 `;` 链接的命令，并分别验证每个部分。如果链中的任何部分被禁止，整个命令都将被阻止。
2.  **前缀匹配**：该工具使用前缀匹配。例如，如果你允许 `git`，你就可以运行 `git status` 或 `git log`。
3.  **黑名单优先**：`excludeTools` 列表总是首先被检查。如果一个命令匹配了被阻止的前缀，即使它也匹配 `coreTools` 中允许的前缀，该命令也将被拒绝。

### Command Restriction Examples

### 命令限制示例

**Allow only specific command prefixes**

**仅允许特定的命令前缀**

To allow only `git` and `npm` commands, and block all others:

要仅允许 `git` 和 `npm` 命令，并阻止所有其他命令：

```json
{
  "coreTools": ["run_shell_command(git)", "run_shell_command(npm)"]
}
```

```json
{
  "coreTools": ["run_shell_command(git)", "run_shell_command(npm)"]
}
```

- `git status`: Allowed
- `npm install`: Allowed
- `ls -l`: Blocked

- `git status`: 允许
- `npm install`: 允许
- `ls -l`: 阻止

**Block specific command prefixes**

**阻止特定的命令前缀**

To block `rm` and allow all other commands:

要阻止 `rm` 并允许所有其他命令：

```json
{
  "coreTools": ["run_shell_command"],
  "excludeTools": ["run_shell_command(rm)"]
}
```

```json
{
  "coreTools": ["run_shell_command"],
  "excludeTools": ["run_shell_command(rm)"]
}
```

- `rm -rf /`: Blocked
- `git status`: Allowed
- `npm install`: Allowed

- `rm -rf /`: 阻止
- `git status`: 允许
- `npm install`: 允许

**Blocklist takes precedence**

**黑名单优先**

If a command prefix is in both `coreTools` and `excludeTools`, it will be blocked.

如果一个命令前缀同时存在于 `coreTools` 和 `excludeTools` 中，它将被阻止。

```json
{
  "coreTools": ["run_shell_command(git)"],
  "excludeTools": ["run_shell_command(git push)"]
}
```

```json
{
  "coreTools": ["run_shell_command(git)"],
  "excludeTools": ["run_shell_command(git push)"]
}
```

- `git push origin main`: Blocked
- `git status`: Allowed

- `git push origin main`: 阻止
- `git status`: 允许

**Block all shell commands**

**阻止所有 shell 命令**

To block all shell commands, add the `run_shell_command` wildcard to `excludeTools`:

要阻止所有 shell 命令，请将 `run_shell_command` 通配符添加到 `excludeTools`：

```json
{
  "excludeTools": ["run_shell_command"]
}
```

```json
{
  "excludeTools": ["run_shell_command"]
}
```

- `ls -l`: Blocked
- `any other command`: Blocked

- `ls -l`: 阻止
- `any other command`: 阻止

## Security Note for `excludeTools`

## `excludeTools` 的安全说明

Command-specific restrictions in
`excludeTools` for `run_shell_command` are based on simple string matching and can be easily bypassed. This feature is **not a security mechanism** and should not be relied upon to safely execute untrusted code. It is recommended to use `coreTools` to explicitly select commands
that can be executed.

`excludeTools` 中针对 `run_shell_command` 的特定命令限制是基于简单的字符串匹配，可以被轻易绕过。此功能**不是一个安全机制**，不应依赖它来安全地执行不受信任的代码。建议使用 `coreTools` 来明确选择可以执行的命令。
