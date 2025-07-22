Loaded cached credentials.
# Gemini CLI file system tools

# Gemini CLI 文件系统工具

The Gemini CLI provides a comprehensive suite of tools for interacting with the local file system. These tools allow the Gemini model to read from, write to, list, search, and modify files and directories, all under your control and typically with confirmation for sensitive operations.

Gemini CLI 提供了一套全面的工具，用于与本地文件系统进行交互。这些工具允许 Gemini 模型读取、写入、列出、搜索和修改文件和目录，所有操作都在您的控制之下，并且通常会对敏感操作进行确认。

**Note:** All file system tools operate within a `rootDirectory` (usually the current working directory where you launched the CLI) for security. Paths that you provide to these tools are generally expected to be absolute or are resolved relative to this root directory.

**请注意：** 为安全起见，所有文件系统工具都在一个 `rootDirectory`（通常是您启动 CLI 时所在的当前工作目录）内运行。您提供给这些工具的路径通常应为绝对路径，或者是相对于此根目录解析的路径。

## 1. `list_directory` (ReadFolder)

## 1. `list_directory` (ReadFolder)

`list_directory` lists the names of files and subdirectories directly within a specified directory path. It can optionally ignore entries matching provided glob patterns.

`list_directory` 用于列出指定目录路径下直接包含的文件和子目录的名称。它可以选择性地忽略与提供的 glob 模式匹配的条目。

- **Tool name:** `list_directory`
- **Display name:** ReadFolder
- **File:** `ls.ts`
- **Parameters:**
  - `path` (string, required): The absolute path to the directory to list.
  - `ignore` (array of strings, optional): A list of glob patterns to exclude from the listing (e.g., `["*.log", ".git"]`).
  - `respect_git_ignore` (boolean, optional): Whether to respect `.gitignore` patterns when listing files. Defaults to `true`.
- **Behavior:**
  - Returns a list of file and directory names.
  - Indicates whether each entry is a directory.
  - Sorts entries with directories first, then alphabetically.
- **Output (`llmContent`):** A string like: `Directory listing for /path/to/your/folder:\n[DIR] subfolder1\nfile1.txt\nfile2.png`
- **Confirmation:** No.

- **工具名称：** `list_directory`
- **显示名称：** ReadFolder
- **文件：** `ls.ts`
- **参数：**
  - `path` (string, required): 要列出内容的目录的绝对路径。
  - `ignore` (array of strings, optional): 用于从列表中排除的 glob 模式列表（例如 `["*.log", ".git"]`）。
  - `respect_git_ignore` (boolean, optional): 在列出文件时是否遵循 `.gitignore` 模式。默认为 `true`。
- **行为：**
  - 返回文件和目录名称的列表。
  - 指明每个条目是否为目录。
  - 对条目进行排序，目录在前，然后按字母顺序排序。
- **输出 (`llmContent`):** 类似这样的字符串：`Directory listing for /path/to/your/folder:\n[DIR] subfolder1\nfile1.txt\nfile2.png`
- **确认：** 否。

## 2. `read_file` (ReadFile)

## 2. `read_file` (ReadFile)

`read_file` reads and returns the content of a specified file. This tool handles text, images (PNG, JPG, GIF, WEBP, SVG, BMP), and PDF files. For text files, it can read specific line ranges. Other binary file types are generally skipped.

`read_file` 用于读取并返回指定文件的内容。该工具支持文本、图片（PNG, JPG, GIF, WEBP, SVG, BMP）和 PDF 文件。对于文本文件，它可以读取特定的行范围。其他二进制文件类型通常会被跳过。

- **Tool name:** `read_file`
- **Display name:** ReadFile
- **File:** `read-file.ts`
- **Parameters:**
  - `path` (string, required): The absolute path to the file to read.
  - `offset` (number, optional): For text files, the 0-based line number to start reading from. Requires `limit` to be set.
  - `limit` (number, optional): For text files, the maximum number of lines to read. If omitted, reads a default maximum (e.g., 2000 lines) or the entire file if feasible.
- **Behavior:**
  - For text files: Returns the content. If `offset` and `limit` are used, returns only that slice of lines. Indicates if content was truncated due to line limits or line length limits.
  - For image and PDF files: Returns the file content as a base64-encoded data structure suitable for model consumption.
  - For other binary files: Attempts to identify and skip them, returning a message indicating it's a generic binary file.
- **Output:** (`llmContent`):
  - For text files: The file content, potentially prefixed with a truncation message (e.g., `[File content truncated: showing lines 1-100 of 500 total lines...]\nActual file content...`).
  - For image/PDF files: An object containing `inlineData` with `mimeType` and base64 `data` (e.g., `{ inlineData: { mimeType: 'image/png', data: 'base64encodedstring' } }`).
  - For other binary files: A message like `Cannot display content of binary file: /path/to/data.bin`.
