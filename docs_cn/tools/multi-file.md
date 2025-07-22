Loaded cached credentials.
# Multi File Read Tool (`read_many_files`)

# 多文件读取工具 (`read_many_files`)

This document describes the `read_many_files` tool for the Gemini CLI.

本文档介绍了 Gemini CLI 的 `read_many_files` 工具。

## Description

## 描述

Use `read_many_files` to read content from multiple files specified by paths or glob patterns. The behavior of this tool depends on the provided files:

使用 `read_many_files` 可以通过路径或 glob 模式读取多个文件的内容。该工具的行为取决于所提供的文件：

- For text files, this tool concatenates their content into a single string.
- For image (e.g., PNG, JPEG), PDF, audio (MP3, WAV), and video (MP4, MOV) files, it reads and returns them as base64-encoded data, provided they are explicitly requested by name or extension.

- 对于文本文件，该工具会将其内容拼接成一个单一的字符串。
- 对于图像（如 PNG、JPEG）、PDF、音频（MP3、WAV）和视频（MP4、MOV）文件，如果通过文件名或扩展名明确请求，该工具会读取并以 base64 编码的数据形式返回它们。

`read_many_files` can be used to perform tasks such as getting an overview of a codebase, finding where specific functionality is implemented, reviewing documentation, or gathering context from multiple configuration files.

`read_many_files` 可用于执行诸如获取代码库概览、查找特定功能的实现位置、审阅文档或从多个配置文件中收集上下文等任务。

### Arguments

### 参数

`read_many_files` takes the following arguments:

`read_many_files` 接受以下参数：

- `paths` (list[string], required): An array of glob patterns or paths relative to the tool's target directory (e.g., `["src/**/*.ts"]`, `["README.md", "docs/", "assets/logo.png"]`).
- `exclude` (list[string], optional): Glob patterns for files/directories to exclude (e.g., `["**/*.log", "temp/"]`). These are added to default excludes if `useDefaultExcludes` is true.
- `include` (list[string], optional): Additional glob patterns to include. These are merged with `paths` (e.g., `["*.test.ts"]` to specifically add test files if they were broadly excluded, or `["images/*.jpg"]` to include specific image types).
- `recursive` (boolean, optional): Whether to search recursively. This is primarily controlled by `**` in glob patterns. Defaults to `true`.
- `useDefaultExcludes` (boolean, optional): Whether to apply a list of default exclusion patterns (e.g., `node_modules`, `.git`, non image/pdf binary files). Defaults to `true`.
- `respect_git_ignore` (boolean, optional): Whether to respect .gitignore patterns when finding files. Defaults to true.

- `paths` (list[string], 必需): 一个相对于工具目标目录的 glob 模式或路径数组（例如 `["src/**/*.ts"]`, `["README.md", "docs/", "assets/logo.png"]`）。
- `exclude` (list[string], 可选): 用于排除文件/目录的 glob 模式（例如 `["**/*.log", "temp/"]`）。如果 `useDefaultExcludes` 为 true，这些模式会添加到默认排除项中。
- `include` (list[string], 可选): 额外的 glob 模式以包含文件。这些模式会与 `paths` 合并（例如，使用 `["*.test.ts"]` 来特别添加被广泛排除的测试文件，或使用 `["images/*.jpg"]` 来包含特定的图像类型）。
- `recursive` (boolean, 可选): 是否递归搜索。这主要由 glob 模式中的 `**` 控制。默认为 `true`。
- `useDefaultExcludes` (boolean, 可选): 是否应用默认的排除模式列表（例如 `node_modules`, `.git`, 非图像/PDF 的二进制文件）。默认为 `true`。
- `respect_git_ignore` (boolean, 可选): 查找文件时是否遵循 .gitignore 模式。默认为 true。

## How to use `read_many_files` with the Gemini CLI

## 如何在 Gemini CLI 中使用 `read_many_files`

`read_many_files` searches for files matching the provided `paths` and `include` patterns, while respecting `exclude` patterns and default excludes (if enabled).

`read_many_files` 会搜索匹配所提供 `paths` 和 `include` 模式的文件，同时遵循 `exclude` 模式和默认排除项（如果启用）。

- For text files: it reads the content of each matched file (attempting to skip binary files not explicitly requested as image/PDF) and concatenates it into a single string, with a separator `--- {filePath} ---` between the content of each file. Uses UTF-8 encoding by default.
- For image and PDF files: if explicitly requested by name or extension (e.g., `paths: ["logo.png"]` or `include: ["*.pdf"]`), the tool reads the file and returns its content as a base64 encoded string.
- The tool attempts to detect and skip other binary files (those not matching common image/PDF types or not explicitly requested) by checking for null bytes in their initial content.

