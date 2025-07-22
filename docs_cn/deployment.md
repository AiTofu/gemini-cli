Loaded cached credentials.
# Gemini CLI Execution and Deployment

# Gemini CLI 的执行与部署

This document describes how to run Gemini CLI and explains the deployment architecture that Gemini CLI uses.

本文档介绍如何运行 Gemini CLI，并说明其使用的部署架构。

## Running Gemini CLI

## 运行 Gemini CLI

There are several ways to run Gemini CLI. The option you choose depends on how you intend to use Gemini CLI.

有多种方式可以运行 Gemini CLI。具体选择哪种方式取决于您打算如何使用它。

---

### 1. Standard installation (Recommended for typical users)

### 1. 标准安装（推荐普通用户使用）

This is the recommended way for end-users to install Gemini CLI. It involves downloading the Gemini CLI package from the NPM registry.

这是推荐最终用户安装 Gemini CLI 的方式。该方式会从 NPM 仓库下载 Gemini CLI 软件包。

- **Global install:**

- **全局安装：**

  ```bash
  npm install -g @google/gemini-cli
  ```

  Then, run the CLI from anywhere:

  然后，您可以在任何地方运行 CLI：

  ```bash
  gemini
  ```

- **NPX execution:**

- **NPX 执行：**

  ```bash
  # Execute the latest version from NPM without a global install
  # 无需全局安装，直接从 NPM 执行最新版本
  npx @google/gemini-cli
  ```

---

### 2. Running in a sandbox (Docker/Podman)

### 2. 在沙箱中运行 (Docker/Podman)

For security and isolation, Gemini CLI can be run inside a container. This is the default way that the CLI executes tools that might have side effects.

为了安全和隔离，Gemini CLI 可以在容器内运行。这是 CLI 执行可能产生副作用的工具时的默认方式。

- **Directly from the Registry:**
  You can run the published sandbox image directly. This is useful for environments where you only have Docker and want to run the CLI.

- **直接从镜像仓库运行：**
  您可以直接运行已发布的沙箱镜像。这对于只有 Docker 并希望运行 CLI 的环境非常有用。

  ```bash
  # Run the published sandbox image
  # 运行已发布的沙箱镜像
  docker run --rm -it us-docker.pkg.dev/gemini-code-dev/gemini-cli/sandbox:0.1.1
  ```
- **Using the `--sandbox` flag:**
  If you have Gemini CLI installed locally (using the standard installation described above), you can instruct it to run inside the sandbox container.

- **使用 `--sandbox` 标志：**
  如果您在本地安装了 Gemini CLI（使用上述标准安装方式），您可以指示它在沙箱容器内运行。

  ```bash
  gemini --sandbox -y -p "your prompt here"
  ```

---

### 3. Running from source (Recommended for Gemini CLI contributors)

### 3. 从源码运行（推荐 Gemini CLI 贡献者使用）

Contributors to the project will want to run the CLI directly from the source code.

项目贡献者会希望直接从源代码运行 CLI。

- **Development Mode:**
  This method provides hot-reloading and is useful for active development.

- **开发模式：**
  此方法提供热重载功能，对日常开发非常有用。

  ```bash
  # From the root of the repository
  # 在仓库根目录运行
  npm run start
  ```
- **Production-like mode (Linked package):**
  This method simulates a global installation by linking your local package. It's useful for testing a local build in a production workflow.

- **类生产模式（链接的软件包）：**
  此方法通过链接本地软件包来模拟全局安装。这对于在生产工作流中测试本地构建版本非常有用。

  ```bash
  # Link the local cli package to your global node_modules
  # 将本地的 cli 软件包链接到您的全局 node_modules
  npm link packages/cli

  # Now you can run your local version using the `gemini` command
  # 现在您可以使用 `gemini` 命令运行您的本地版本
  gemini
  ```

---

### 4. Running the latest Gemini CLI commit from GitHub

### 4. 从 GitHub 运行最新的 Gemini CLI 提交

You can run the most recently committed version of Gemini CLI directly from the GitHub repository. This is useful for testing features still in development.

您可以直接从 GitHub 仓库运行最新提交的 Gemini CLI 版本。这对于测试仍在开发中的功能非常有用。

```bash
# Execute the CLI directly from the main branch on GitHub
# 直接从 GitHub 的 main 分支执行 CLI
npx https://github.com/google-gemini/gemini-cli
```

## Deployment architecture

## 部署架构

The execution methods described above are made possible by the following architectural components and processes:

上述执行方法得以实现，得益于以下架构组件和流程：

**NPM packages**

**NPM 软件包**

Gemini CLI project is a monorepo that publishes two core packages to the NPM registry:

Gemini CLI 项目是一个 monorepo，它向 NPM 仓库发布了两个核心软件包：

- `@google/gemini-cli-core`: The backend, handling logic and tool execution.
- `@google/gemini-cli`: The user-facing frontend.

- `@google/gemini-cli-core`：后端，处理逻辑和工具执行。
- `@google/gemini-cli`：面向用户的客户端。

These packages are used when performing the standard installation and when running Gemini CLI from the source.

在执行标准安装和从源码运行 Gemini CLI 时会使用这些软件包。

**Build and packaging processes**

**构建与打包流程**

There are two distinct build processes used, depending on the distribution channel:

根据分发渠道的不同，使用了两种不同的构建流程：

- **NPM publication:** For publishing to the NPM registry, the TypeScript source code in `@google/gemini-cli-core` and `@google/gemini-cli` is transpiled into standard JavaScript using the TypeScript Compiler (`tsc`). The resulting `dist/` directory is what gets published in the NPM package. This is a standard approach for TypeScript libraries.

- **NPM 发布：** 为了发布到 NPM 仓库，`@google/gemini-cli-core` 和 `@google/gemini-cli` 中的 TypeScript 源码会使用 TypeScript 编译器（`tsc`）转译成标准 JavaScript。最终生成的 `dist/` 目录就是发布到 NPM 软件包中的内容。这是 TypeScript 库的标准做法。

- **GitHub `npx` execution:** When running the latest version of Gemini CLI directly from GitHub, a different process is triggered by the `prepare` script in `package.json`. This script uses `esbuild` to bundle the entire application and its dependencies into a single, self-contained JavaScript file. This bundle is created on-the-fly on the user's machine and is not checked into the repository.

- **GitHub `npx` 执行：** 当直接从 GitHub 运行最新版本的 Gemini CLI 时，`package.json` 中的 `prepare` 脚本会触发一个不同的流程。该脚本使用 `esbuild` 将整个应用程序及其依赖项打包成一个独立的、自包含的 JavaScript 文件。这个包是在用户机器上即时创建的，不会提交到仓库中。

**Docker sandbox image**

**Docker 沙箱镜像**

The Docker-based execution method is supported by the `gemini-cli-sandbox` container image. This image is published to a container registry and contains a pre-installed, global version of Gemini CLI.

基于 Docker 的执行方法由 `gemini-cli-sandbox` 容器镜像支持。该镜像发布到容器仓库，并包含一个预先全局安装的 Gemini CLI 版本。

## Release process

## 发布流程

The release process is automated through GitHub Actions. The release workflow performs the following actions:

发布流程通过 GitHub Actions 自动化。发布工作流会执行以下操作：

1.  Build the NPM packages using `tsc`.
2.  Publish the NPM packages to the artifact registry.
3.  Create GitHub releases with bundled assets.

1.  使用 `tsc` 构建 NPM 软件包。
2.  将 NPM 软件包发布到制品库。
3.  创建包含打包资源的 GitHub releases。