- **Confirmation:** No.

- **工具名称：** `read_file`
- **显示名称：** ReadFile
- **文件：** `read-file.ts`
- **参数：**
  - `path` (string, required): 要读取的文件的绝对路径。
  - `offset` (number, optional): 对于文本文件，指定从哪一行开始读取（0-based 索引）。需要同时设置 `limit`。
  - `limit` (number, optional): 对于文本文件，指定要读取的最大行数。如果省略，则读取默认的最大行数（例如 2000 行）或整个文件（如果可行）。
- **行为：**
  - 对于文本文件：返回文件内容。如果使用了 `offset` 和 `limit`，则仅返回该行范围的内容。会指明内容是否因行数限制或行长限制而被截断。
  - 对于图片和 PDF 文件：以 base64 编码的数据结构返回文件内容，以便模型使用。
  - 对于其他二进制文件：尝试识别并跳过它们，返回一条消息，指明其为通用二进制文件。
- **输出:** (`llmContent`):
  - 对于文本文件：文件内容，可能会带有一个截断消息前缀（例如 `[File content truncated: showing lines 1-100 of 500 total lines...]\nActual file content...`）。
  - 对于图片/PDF 文件：一个包含 `inlineData` 的对象，其中含有 `mimeType` 和 base64 `data`（例如 `{ inlineData: { mimeType: 'image/png', data: 'base64encodedstring' } }`）。
  - 对于其他二进制文件：类似 `Cannot display content of binary file: /path/to/data.bin` 的消息。
- **确认：** 否。

## 3. `write_file` (WriteFile)

## 3. `write_file` (WriteFile)

`write_file` writes content to a specified file. If the file exists, it will be overwritten. If the file doesn't exist, it (and any necessary parent directories) will be created.

`write_file` 用于将内容写入指定文件。如果文件已存在，其内容将被覆盖。如果文件不存在，则会创建该文件（以及任何必要的父目录）。

- **Tool name:** `write_file`
- **Display name:** WriteFile
- **File:** `write-file.ts`
- **Parameters:**
  - `file_path` (string, required): The absolute path to the file to write to.
  - `content` (string, required): The content to write into the file.
- **Behavior:**
  - Writes the provided `content` to the `file_path`.
  - Creates parent directories if they don't exist.
- **Output (`llmContent`):** A success message, e.g., `Successfully overwrote file: /path/to/your/file.txt` or `Successfully created and wrote to new file: /path/to/new/file.txt`.
- **Confirmation:** Yes. Shows a diff of changes and asks for user approval before writing.

- **工具名称：** `write_file`
- **显示名称：** WriteFile
- **文件：** `write-file.ts`
- **参数：**
  - `file_path` (string, required): 要写入的文件的绝对路径。
  - `content` (string, required): 要写入文件的内容。
- **行为：**
  - 将提供的 `content` 写入到 `file_path`。
  - 如果父目录不存在，则会创建它们。
- **输出 (`llmContent`):** 成功消息，例如 `Successfully overwrote file: /path/to/your/file.txt` 或 `Successfully created and wrote to new file: /path/to/new/file.txt`。
- **确认：** 是。在写入前会显示更改的 diff，并请求用户批准。

## 4. `glob` (FindFiles)

## 4. `glob` (FindFiles)

`glob` finds files matching specific glob patterns (e.g., `src/**/*.ts`, `*.md`), returning absolute paths sorted by modification time (newest first).

`glob` 用于查找匹配特定 glob 模式（例如 `src/**/*.ts`, `*.md`）的文件，并返回按修改时间排序（最新在前）的绝对路径。

- **Tool name:** `glob`
- **Display name:** FindFiles
- **File:** `glob.ts`
- **Parameters:**
  - `pattern` (string, required): The glob pattern to match against (e.g., `"*.py"`, `"src/**/*.js"`).
  - `path` (string, optional): The absolute path to the directory to search within. If omitted, searches the tool's root directory.
  - `case_sensitive` (boolean, optional): Whether the search should be case-sensitive. Defaults to `false`.
  - `respect_git_ignore` (boolean, optional): Whether to respect .gitignore patterns when finding files. Defaults to `true`.
- **Behavior:**
  - Searches for files matching the glob pattern within the specified directory.
  - Returns a list of absolute paths, sorted with the most recently modified files first.
  - Ignores common nuisance directories like `node_modules` and `.git` by default.
- **Output (`llmContent`):** A message like: `Found 5 file(s) matching "*.ts" within src, sorted by modification time (newest first):\nsrc/file1.ts\nsrc/subdir/file2.ts...`
- **Confirmation:** No.

