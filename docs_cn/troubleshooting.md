Loaded cached credentials.
# Troubleshooting Guide

# 故障排除指南

This guide provides solutions to common issues and debugging tips.

本指南为常见问题提供解决方案和调试技巧。

## Authentication

## 身份验证

- **Error: `Failed to login. Message: Request contains an invalid argument`**
  - Users with Google Workspace accounts, or users with Google Cloud accounts
    associated with their Gmail accounts may not be able to activate the free
    tier of the Google Code Assist plan.

- **错误：`Failed to login. Message: Request contains an invalid argument`**
  - 拥有 Google Workspace 账户的用户，或拥有与其 Gmail 账户关联的 Google Cloud 账户的用户，可能无法激活 Google Code Assist 计划的免费套餐。

  - For Google Cloud accounts, you can work around this by setting
    `GOOGLE_CLOUD_PROJECT` to your project ID.

  - 对于 Google Cloud 账户，您可以通过将 `GOOGLE_CLOUD_PROJECT` 设置为您的项目 ID 来解决此问题。

  - You can also grab an API key from [AI Studio](https://aistudio.google.com/app/apikey), which also includes a
    separate free tier.

  - 您也可以从 [AI Studio](https://aistudio.google.com/app/apikey) 获取一个 API 密钥，其中也包含一个独立的免费套餐。

## Frequently asked questions (FAQs)

## 常见问题 (FAQs)

- **Q: How do I update Gemini CLI to the latest version?**
  - A: If installed globally via npm, update Gemini CLI using the command `npm install -g @google/gemini-cli@latest`. If run from source, pull the latest changes from the repository and rebuild using `npm run build`.

- **问：如何将 Gemini CLI 更新到最新版本？**
  - 答：如果通过 npm 全局安装，请使用命令 `npm install -g @google/gemini-cli@latest` 更新 Gemini CLI。如果从源代码运行，请从代码仓库拉取最新更改并使用 `npm run build` 重新构建。

- **Q: Where are Gemini CLI configuration files stored?**
  - A: The CLI configuration is stored within two `settings.json` files: one in your home directory and one in your project's root directory. In both locations, `settings.json` is found in the `.gemini/` folder. Refer to [CLI Configuration](./cli/configuration.md) for more details.

- **问：Gemini CLI 配置文件存储在哪里？**
  - 答：CLI 配置存储在两个 `settings.json` 文件中：一个在您的主目录中，另一个在您项目的根目录中。在这两个位置，`settings.json` 都位于 `.gemini/` 文件夹内。更多详情请参阅 [CLI 配置](./cli/configuration.md)。

- **Q: Why don't I see cached token counts in my stats output?**
  - A: Cached token information is only displayed when cached tokens are being used. This feature is available for API key users (Gemini API key or Vertex AI) but not for OAuth users (Google Personal/Enterprise accounts) at this time, as the Code Assist API does not support cached content creation. You can still view your total token usage with the `/stats` command.

- **问：为什么我在统计输出中看不到缓存的 token 数量？**
  - 答：缓存的 token 信息仅在使用缓存 token 时显示。此功能目前适用于 API 密钥用户（Gemini API 密钥或 Vertex AI），但不适用于 OAuth 用户（Google 个人/企业账户），因为 Code Assist API 不支持创建缓存内容。您仍然可以使用 `/stats` 命令查看您的总 token 使用量。

## Common error messages and solutions

## 常见错误信息及解决方案

- **Error: `EADDRINUSE` (Address already in use) when starting an MCP server.**
  - **Cause:** Another process is already using the port the MCP server is trying to bind to.
  - **Solution:**
    Either stop the other process that is using the port or configure the MCP server to use a different port.

- **错误：启动 MCP 服务器时出现 `EADDRINUSE` (地址已被占用)。**
  - **原因：** 另一个进程已在使用 MCP 服务器尝试绑定的端口。
  - **解决方案：**
    停止占用该端口的其他进程，或将 MCP 服务器配置为使用不同的端口。

- **Error: Command not found (when attempting to run Gemini CLI).**
  - **Cause:** Gemini CLI is not correctly installed or not in your system's PATH.
  - **Solution:**
    1.  Ensure Gemini CLI installation was successful.
    2.  If installed globally, check that your npm global binary directory is in your PATH.
    3.  If running from source, ensure you are using the correct command to invoke it (e.g., `node packages/cli/dist/index.js ...`).

- **错误：找不到命令 (尝试运行 Gemini CLI 时)。**
  - **原因：** Gemini CLI 未正确安装或未在系统的 PATH 中。
  - **解决方案：**
    1.  确保 Gemini CLI 安装成功。
    2.  如果为全局安装，请检查您的 npm 全局二进制目录是否在您的 PATH 中。
    3.  如果从源代码运行，请确保您使用了正确的命令来调用它 (例如, `node packages/cli/dist/index.js ...`)。

- **Error: `MODULE_NOT_FOUND` or import errors.**
  - **Cause:** Dependencies are not installed correctly, or the project hasn't been built.
  - **Solution:**
    1.  Run `npm install` to ensure all dependencies are present.
    2.  Run `npm run build` to compile the project.

- **错误：`MODULE_NOT_FOUND` 或导入错误。**
  - **原因：** 依赖项未正确安装，或项目尚未构建。
  - **解决方案：**
    1.  运行 `npm install` 以确保所有依赖项都已存在。
    2.  运行 `npm run build` 来编译项目。

- **Error: "Operation not permitted", "Permission denied", or similar.**
  - **Cause:** If sandboxing is enabled, then the application is likely attempting an operation restricted by your sandbox, such as writing outside the project directory or system temp directory.
  - **Solution:** See [Sandboxing](./cli/configuration.md#sandboxing) for more information, including how to customize your sandbox configuration.

- **错误："Operation not permitted"、"Permission denied" 或类似错误。**
  - **原因：** 如果启用了沙盒模式，则应用程序可能正在尝试执行受沙盒限制的操作，例如在项目目录或系统临时目录之外进行写入。
  - **解决方案：** 请参阅 [沙盒](./cli/configuration.md#sandboxing) 了解更多信息，包括如何自定义您的沙盒配置。

- **CLI is not interactive in "CI" environments**
  - **Issue:** The CLI does not enter interactive mode (no prompt appears) if an environment variable starting with `CI_` (e.g., `CI_TOKEN`) is set. This is because the `is-in-ci` package, used by the underlying UI framework, detects these variables and assumes a non-interactive CI environment.
  - **Cause:** The `is-in-ci` package checks for the presence of `CI`, `CONTINUOUS_INTEGRATION`, or any environment variable with a `CI_` prefix. When any of these are found, it signals that the environment is non-interactive, which prevents the CLI from starting in its interactive mode.
  - **Solution:** If the `CI_` prefixed variable is not needed for the CLI to function, you can temporarily unset it for the command. e.g., `env -u CI_TOKEN gemini`

- **CLI 在 "CI" 环境中非交互**
  - **问题：** 如果设置了以 `CI_` 开头的环境变量（例如 `CI_TOKEN`），CLI 不会进入交互模式（不出现提示符）。这是因为底层的 UI 框架使用的 `is-in-ci` 包会检测到这些变量，并假定这是一个非交互式的 CI 环境。
  - **原因：** `is-in-ci` 包会检查是否存在 `CI`、`CONTINUOUS_INTEGRATION` 或任何以 `CI_` 为前缀的环境变量。当找到其中任何一个时，它会发出信号，表明环境是非交互式的，从而阻止 CLI 以交互模式启动。
  - **解决方案：** 如果 CLI 的功能不需要以 `CI_` 为前缀的变量，您可以为该命令临时取消设置该变量。例如：`env -u CI_TOKEN gemini`

## Debugging Tips

## 调试技巧

- **CLI debugging:**
  - Use the `--verbose` flag (if available) with CLI commands for more detailed output.
  - Check the CLI logs, often found in a user-specific configuration or cache directory.

- **CLI 调试：**
  - 对 CLI 命令使用 `--verbose` 标志（如果可用）以获取更详细的输出。
  - 检查 CLI 日志，通常位于用户特定的配置或缓存目录中。

- **Core debugging:**
  - Check the server console output for error messages or stack traces.
  - Increase log verbosity if configurable.
  - Use Node.js debugging tools (e.g., `node --inspect`) if you need to step through server-side code.

- **核心调试：**
  - 检查服务器控制台输出中的错误信息或堆栈跟踪。
  - 如果可配置，请提高日志详细级别。
  - 如果需要单步调试服务器端代码，请使用 Node.js 调试工具（例如 `node --inspect`）。

- **Tool issues:**
  - If a specific tool is failing, try to isolate the issue by running the simplest possible version of the command or operation the tool performs.
  - For `run_shell_command`, check that the command works directly in your shell first.
  - For file system tools, double-check paths and permissions.

- **工具问题：**
  - 如果某个特定工具失败，请尝试通过运行该工具执行的最简单版本的命令或操作来隔离问题。
  - 对于 `run_shell_command`，请先检查该命令是否能直接在您的 shell 中工作。
  - 对于文件系统工具，请仔细检查路径和权限。

- **Pre-flight checks:**
  - Always run `npm run preflight` before committing code. This can catch many common issues related to formatting, linting, and type errors.

- **飞行前检查：**
  - 在提交代码之前，请务必运行 `npm run preflight`。这可以捕获许多与格式化、代码检查和类型错误相关的常见问题。

If you encounter an issue not covered here, consider searching the project's issue tracker on GitHub or reporting a new issue with detailed information.

如果您遇到的问题未在此处涵盖，请考虑在 GitHub 上搜索项目的 issue 跟踪器，或报告一个包含详细信息的新 issue。
