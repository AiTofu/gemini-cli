Loaded cached credentials.
# Gemini CLI Architecture Overview

# Gemini CLI 架构概述

This document provides a high-level overview of the Gemini CLI's architecture.

本文档对 Gemini CLI 的架构进行了高级概述。

## Core components

## 核心组件

The Gemini CLI is primarily composed of two main packages, along with a suite of tools that can be used by the system in the course of handling command-line input:

Gemini CLI 主要由两个主软件包组成，以及一套系统在处理命令行输入过程中可以使用的工具：

1.  **CLI package (`packages/cli`):**
    - **Purpose:** This contains the user-facing portion of the Gemini CLI, such as handling the initial user input, presenting the final output, and managing the overall user experience.
    - **Key functions contained in the package:**
      - [Input processing](./cli/commands.md)
      - History management
      - Display rendering
      - [Theme and UI customization](./cli/themes.md)
      - [CLI configuration settings](./cli/configuration.md)

1.  **CLI 软件包 (`packages/cli`):**
    - **用途：** 此包包含 Gemini CLI 面向用户的部分，例如处理初始用户输入、呈现最终输出以及管理整体用户体验。
    - **包中包含的关键功能：**
      - [输入处理](./cli/commands.md)
      - 历史管理
      - 显示渲染
      - [主题和 UI 自定义](./cli/themes.md)
      - [CLI 配置设置](./cli/configuration.md)

2.  **Core package (`packages/core`):**
    - **Purpose:** This acts as the backend for the Gemini CLI. It receives requests sent from `packages/cli`, orchestrates interactions with the Gemini API, and manages the execution of available tools.
    - **Key functions contained in the package:**
      - API client for communicating with the Google Gemini API
      - Prompt construction and management
      - Tool registration and execution logic
      - State management for conversations or sessions
      - Server-side configuration

2.  **Core 软件包 (`packages/core`):**
    - **用途：** 此包充当 Gemini CLI 的后端。它接收从 `packages/cli` 发送的请求，协调与 Gemini API 的交互，并管理可用工具的执行。
    - **包中包含的关键功能：**
      - 用于与 Google Gemini API 通信的 API 客户端
      - 提示词构建和管理
      - 工具注册和执行逻辑
      - 对话或会话的状态管理
      - 服务器端配置

3.  **Tools (`packages/core/src/tools/`):**
    - **Purpose:** These are individual modules that extend the capabilities of the Gemini model, allowing it to interact with the local environment (e.g., file system, shell commands, web fetching).
    - **Interaction:** `packages/core` invokes these tools based on requests from the Gemini model.

3.  **工具 (`packages/core/src/tools/`):**
    - **用途：** 这些是扩展 Gemini 模型能力的独立模块，使其能够与本地环境（例如，文件系统、shell 命令、网页抓取）进行交互。
    - **交互：** `packages/core` 根据 Gemini 模型的请求调用这些工具。

## Interaction Flow

## 交互流程

A typical interaction with the Gemini CLI follows this flow:

与 Gemini CLI 的典型交互遵循以下流程：

1.  **User input:** The user types a prompt or command into the terminal, which is managed by `packages/cli`.

1.  **用户输入：** 用户在终端中输入提示或命令，该终端由 `packages/cli` 管理。

2.  **Request to core:** `packages/cli` sends the user's input to `packages/core`.

2.  **向核心包发送请求：** `packages/cli` 将用户的输入发送到 `packages/core`。

3.  **Request processed:** The core package:
    - Constructs an appropriate prompt for the Gemini API, possibly including conversation history and available tool definitions.
    - Sends the prompt to the Gemini API.

3.  **请求处理：** 核心包：
    - 为 Gemini API 构建适当的提示，可能包括对话历史和可用工具的定义。
    - 将提示发送到 Gemini API。

4.  **Gemini API response:** The Gemini API processes the prompt and returns a response. This response might be a direct answer or a request to use one of the available tools.

4.  **Gemini API 响应：** Gemini API 处理提示并返回响应。此响应可能是直接答案，也可能是使用某个可用工具的请求。

5.  **Tool execution (if applicable):**
    - When the Gemini API requests a tool, the core package prepares to execute it.
    - If the requested tool can modify the file system or execute shell commands, the user is first given details of the tool and its arguments, and the user must approve the execution.
    - Read-only operations, such as reading files, might not require explicit user confirmation to proceed.
    - Once confirmed, or if confirmation is not required, the core package executes the relevant action within the relevant tool, and the result is sent back to the Gemini API by the core package.
    - The Gemini API processes the tool result and generates a final response.

5.  **工具执行（如果适用）：**
    - 当 Gemini API 请求一个工具时，核心包准备执行它。
    - 如果请求的工具可以修改文件系统或执行 shell 命令，用户将首先获得该工具及其参数的详细信息，并且用户必须批准执行。
    - 只读操作（例如读取文件）可能不需要用户明确确认即可继续。
    - 一旦确认，或者如果不需要确认，核心包将在相关工具中执行相关操作，并将结果由核心包发送回 Gemini API。
    - Gemini API 处理工具结果并生成最终响应。

6.  **Response to CLI:** The core package sends the final response back to the CLI package.

6.  **响应 CLI：** 核心包将最终响应发送回 CLI 包。

7.  **Display to user:** The CLI package formats and displays the response to the user in the terminal.

7.  **向用户显示：** CLI 包格式化响应并在终端中向用户显示。

## Key Design Principles

## 关键设计原则

- **Modularity:** Separating the CLI (frontend) from the Core (backend) allows for independent development and potential future extensions (e.g., different frontends for the same backend).

- **模块化：** 将 CLI（前端）与核心（后端）分离，可以实现独立开发和未来可能的扩展（例如，为同一后端提供不同的前端）。

- **Extensibility:** The tool system is designed to be extensible, allowing new capabilities to be added.

- **可扩展性：** 工具系统被设计为可扩展的，允许添加新功能。

- **User experience:** The CLI focuses on providing a rich and interactive terminal experience.

- **用户体验：** CLI 专注于提供丰富和交互式的终端体验。