- 对于文本文件：它会读取每个匹配文件的内容（尝试跳过未明确请求为图像/PDF 的二进制文件），并将其拼接成一个单一的字符串，每个文件内容之间用分隔符 `--- {filePath} ---` 隔开。默认使用 UTF-8 编码。
- 对于图像和 PDF 文件：如果通过文件名或扩展名明确请求（例如 `paths: ["logo.png"]` 或 `include: ["*.pdf"]`），该工具会读取文件并将其内容以 base64 编码的字符串形式返回。
- 该工具会尝试通过检查文件初始内容中的空字节（null bytes）来检测并跳过其他二进制文件（那些不匹配常见图像/PDF 类型或未被明确请求的文件）。

Usage:

用法：

```
read_many_files(paths=["Your files or paths here."], include=["Additional files to include."], exclude=["Files to exclude."], recursive=False, useDefaultExcludes=false, respect_git_ignore=true)
```

```
read_many_files(paths=["此处填写你的文件或路径。"], include=["要额外包含的文件。"], exclude=["要排除的文件。"], recursive=False, useDefaultExcludes=false, respect_git_ignore=true)
```

## `read_many_files` examples

## `read_many_files` 示例

Read all TypeScript files in the `src` directory:

读取 `src` 目录下的所有 TypeScript 文件：

```
read_many_files(paths=["src/**/*.ts"])
```

```
read_many_files(paths=["src/**/*.ts"])
```

Read the main README, all Markdown files in the `docs` directory, and a specific logo image, excluding a specific file:

读取主 README、`docs` 目录下的所有 Markdown 文件以及一个特定的徽标图像，同时排除一个特定文件：

```
read_many_files(paths=["README.md", "docs/**/*.md", "assets/logo.png"], exclude=["docs/OLD_README.md"])
```

```
read_many_files(paths=["README.md", "docs/**/*.md", "assets/logo.png"], exclude=["docs/OLD_README.md"])
```

Read all JavaScript files but explicitly including test files and all JPEGs in an `images` folder:

读取所有 JavaScript 文件，但明确包含测试文件和 `images` 文件夹中的所有 JPEG 文件：

```
read_many_files(paths=["**/*.js"], include=["**/*.test.js", "images/**/*.jpg"], useDefaultExcludes=False)
```

```
read_many_files(paths=["**/*.js"], include=["**/*.test.js", "images/**/*.jpg"], useDefaultExcludes=False)
```

## Important notes

## 重要说明

- **Binary file handling:**
  - **Image/PDF/Audio/Video files:** The tool can read common image types (PNG, JPEG, etc.), PDF, audio (mp3, wav), and video (mp4, mov) files, returning them as base64 encoded data. These files _must_ be explicitly targeted by the `paths` or `include` patterns (e.g., by specifying the exact filename like `video.mp4` or a pattern like `*.mov`).
  - **Other binary files:** The tool attempts to detect and skip other types of binary files by examining their initial content for null bytes. The tool excludes these files from its output.
- **Performance:** Reading a very large number of files or very large individual files can be resource-intensive.
- **Path specificity:** Ensure paths and glob patterns are correctly specified relative to the tool's target directory. For image/PDF files, ensure the patterns are specific enough to include them.
- **Default excludes:** Be aware of the default exclusion patterns (like `node_modules`, `.git`) and use `useDefaultExcludes=False` if you need to override them, but do so cautiously.

- **二进制文件处理：**
  - **图像/PDF/音频/视频文件：** 该工具可以读取常见的图像类型（PNG、JPEG 等）、PDF、音频（mp3、wav）和视频（mp4、mov）文件，并以 base64 编码的数据形式返回。这些文件*必须*通过 `paths` 或 `include` 模式被明确指定（例如，通过指定确切的文件名如 `video.mp4` 或模式如 `*.mov`）。
  - **其他二进制文件：** 该工具会尝试通过检查其初始内容中的空字节（null bytes）来检测并跳过其他类型的二进制文件。该工具会从其输出中排除这些文件。
- **性能：** 读取大量文件或非常大的单个文件可能会消耗大量资源。
- **路径明确性：** 确保路径和 glob 模式是相对于工具的目标目录正确指定的。对于图像/PDF 文件，确保模式足够具体以包含它们。
- **默认排除项：** 请注意默认的排除模式（如 `node_modules`, `.git`），如果需要覆盖它们，请使用 `useDefaultExcludes=False`，但要谨慎操作。
