Loaded cached credentials.
# Tutorials

# 教程

This page contains tutorials for interacting with Gemini CLI.

本页包含与 Gemini CLI 交互的教程。

## Setting up a Model Context Protocol (MCP) server

## 设置模型上下文协议 (MCP) 服务器

> [!CAUTION]
> Before using a third-party MCP server, ensure you trust its source and understand the tools it provides. Your use of third-party servers is at your own risk.

> [!CAUTION]
> 在使用第三方 MCP 服务器之前，请确保您信任其来源并了解其提供的工具。使用第三方服务器的风险由您自行承担。

This tutorial demonstrates how to set up a MCP server, using the [GitHub MCP server](https://github.com/github/github-mcp-server) as an example. The GitHub MCP server provides tools for interacting with GitHub repositories, such as creating issues and commenting on pull requests.

本教程以 [GitHub MCP 服务器](https://github.com/github/github-mcp-server) 为例，演示如何设置 MCP 服务器。GitHub MCP 服务器提供了与 GitHub 仓库交互的工具，例如创建 issue 和评论 pull request。

### Prerequisites

### 前提条件

Before you begin, ensure you have the following installed and configured:

在开始之前，请确保您已安装并配置好以下内容：

- **Docker:** Install and run [Docker].
- **GitHub Personal Access Token (PAT):** Create a new [classic] or [fine-grained] PAT with the necessary scopes.

- **Docker:** 安装并运行 [Docker]。
- **GitHub 个人访问令牌 (PAT):** 创建一个新的具有必要范围的 [classic] 或 [fine-grained] PAT。

[Docker]: https://www.docker.com/
[classic]: https://github.com/settings/tokens/new
[fine-grained]: https://github.com/settings/personal-access-tokens/new

### Guide

### 指南

#### Configure the MCP server in `settings.json`

#### 在 `settings.json` 中配置 MCP 服务器

In your project's root directory, create or open the [`.gemini/settings.json` file](./configuration.md). Within the file, add the `mcpServers` configuration block, which provides instructions for how to launch the GitHub MCP server.

在您的项目根目录中，创建或打开 [`.gemini/settings.json` 文件](./configuration.md)。在该文件中，添加 `mcpServers` 配置块，其中提供了如何启动 GitHub MCP 服务器的说明。

```json
{
  "mcpServers": {
    "github": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "-e",
        "GITHUB_PERSONAL_ACCESS_TOKEN",
        "ghcr.io/github/github-mcp-server"
      ],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
      }
    }
  }
}
```

#### Set your GitHub token

#### 设置您的 GitHub 令牌

> [!CAUTION]
> Using a broadly scoped personal access token that has access to personal and private repositories can lead to information from the private repository being leaked into the public repository. We recommend using a fine-grained access token that doesn't share access to both public and private repositories.

> [!CAUTION]
> 使用范围宽泛、可同时访问个人和私有仓库的个人访问令牌，可能会导致私有仓库的信息泄露到公共仓库中。我们建议使用细粒度的访问令牌，避免共享对公共和私有仓库的访问权限。

Use an environment variable to store your GitHub PAT:

使用环境变量来存储您的 GitHub PAT：

```bash
GITHUB_PERSONAL_ACCESS_TOKEN="pat_YourActualGitHubTokenHere"
```

Gemini CLI uses this value in the `mcpServers` configuration that you defined in the `settings.json` file.

Gemini CLI 会使用您在 `settings.json` 文件中定义的 `mcpServers` 配置中的这个值。

#### Launch Gemini CLI and verify the connection

#### 启动 Gemini CLI 并验证连接

When you launch Gemini CLI, it automatically reads your configuration and launches the GitHub MCP server in the background. You can then use natural language prompts to ask Gemini CLI to perform GitHub actions. For example:

当您启动 Gemini CLI 时，它会自动读取您的配置并在后台启动 GitHub MCP 服务器。然后，您可以使用自然语言提示来要求 Gemini CLI 执行 GitHub 操作。例如：

```bash
"get all open issues assigned to me in the 'foo/bar' repo and prioritize them"
```
