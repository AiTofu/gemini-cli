Loaded cached credentials.
# Sandboxing in the Gemini CLI

# Gemini CLI 中的沙盒化

This document provides a guide to sandboxing in the Gemini CLI, including prerequisites, quickstart, and configuration.

本文档提供了 Gemini CLI 中沙盒化功能的指南，包括先决条件、快速入门和配置。

## Prerequisites

## 先决条件

Before using sandboxing, you need to install and set up the Gemini CLI:

在使用沙盒化功能之前，您需要安装并设置 Gemini CLI：

```bash
npm install -g @google/gemini-cli
```

To verify the installation

要验证安装

```bash
gemini --version
```

## Overview of sandboxing

## 沙盒化概述

Sandboxing isolates potentially dangerous operations (such as shell commands or file modifications) from your host system, providing a security barrier between AI operations and your environment.

沙盒化将潜在的危险操作（如 shell 命令或文件修改）与您的主机系统隔离开来，在 AI 操作和您的环境之间提供了一道安全屏障。

The benefits of sandboxing include:

沙盒化的好处包括：

- **Security**: Prevent accidental system damage or data loss.
- **安全性**：防止意外的系统损坏或数据丢失。

- **Isolation**: Limit file system access to project directory.
- **隔离性**：将文件系统访问限制在项目目录内。

- **Consistency**: Ensure reproducible environments across different systems.
- **一致性**：确保在不同系统上环境的可复现性。

- **Safety**: Reduce risk when working with untrusted code or experimental commands.
- **安全性**：降低使用不受信任的代码或实验性命令时的风险。

## Sandboxing methods

## 沙盒化方法

Your ideal method of sandboxing may differ depending on your platform and your preferred container solution.

您理想的沙盒化方法可能会因您的平台和偏好的容器解决方案而异。

### 1. macOS Seatbelt (macOS only)

### 1. macOS Seatbelt (仅限 macOS)

Lightweight, built-in sandboxing using `sandbox-exec`.

使用 `sandbox-exec` 的轻量级内置沙盒化。

**Default profile**: `permissive-open` - restricts writes outside project directory but allows most other operations.

**默认配置文件**：`permissive-open` - 限制在项目目录外的写入操作，但允许大多数其他操作。

### 2. Container-based (Docker/Podman)

### 2. 基于容器 (Docker/Podman)

Cross-platform sandboxing with complete process isolation.

具有完全进程隔离的跨平台沙盒化。

**Note**: Requires building the sandbox image locally or using a published image from your organization's registry.

**注意**：需要本地构建沙盒镜像，或使用您组织镜像仓库中发布的镜像。

## Quickstart

## 快速入门

```bash
# Enable sandboxing with command flag
# 使用命令标志启用沙盒化
gemini -s -p "analyze the code structure"

# Use environment variable
# 使用环境变量
export GEMINI_SANDBOX=true
gemini -p "run the test suite"

# Configure in settings.json
# 在 settings.json 中配置
{
  "sandbox": "docker"
}
```

## Configuration

## 配置

### Enable sandboxing (in order of precedence)

### 启用沙盒化 (按优先级顺序)

1. **Command flag**: `-s` or `--sandbox`
1. **命令标志**：`-s` 或 `--sandbox`

2. **Environment variable**: `GEMINI_SANDBOX=true|docker|podman|sandbox-exec`
2. **环境变量**：`GEMINI_SANDBOX=true|docker|podman|sandbox-exec`

3. **Settings file**: `"sandbox": true` in `settings.json`
3. **设置文件**：在 `settings.json` 中设置 `"sandbox": true`

### macOS Seatbelt profiles

### macOS Seatbelt 配置文件

Built-in profiles (set via `SEATBELT_PROFILE` env var):

内置配置文件 (通过 `SEATBELT_PROFILE` 环境变量设置)：

- `permissive-open` (default): Write restrictions, network allowed
- `permissive-open` (默认)：写入限制，允许网络

- `permissive-closed`: Write restrictions, no network
- `permissive-closed`：写入限制，无网络

- `permissive-proxied`: Write restrictions, network via proxy
- `permissive-proxied`：写入限制，通过代理访问网络

- `restrictive-open`: Strict restrictions, network allowed
- `restrictive-open`：严格限制，允许网络

- `restrictive-closed`: Maximum restrictions
- `restrictive-closed`：最严格的限制

## Linux UID/GID handling

## Linux UID/GID 处理

The sandbox automatically handles user permissions on Linux. Override these permissions with:

沙盒会自动处理 Linux 上的用户权限。可以使用以下方式覆盖这些权限：

```bash
# Force host UID/GID
# 强制使用主机 UID/GID
export SANDBOX_SET_UID_GID=true
# Disable UID/GID mapping
# 禁用 UID/GID 映射
export SANDBOX_SET_UID_GID=false
```

## Troubleshooting

## 问题排查

### Common issues

### 常见问题

**"Operation not permitted"**

**“操作不允许”**

- Operation requires access outside sandbox.
- 操作需要访问沙盒外部。

- Try more permissive profile or add mount points.
- 尝试使用更宽松的配置文件或添加挂载点。

**Missing commands**

**缺少命令**

- Add to custom Dockerfile.
- 添加到自定义的 Dockerfile 中。

- Install via `sandbox.bashrc`.
- 通过 `sandbox.bashrc` 安装。

**Network issues**

**网络问题**

- Check sandbox profile allows network.
- 检查沙盒配置文件是否允许网络访问。

- Verify proxy configuration.
- 验证代理配置。

### Debug mode

### 调试模式

```bash
DEBUG=1 gemini -s -p "debug command"
```

### Inspect sandbox

### 检查沙盒

```bash
# Check environment
# 检查环境
gemini -s -p "run shell command: env | grep SANDBOX"

# List mounts
# 列出挂载点
gemini -s -p "run shell command: mount | grep workspace"
```

## Security notes

## 安全注意事项

- Sandboxing reduces but doesn't eliminate all risks.
- 沙盒化可以减少但不能消除所有风险。

- Use the most restrictive profile that allows your work.
- 使用能满足您工作需求的限制性最强的配置文件。

- Container overhead is minimal after first build.
- 首次构建后，容器的开销很小。

- GUI applications may not work in sandboxes.
- GUI 应用程序可能无法在沙盒中运行。

## Related documentation

## 相关文档

- [Configuration](./cli/configuration.md): Full configuration options.
- [配置](./cli/configuration.md)：完整的配置选项。

- [Commands](./cli/commands.md): Available commands.
- [命令](./cli/commands.md)：可用的命令。

- [Troubleshooting](./troubleshooting.md): General troubleshooting.
- [问题排查](./troubleshooting.md)：常规问题排查。
