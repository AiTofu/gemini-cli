Loaded cached credentials.
# Web Fetch Tool (`web_fetch`)

# Web Fetch 工具 (`web_fetch`)

This document describes the `web_fetch` tool for the Gemini CLI.

本文档介绍了 Gemini CLI 的 `web_fetch` 工具。

## Description

## 描述

Use `web_fetch` to summarize, compare, or extract information from web pages. The `web_fetch` tool processes content from one or more URLs (up to 20) embedded in a prompt. `web_fetch` takes a natural language prompt and returns a generated response.

使用 `web_fetch` 可以从网页中总结、比较或提取信息。`web_fetch` 工具处理嵌入在提示中的一个或多个 URL（最多 20 个）的内容。`web_fetch` 接受自然语言提示并返回生成的响应。

### Arguments

### 参数

`web_fetch` takes one argument:

`web_fetch` 接受一个参数：

- `prompt` (string, required): A comprehensive prompt that includes the URL(s) (up to 20) to fetch and specific instructions on how to process their content. For example: `"Summarize https://example.com/article and extract key points from https://another.com/data"`. The prompt must contain at least one URL starting with `http://` or `https://`.

- `prompt` (字符串, 必需): 一个全面的提示，其中包含要抓取的 URL（最多 20 个）以及如何处理其内容的具体说明。例如：`"总结 https://example.com/article 并从 https://another.com/data 提取要点"`。提示必须包含至少一个以 `http://` 或 `https://` 开头的 URL。

## How to use `web_fetch` with the Gemini CLI

## 如何在 Gemini CLI 中使用 `web_fetch`

To use `web_fetch` with the Gemini CLI, provide a natural language prompt that contains URLs. The tool will ask for confirmation before fetching any URLs. Once confirmed, the tool will process URLs through Gemini API's `urlContext`.

要在 Gemini CLI 中使用 `web_fetch`，请提供一个包含 URL 的自然语言提示。该工具在抓取任何 URL 之前会请求确认。一旦确认，该工具将通过 Gemini API 的 `urlContext` 处理 URL。

If the Gemini API cannot access the URL, the tool will fall back to fetching content directly from the local machine. The tool will format the response, including source attribution and citations where possible. The tool will then provide the response to the user.

如果 Gemini API 无法访问该 URL，该工具将回退到直接从本地计算机抓取内容。该工具将格式化响应，在可能的情况下包含来源归属和引文。然后，该工具会将响应提供给用户。

Usage:

用法：

```
web_fetch(prompt="Your prompt, including a URL such as https://google.com.")
```

## `web_fetch` examples

## `web_fetch` 示例

Summarize a single article:

总结单篇文章：

```
web_fetch(prompt="Can you summarize the main points of https://example.com/news/latest")
```

Compare two articles:

比较两篇文章：

```
web_fetch(prompt="What are the differences in the conclusions of these two papers: https://arxiv.org/abs/2401.0001 and https://arxiv.org/abs/2401.0002?")
```

## Important notes

## 重要说明

- **URL processing:** `web_fetch` relies on the Gemini API's ability to access and process the given URLs.

- **URL 处理:** `web_fetch` 依赖于 Gemini API 访问和处理给定 URL 的能力。

- **Output quality:** The quality of the output will depend on the clarity of the instructions in the prompt.

- **输出质量:** 输出的质量将取决于提示中指令的清晰度。
