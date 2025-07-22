Loaded cached credentials.
# Welcome to Gemini CLI documentation

# 欢迎来到 Gemini CLI 文档

This documentation provides a comprehensive guide to installing, using, and developing Gemini CLI. This tool lets you interact with Gemini models through a command-line interface.

本指南将全面介绍如何安装、使用和开发 Gemini CLI。该工具让您可以通过命令行界面与 Gemini 模型进行交互。

## Overview

## 概览

Gemini CLI brings the capabilities of Gemini models to your terminal in an interactive Read-Eval-Print Loop (REPL) environment. Gemini CLI consists of a client-side application (`packages/cli`) that communicates with a local server (`packages/core`), which in turn manages requests to the Gemini API and its AI models. Gemini CLI also contains a variety of tools for tasks such as performing file system operations, running shells, and web fetching, which are managed by `packages/core`.

Gemini CLI 以交互式“读取-求值-打印”循环（REPL）环境，将 Gemini 模型的功能带到您的终端。Gemini CLI 由一个客户端应用程序（`packages/cli`）和一个本地服务器（`packages/core`）组成。客户端与服务器通信，后者负责管理对 Gemini API 及其 AI 模型的请求。Gemini CLI 还包含多种工具，用于执行文件系统操作、运行 shell 和获取网页内容等任务，这些工具由 `packages/core` 管理。

## Navigating the documentation

## 文档导览

This documentation is organized into the following sections:

本文档包含以下几个部分：

- **[Execution and Deployment](./deployment.md):** Information for running Gemini CLI.

- **[执行与部署](./deployment.md):** 运行 Gemini CLI 的相关信息。

- **[Architecture Overview](./architecture.md):** Understand the high-level design of Gemini CLI, including its components and how they interact.

- **[架构概览](./architecture.md):** 了解 Gemini CLI 的高层设计，包括其组件以及它们之间的交互方式。

- **CLI Usage:** Documentation for `packages/cli`.

- **CLI 用法:** `packages/cli` 的相关文档。

  - **[CLI Introduction](./cli/index.md):** Overview of the command-line interface.

  - **[CLI 简介](./cli/index.md):** 命令行界面概览。

  - **[Commands](./cli/commands.md):** Description of available CLI commands.

  - **[命令](./cli/commands.md):** 可用 CLI 命令的说明。

  - **[Configuration](./cli/configuration.md):** Information on configuring the CLI.

  - **[配置](./cli/configuration.md):** 有关配置 CLI 的信息。

  - **[Checkpointing](./checkpointing.md):** Documentation for the checkpointing feature.

  - **[检查点](./checkpointing.md):** 检查点功能的文档。

  - **[Extensions](./extension.md):** How to extend the CLI with new functionality.

  - **[扩展](./extension.md):** 如何通过新功能扩展 CLI。

  - **[Telemetry](./telemetry.md):** Overview of telemetry in the CLI.

  - **[遥测](./telemetry.md):** CLI 中的遥测功能概览。

- **Core Details:** Documentation for `packages/core`.

- **核心详情:** `packages/core` 的相关文档。

  - **[Core Introduction](./core/index.md):** Overview of the core component.

  - **[核心简介](./core/index.md):** 核心组件概览。

  - **[Tools API](./core/tools-api.md):** Information on how the core manages and exposes tools.

  - **[工具 API](./core/tools-api.md):** 有关核心如何管理和公开工具的信息。

- **Tools:**

- **工具:**

  - **[Tools Overview](./tools/index.md):** Overview of the available tools.

  - **[工具概览](./tools/index.md):** 可用工具概览。

  - **[File System Tools](./tools/file-system.md):** Documentation for the `read_file` and `write_file` tools.

  - **[文件系统工具](./tools/file-system.md):** `read_file` 和 `write_file` 工具的文档。

  - **[Multi-File Read Tool](./tools/multi-file.md):** Documentation for the `read_many_files` tool.

  - **[多文件读取工具](./tools/multi-file.md):** `read_many_files` 工具的文档。

  - **[Shell Tool](./tools/shell.md):** Documentation for the `run_shell_command` tool.

  - **[Shell 工具](./tools/shell.md):** `run_shell_command` 工具的文档。

  - **[Web Fetch Tool](./tools/web-fetch.md):** Documentation for the `web_fetch` tool.

  - **[网页抓取工具](./tools/web-fetch.md):** `web_fetch` 工具的文档。

  - **[Web Search Tool](./tools/web-search.md):** Documentation for the `google_web_search` tool.

  - **[网页搜索工具](./tools/web-search.md):** `google_web_search` 工具的文档。

  - **[Memory Tool](./tools/memory.md):** Documentation for the `save_memory` tool.

  - **[记忆工具](./tools/memory.md):** `save_memory` 工具的文档。

- **[Contributing & Development Guide](../CONTRIBUTING.md):** Information for contributors and developers, including setup, building, testing, and coding conventions.

- **[贡献与开发指南](../CONTRIBUTING.md):** 为贡献者和开发者提供的信息，包括设置、构建、测试和编码规范。

- **[NPM Workspaces and Publishing](./npm.md):** Details on how the project's packages are managed and published.

- **[NPM Workspaces 与发布](./npm.md):** 关于项目包如何管理和发布的详细信息。

- **[Troubleshooting Guide](./troubleshooting.md):** Find solutions to common problems and FAQs.

- **[问题排查指南](./troubleshooting.md):** 查找常见问题的解决方案和常见问题解答。

- **[Terms of Service and Privacy Notice](./tos-privacy.md):** Information on the terms of service and privacy notices applicable to your use of Gemini CLI.

- **[服务条款和隐私声明](./tos-privacy.md):** 适用于您使用 Gemini CLI 的服务条款和隐私声明信息。

We hope this documentation helps you make the most of the Gemini CLI!

我们希望这份文档能帮助您充分利用 Gemini CLI！
