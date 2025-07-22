Loaded cached credentials.
# Web Search Tool (`google_web_search`)

# Web Search 工具 (`google_web_search`)

This document describes the `google_web_search` tool.

本文档介绍了 `google_web_search` 工具。

## Description

## 描述

Use `google_web_search` to perform a web search using Google Search via the Gemini API. The `google_web_search` tool returns a summary of web results with sources.

使用 `google_web_search` 可以通过 Gemini API 调用 Google Search 来执行网页搜索。`google_web_search` 工具会返回一个包含来源信息的网页结果摘要。

### Arguments

### 参数

`google_web_search` takes one argument:

`google_web_search` 接受一个参数：

- `query` (string, required): The search query.

- `query` (string, 必需): 搜索查询。

## How to use `google_web_search` with the Gemini CLI

## 如何在 Gemini CLI 中使用 `google_web_search`

The `google_web_search` tool sends a query to the Gemini API, which then performs a web search. `google_web_search` will return a generated response based on the search results, including citations and sources.

`google_web_search` 工具会向 Gemini API 发送一个查询，然后由该 API 执行网页搜索。`google_web_search` 将根据搜索结果返回一个生成的回应，其中包含引文和来源。

Usage:

用法：

```
google_web_search(query="Your query goes here.")
```

## `google_web_search` examples

## `google_web_search` 示例

Get information on a topic:

获取关于某个主题的信息：

```
google_web_search(query="latest advancements in AI-powered code generation")
```

## Important notes

## 重要说明

- **Response returned:** The `google_web_search` tool returns a processed summary, not a raw list of search results.

- **返回的回应：** `google_web_search` 工具返回的是经过处理的摘要，而不是原始的搜索结果列表。

- **Citations:** The response includes citations to the sources used to generate the summary.

- **引文：** 回应中包含了用于生成摘要的来源引文。
