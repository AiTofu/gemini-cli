Loaded cached credentials.
# Gemini CLI

在 Gemini CLI 中，`packages/cli` 是供用户发送和接收带有 Gemini AI 模型及其相关工具的提示的前端。有关 Gemini CLI 的总体概述，请参阅[主文档页面](../index.md)。

## Navigating this section

## 浏览本节

- **[Authentication](./authentication.md):** A guide to setting up authentication with Google's AI services.
- **[身份验证](./authentication.md):** 设置 Google AI 服务身份验证的指南。

- **[Commands](./commands.md):** A reference for Gemini CLI commands (e.g., `/help`, `/tools`, `/theme`).
- **[命令](./commands.md):** Gemini CLI 命令（例如 `/help`、`/tools`、`/theme`）的参考。

- **[Configuration](./configuration.md):** A guide to tailoring Gemini CLI behavior using configuration files.
- **[配置](./configuration.md):** 使用配置文件定制 Gemini CLI 行为的指南。

- **[Token Caching](./token-caching.md):** Optimize API costs through token caching.
- **[令牌缓存](./token-caching.md):** 通过令牌缓存优化 API 成本。

- **[Themes](./themes.md)**: A guide to customizing the CLI's appearance with different themes.
- **[主题](./themes.md)**: 使用不同主题自定义 CLI 外观的指南。

- **[Tutorials](tutorials.md)**: A tutorial showing how to use Gemini CLI to automate a development task.
- **[教程](tutorials.md)**: 演示如何使用 Gemini CLI 自动执行开发任务的教程。

## Non-interactive mode

## 非交互模式

Gemini CLI can be run in a non-interactive mode, which is useful for scripting and automation. In this mode, you pipe input to the CLI, it executes the command, and then it exits.

Gemini CLI 可以在非交互模式下运行，这对于脚本编写和自动化非常有用。在此模式下，您将输入通过管道传递给 CLI，它会执行命令，然后退出。

The following example pipes a command to Gemini CLI from your terminal:

以下示例将一个命令从您的终端通过管道传递给 Gemini CLI：

```bash
echo "What is fine tuning?" | gemini
```

Gemini CLI executes the command and prints the output to your terminal. Note that you can achieve the same behavior by using the `--prompt` or `-p` flag. For example:

Gemini CLI 执行该命令并将输出打印到您的终端。请注意，您可以使用 `--prompt` 或 `-p` 标志实现相同的行为。例如：

```bash
gemini -p "What is fine tuning?"
```