- **工具名称：** `glob`
- **显示名称：** FindFiles
- **文件：** `glob.ts`
- **参数：**
  - `pattern` (string, required): 用于匹配的 glob 模式（例如 `"*.py"`, `"src/**/*.js"`）。
  - `path` (string, optional): 要在其中搜索的目录的绝对路径。如果省略，则在工具的根目录中搜索。
  - `case_sensitive` (boolean, optional): 搜索是否应区分大小写。默认为 `false`。
  - `respect_git_ignore` (boolean, optional): 查找文件时是否遵循 .gitignore 模式。默认为 `true`。
- **行为：**
  - 在指定目录内搜索匹配 glob 模式的文件。
  - 返回一个绝对路径列表，按最近修改时间排序（最新在前）。
  - 默认忽略 `node_modules` 和 `.git` 等常见干扰目录。
- **输出 (`llmContent`):** 类似这样的消息：`Found 5 file(s) matching "*.ts" within src, sorted by modification time (newest first):\nsrc/file1.ts\nsrc/subdir/file2.ts...`
- **确认：** 否。

## 5. `search_file_content` (SearchText)

## 5. `search_file_content` (SearchText)

`search_file_content` searches for a regular expression pattern within the content of files in a specified directory. Can filter files by a glob pattern. Returns the lines containing matches, along with their file paths and line numbers.

`search_file_content` 用于在指定目录的文件内容中搜索正则表达式模式。可以通过 glob 模式筛选文件。返回包含匹配项的行，以及它们的文件路径和行号。

- **Tool name:** `search_file_content`
- **Display name:** SearchText
- **File:** `grep.ts`
- **Parameters:**
  - `pattern` (string, required): The regular expression (regex) to search for (e.g., `"function\s+myFunction"`).
  - `path` (string, optional): The absolute path to the directory to search within. Defaults to the current working directory.
  - `include` (string, optional): A glob pattern to filter which files are searched (e.g., `"*.js"`, `"src/**/*.{ts,tsx}"`). If omitted, searches most files (respecting common ignores).
- **Behavior:**
  - Uses `git grep` if available in a Git repository for speed, otherwise falls back to system `grep` or a JavaScript-based search.
  - Returns a list of matching lines, each prefixed with its file path (relative to the search directory) and line number.
- **Output (`llmContent`):** A formatted string of matches, e.g.:
  ```
  Found 3 matches for pattern "myFunction" in path "." (filter: "*.ts"):
  ---
  File: src/utils.ts
  L15: export function myFunction() {
  L22:   myFunction.call();
  ---
  File: src/index.ts
  L5: import { myFunction } from './utils';
  ---
  ```
- **Confirmation:** No.

- **工具名称：** `search_file_content`
- **显示名称：** SearchText
- **文件：** `grep.ts`
- **参数：**
  - `pattern` (string, required): 要搜索的正则表达式 (regex)（例如 `"function\s+myFunction"`）。
  - `path` (string, optional): 要在其中搜索的目录的绝对路径。默认为当前工作目录。
  - `include` (string, optional): 用于筛选要搜索的文件的 glob 模式（例如 `"*.js"`, `"src/**/*.{ts,tsx}"`）。如果省略，则搜索大多数文件（遵循常见的忽略规则）。
- **行为：**
  - 如果在 Git 仓库中可用，则使用 `git grep` 以提高速度，否则回退到系统 `grep` 或基于 JavaScript 的搜索。
  - 返回一个匹配行列表，每行都带有其文件路径（相对于搜索目录）和行号前缀。
- **输出 (`llmContent`):** 格式化的匹配字符串，例如：
  ```
  在路径 "." (过滤器: "*.ts") 中找到 3 个匹配 "myFunction" 模式的结果:
  ---
  文件: src/utils.ts
  L15: export function myFunction() {
  L22:   myFunction.call();
  ---
  文件: src/index.ts
  L5: import { myFunction } from './utils';
  ---
  ```
- **确认：** 否。

## 6. `replace` (Edit)

## 6. `replace` (Edit)

`replace` replaces text within a file. By default, replaces a single occurrence, but can replace multiple occurrences when `expected_replacements` is specified. This tool is designed for precise, targeted changes and requires significant context around the `old_string` to ensure it modifies the correct location.

`replace` 用于替换文件中的文本。默认情况下，它只替换单个匹配项，但当指定 `expected_replacements` 时，可以替换多个匹配项。此工具专为精确、有针对性的更改而设计，并要求在 `old_string` 周围提供大量上下文，以确保在正确的位置进行修改。

- **Tool name:** `replace`
- **Display name:** Edit
- **File:** `edit.ts`
- **Parameters:**
  - `file_path` (string, required): The absolute path to the file to modify.
  - `old_string` (string, required): The exact literal text to replace.

    **CRITICAL:** This string must uniquely identify the single instance to change. It should include at least 3 lines of context _before_ and _after_ the target text, matching whitespace and indentation precisely. If `old_string` is empty, the tool attempts to create a new file at `file_path` with `new_string` as content.

  - `new_string` (string, required): The exact literal text to replace `old_string` with.
  - `expected_replacements` (number, optional): The number of occurrences to replace. Defaults to `1`.

- **Behavior:**
  - If `old_string` is empty and `file_path` does not exist, creates a new file with `new_string` as content.
  - If `old_string` is provided, it reads the `file_path` and attempts to find exactly one occurrence of `old_string`.
  - If one occurrence is found, it replaces it with `new_string`.
  - **Enhanced Reliability (Multi-Stage Edit Correction):** To significantly improve the success rate of edits, especially when the model-provided `old_string` might not be perfectly precise, the tool incorporates a multi-stage edit correction mechanism.
    - If the initial `old_string` isn't found or matches multiple locations, the tool can leverage the Gemini model to iteratively refine `old_string` (and potentially `new_string`).
    - This self-correction process attempts to identify the unique segment the model intended to modify, making the `replace` operation more robust even with slightly imperfect initial context.
- **Failure conditions:** Despite the correction mechanism, the tool will fail if:
  - `file_path` is not absolute or is outside the root directory.
  - `old_string` is not empty, but the `file_path` does not exist.
  - `old_string` is empty, but the `file_path` already exists.
  - `old_string` is not found in the file after attempts to correct it.
  - `old_string` is found multiple times, and the self-correction mechanism cannot resolve it to a single, unambiguous match.
- **Output (`llmContent`):**
  - On success: `Successfully modified file: /path/to/file.txt (1 replacements).` or `Created new file: /path/to/new_file.txt with provided content.`
  - On failure: An error message explaining the reason (e.g., `Failed to edit, 0 occurrences found...`, `Failed to edit, expected 1 occurrences but found 2...`).
- **Confirmation:** Yes. Shows a diff of the proposed changes and asks for user approval before writing to the file.

- **工具名称：** `replace`
- **显示名称：** Edit
- **文件：** `edit.ts`
- **参数：**
  - `file_path` (string, required): 要修改的文件的绝对路径。
  - `old_string` (string, required): 要替换的精确字面文本。

    **关键：** 此字符串必须唯一标识要更改的单个实例。它应至少包含目标文本之前和之后的 3 行上下文，并精确匹配空白和缩进。如果 `old_string` 为空，该工具会尝试在 `file_path` 创建一个新文件，内容为 `new_string`。

  - `new_string` (string, required): 用于替换 `old_string` 的精确字面文本。
  - `expected_replacements` (number, optional): 要替换的匹配项数量。默认为 `1`。

- **行为：**
  - 如果 `old_string` 为空且 `file_path` 不存在，则创建一个新文件，内容为 `new_string`。
  - 如果提供了 `old_string`，它会读取 `file_path` 并尝试查找 `old_string` 的唯一一个匹配项。
  - 如果找到一个匹配项，则将其替换为 `new_string`。
  - **增强的可靠性（多阶段编辑校正）：** 为了显著提高编辑的成功率，特别是当模型提供的 `old_string` 可能不够精确时，该工具集成了一个多阶段编辑校正机制。
    - 如果初始的 `old_string` 未找到或匹配到多个位置，该工具可以利用 Gemini 模型来迭代优化 `old_string`（以及可能的 `new_string`）。
    - 这个自我校正过程会尝试识别模型意图修改的唯一片段，即使在初始上下文稍有不完美的情况下，也能使 `replace` 操作更加稳健。
- **失败条件：** 尽管有校正机制，但在以下情况下工具仍会失败：
  - `file_path` 不是绝对路径或位于根目录之外。
  - `old_string` 不为空，但 `file_path` 不存在。
  - `old_string` 为空，但 `file_path` 已存在。
  - 在尝试校正后，文件中仍未找到 `old_string`。
  - `old_string` 被找到多次，且自我校正机制无法将其解析为单个、明确的匹配项。
- **输出 (`llmContent`):**
  - 成功时：`Successfully modified file: /path/to/file.txt (1 replacements).` 或 `Created new file: /path/to/new_file.txt with provided content.`
  - 失败时：解释原因的错误消息（例如 `Failed to edit, 0 occurrences found...`, `Failed to edit, expected 1 occurrences but found 2...`）。
- **确认：** 是。在写入文件前，会显示建议更改的 diff 并请求用户批准。

These file system tools provide a foundation for the Gemini CLI to understand and interact with your local project context.

这些文件系统工具为 Gemini CLI 理解和与您的本地项目上下文进行交互提供了基础。

